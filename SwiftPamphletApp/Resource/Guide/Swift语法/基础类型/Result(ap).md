Result 类型用来处理错误，特别适用异步接口的错误处理。

```swift
extension URLSession {
    func dataTaskWithResult(
        with url: URL,
        handler: @escaping (Result<Data, Error>) -> Void
    ) -> URLSessionDataTask {
        dataTask(with: url) { data, _, err in
            if let err = err {
                handler(.failure(err))
            } else {
                handler(.success(data ?? Data()))
            }
        }
    }
}

let url = URL(string: "https://ming1016.github.io/")!

// 以前网络请求
let t1 = URLSession.shared.dataTask(with: url) {
    data, _, error in
    if let err = error {
        print(err)
    } else if let data = data {
        print(String(decoding: data, as: UTF8.self))
    }
}
t1.resume()

// 使用 Result 网络请求
let t2 = URLSession.shared.dataTaskWithResult(with: url) { result in
    switch result {
    case .success(let data):
        print(String(decoding: data, as: UTF8.self))
    case .failure(let err):
        print(err)
    }
}
t2.resume()
```
