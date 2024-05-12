//
//  WWDCListView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/5/12.
//

import SwiftUI

struct WWDCListView: View {
    @State private var wwdcVM = WWDCListViewModel()
    @State private var limit: Int = 50
    var body: some View {
        if wwdcVM.searchText.isEmpty == false {
            HStack {
                Text("搜索”\(wwdcVM.searchText)“结果如下")
                Button {
                    wwdcVM.searchText = ""
                } label: {
                    Image(systemName: "xmark.circle")
                }
            }
            .padding(.top, 10)
        }
        SPOutlineListView(d: wwdcVM.filtered(), c: \.sub, content: { item in
            VStack {
                if let session = item.session {
                    NavigationLink(destination: WWDCDetailView(session: session, limit: $limit)) {
                        VStack(alignment: .leading) {
                            Text(session.title)
                            HStack {
                                Text("\(session.year)-" + session.eventContentId)
                                Text(session.topic)
                            }
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                        }
                    }
                    .contentShape(Rectangle())
                } else {
                    Text(item.text)
                }
            }
        })
        .listStyle(.sidebar)
        .searchable(text: $wwdcVM.searchText)
        .overlay {
            if wwdcVM.filtered().isEmpty {
                ContentUnavailableView {
                    Label("无结果", systemImage: "rectangle.and.text.magnifyingglass")
                } description: {
                    Text("请再次输入")
                }
            }
        } // end overlay
    } // end body
    
}

@Observable
final class WWDCListViewModel {
    var searchText = ""
    var wwdcData:[WWDCModelForOutline] = [WWDCModelForOutline]()
    
    init() {
        wwdcData = WWDCViewModel.parseModelForOutline()
    }
    
    func filtered() -> [WWDCModelForOutline] {
        guard !searchText.isEmpty else { return wwdcData}
        let flatModel = flatModel(wwdcData)
        return flatModel.filter { model in
            model.session?.title.lowercased().contains(searchText.lowercased()) ?? false || model.session?.description?.lowercased().contains(searchText.lowercased()) ?? false
        }
        
    }
    
    func flatModel(_ models: [WWDCModelForOutline]) -> [WWDCModelForOutline] {
        var fModels = [WWDCModelForOutline]()
        for model in models {
            fModels.append(model)
            if let subs = model.sub {
                let reFModels = flatModel(subs)
                for reModel in reFModels {
                    fModels.append(reModel)
                }
            }
        }
        return fModels
    }
    
}
