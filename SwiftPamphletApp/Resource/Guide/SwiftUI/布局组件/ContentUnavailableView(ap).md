
基本用法

```swift
struct ArchivedInfosView: View {
    @Environment(\.modelContext) var modelContext
    @Query var infos: [IOInfo]
    ...
    
    var body: some View {
        List(selection: $selectInfo) {
            ForEach(infos) { info in
                ...
            }
        }
        .overlay {
            if infos.isEmpty {
                ContentUnavailableView {
                    Label("无归档", systemImage: "archivebox")
                } description: {
                    Text("点击下方按钮添加一个归档资料")
                } actions: {
                    Button("新增") {
                        addInfo()
                    }
                }
            }
        }
    }
    ...
}
```

搜索
```swift
struct ContentView: View {
    @Bindable var vm: VModel
    ...

    var body: some View {
        NavigationStack {
            List(vm.items, id: \.self) { item in
                ...
            }
            .navigationTitle("Products")
            .overlay {
                if vm.items.isEmpty {
                    ContentUnavailableView.search(text: vm.query)
                }
            }
            .searchable(text: $vm.query)
        }
        ...
    }
}
```
