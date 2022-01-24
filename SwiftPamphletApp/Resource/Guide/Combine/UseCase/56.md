网络URLSession.dataTaskPublisher使用例子如下：
```swift
let req = URLRequest(url: URL(string: "http://www.starming.com")!)
let dpPublisher = URLSession.shared.dataTaskPublisher(for: req)
```

一个请求Github接口并展示结果的例子
```swift
//
// CombineSearchAPI.swift
// SwiftOnly (iOS)
//
// Created by Ming Dai on 2021/11/4.
//

import SwiftUI
import Combine

struct CombineSearchAPI: View {
  var body: some View {
    GithubSearchView()
  }
}

// MARK: Github View
struct GithubSearchView: View {
  @State var str: String = "Swift"
  @StateObject var ss: SearchStore = SearchStore()
  @State var repos: [GithubRepo] = []
  var body: some View {
    NavigationView {
      List {
        TextField("输入：", text: $str, onCommit: fetch)
        ForEach(self.ss.repos) { repo -> GithubRepoCell in
          GithubRepoCell(repo: repo)
        }
      }
      .navigationTitle("搜索")
    }
    .onAppear(perform: fetch)
  }
   
  private func fetch() {
    self.ss.search(str: self.str)
  }
}

struct GithubRepoCell: View {
  let repo: GithubRepo
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      Text(self.repo.name)
      Text(self.repo.description)
    }
  }
}

// MARK: Github Service
struct GithubRepo: Decodable, Identifiable {
  let id: Int
  let name: String
  let description: String
}

struct GithubResp: Decodable {
  let items: [GithubRepo]
}

final class GithubSearchManager {
  func search(str: String) -> AnyPublisher<GithubResp, Never> {
    guard var urlComponents = URLComponents(string: "https://api.github.com/search/repositories") else {
      preconditionFailure("链接无效")
    }
    urlComponents.queryItems = [URLQueryItem(name: "q", value: str)]
     
    guard let url = urlComponents.url else {
      preconditionFailure("链接无效")
    }
    let sch = DispatchQueue(label: "API", qos: .default, attributes: .concurrent)
     
    return URLSession.shared
      .dataTaskPublisher(for: url)
      .receive(on: sch)
      .tryMap({ element -> Data in
        print(String(decoding: element.data, as: UTF8.self))
        return element.data
      })
      .decode(type: GithubResp.self, decoder: JSONDecoder())
      .catch { _ in
        Empty().eraseToAnyPublisher()
      }
      .eraseToAnyPublisher()
  }
}

final class SearchStore: ObservableObject {
  @Published var query: String = ""
  @Published var repos: [GithubRepo] = []
  private let searchManager: GithubSearchManager
  private var cancellable = Set<AnyCancellable>()
   
  init(searchManager: GithubSearchManager = GithubSearchManager()) {
    self.searchManager = searchManager
    $query
      .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
      .flatMap { query -> AnyPublisher<[GithubRepo], Never> in
        return searchManager.search(str: query)
          .map {
            $0.items
          }
          .eraseToAnyPublisher()
      }
      .receive(on: DispatchQueue.main)
      .assign(to: \.repos, on: self)
      .store(in: &cancellable)
  }
  func search(str: String) {
    self.query = str
  }
}
```


抽象基础网络能力，方便扩展，代码如下：

```swift
//
// CombineAPI.swift
// SwiftOnly (iOS)
//
// Created by Ming Dai on 2021/11/4.
//

import SwiftUI
import Combine

struct CombineAPI: View {
  var body: some View {
    RepListView(vm: .init())
  }
}

struct RepListView: View {
  @ObservedObject var vm: RepListVM
   
  var body: some View {
    NavigationView {
      List(vm.repos) { rep in
        RepListCell(rep: rep)
      }
      .alert(isPresented: $vm.isErrorShow) { () -> Alert in
        Alert(title: Text("出错了"), message: Text(vm.errorMessage))
      }
      .navigationBarTitle(Text("仓库"))
    }
    .onAppear {
      vm.apply(.onAppear)
    }
  }
}

struct RepListCell: View {
  @State var rep: RepoModel
  var body: some View {
    HStack() {
      VStack() {
        AsyncImage(url: URL(string: rep.owner.avatarUrl ?? ""), content: { image in
          image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
        },
        placeholder: {
          ProgressView()
            .frame(width: 100, height: 100)
        })
        Text("\(rep.owner.login)")
          .font(.system(size: 10))
      }
      VStack(alignment: .leading, spacing: 10) {
        Text("\(rep.name)")
          .font(.title)
        Text("\(rep.stargazersCount)")
          .font(.title3)
        Text("\(String(describing: rep.description ?? ""))")
        Text("\(String(describing: rep.language ?? ""))")
          .font(.title3)
      }
      .font(.system(size: 14))
    }
     
  }
}


// MARK: Repo View Model
final class RepListVM: ObservableObject, UnidirectionalDataFlowType {
  typealias InputType = Input
  private var cancellables: [AnyCancellable] = []
   
  // Input
  enum Input {
    case onAppear
  }
  func apply(_ input: Input) {
    switch input {
    case .onAppear:
      onAppearSubject.send(())
    }
  }
  private let onAppearSubject = PassthroughSubject<Void, Never>()
   
  // Output
  @Published private(set) var repos: [RepoModel] = []
  @Published var isErrorShow = false
  @Published var errorMessage = ""
  @Published private(set) var shouldShowIcon = false
   
  private let resSubject = PassthroughSubject<SearchRepoModel, Never>()
  private let errSubject = PassthroughSubject<APISevError, Never>()
   
  private let apiSev: APISev
   
  init(apiSev: APISev = APISev()) {
    self.apiSev = apiSev
    bindInputs()
    bindOutputs()
  }
   
  private func bindInputs() {
    let req = SearchRepoRequest()
    let resPublisher = onAppearSubject
      .flatMap { [apiSev] in
        apiSev.response(from: req)
          .catch { [weak self] error -> Empty<SearchRepoModel, Never> in
            self?.errSubject.send(error)
            return .init()
          }
      }
    let resStream = resPublisher
      .share()
      .subscribe(resSubject)
     
    // 其它异步事件，比如日志等操作都可以做成Stream加到下面数组内。
    cancellables += [resStream]
  }
   
  private func bindOutputs() {
    let repStream = resSubject
      .map {
        $0.items
      }
      .assign(to: \.repos, on: self)
    let errMsgStream = errSubject
      .map { error -> String in
        switch error {
        case .resError: return "network error"
        case .parseError: return "parse error"
        }
      }
      .assign(to: \.errorMessage, on: self)
    let errStream = errSubject
      .map { _ in
        true
      }
      .assign(to: \.isErrorShow, on: self)
    cancellables += [repStream,errStream,errMsgStream]
  }
   
}


protocol UnidirectionalDataFlowType {
  associatedtype InputType
  func apply(_ input: InputType)
}

// MARK: Repo Request and Models

struct SearchRepoRequest: APIReqType {
  typealias Res = SearchRepoModel
   
  var path: String {
    return "/search/repositories"
  }
  var qItems: [URLQueryItem]? {
    return [
      .init(name: "q", value: "Combine"),
      .init(name: "order", value: "desc")
    ]
  }
}

struct SearchRepoModel: Decodable {
  var items: [RepoModel]
}

struct RepoModel: Decodable, Hashable, Identifiable {
  var id: Int64
  var name: String
  var fullName: String
  var description: String?
  var stargazersCount: Int = 0
  var language: String?
  var owner: OwnerModel
}

struct OwnerModel: Decodable, Hashable, Identifiable {
  var id: Int64
  var login: String
  var avatarUrl: String?
}


// MARK: API Request Fundation

protocol APIReqType {
  associatedtype Res: Decodable
  var path: String { get }
  var qItems: [URLQueryItem]? { get }
}

protocol APISevType {
  func response<Request>(from req: Request) -> AnyPublisher<Request.Res, APISevError> where Request: APIReqType
}

final class APISev: APISevType {
  private let rootUrl: URL
  init(rootUrl: URL = URL(string: "https://api.github.com")!) {
    self.rootUrl = rootUrl
  }
   
  func response<Request>(from req: Request) -> AnyPublisher<Request.Res, APISevError> where Request : APIReqType {
    let path = URL(string: req.path, relativeTo: rootUrl)!
    var comp = URLComponents(url: path, resolvingAgainstBaseURL: true)!
    comp.queryItems = req.qItems
    print(comp.url?.description ?? "url wrong")
    var req = URLRequest(url: comp.url!)
    req.addValue("application/json", forHTTPHeaderField: "Content-Type")
     
    let de = JSONDecoder()
    de.keyDecodingStrategy = .convertFromSnakeCase
    return URLSession.shared.dataTaskPublisher(for: req)
      .map { data, res in
        print(String(decoding: data, as: UTF8.self))
        return data
      }
      .mapError { _ in
        APISevError.resError
      }
      .decode(type: Request.Res.self, decoder: de)
      .mapError(APISevError.parseError)
      .receive(on: RunLoop.main)
      .eraseToAnyPublisher()
  }
}

enum APISevError: Error {
  case resError
  case parseError(Error)
}
```
