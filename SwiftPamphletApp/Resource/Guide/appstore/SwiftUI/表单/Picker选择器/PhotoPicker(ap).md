
## PhotoPicker 使用示例

```swift
import SwiftUI
import PhotosUI

struct ContentView: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedPhotoData: Data?

    var body: some View {
        NavigationView {
            VStack {
                if let item = selectedItem, let data = selectedPhotoData, let image = UIImage(data: data) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                } else {
                    Text("选择电影海报")
                }
            }
            .navigationTitle("电影海报")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        Label("选择照片", systemImage: "photo")
                    }
                    .tint(.indigo)
                    .controlSize(.extraLarge)
                    .buttonStyle(.borderedProminent)
                }
            }
            .onChange(of: selectedItem, { oldValue, newValue in
                Task {
                    if let data = try? await newValue?.loadTransferable(type: Data.self) {
                        selectedPhotoData = data
                    }
                }
            })
        }
    }
}
```

## 限制选择媒体类型

我们可以使用 `matching` 参数来过滤 `PhotosPicker` 中显示的媒体类型。这个参数接受一个 `PHAssetMediaType` 枚举值，可以是 `.images`、`.videos`、`.audio`、`.any` 等。

例如，如果我们只想显示图片，可以这样设置：

```swift
PhotosPicker(selection: $selectedItem, matching: .images) {
    Label("选择照片", systemImage: "photo")
}
```

如果我们想同时显示图片和视频，可以使用 `.any(of:)` 方法：

```swift
PhotosPicker(selection: $selectedItem, matching: .any(of: [.images, .videos])) {
    Label("选择照片", systemImage: "photo")
}
```

此外，我们还可以使用 `.not(_:)` 方法来排除某种类型的媒体。例如，如果我们想显示所有的图片，但是不包括 Live Photo，可以这样设置：

```swift
PhotosPicker(selection: $selectedItem, matching: .any(of: [.images, .not(.livePhotos)])) {
    Label("选择照片", systemImage: "photo")
}
```

这些设置可以让我们更精确地控制 `PhotosPicker` 中显示的媒体类型。


## 选择多张图片

以下示例演示了如何使用 `PhotosPicker` 选择多张图片，并将它们显示在一个 `LazyVGrid` 中：

```swift
import SwiftUI
import PhotosUI

struct ContentView: View {
    @State private var selectedItems: [PhotosPickerItem] = [PhotosPickerItem]()
    @State private var selectedPhotosData: [Data] = [Data]()

    var body: some View {
        NavigationStack {

            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(selectedPhotosData, id: \.self) { photoData in
                        if let image = UIImage(data: photoData) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(10.0)
                                .padding(.horizontal)
                        }
                    }
                }
            }
            .navigationTitle("书籍")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    PhotosPicker(selection: $selectedItems, maxSelectionCount: 5, matching: .images) {
                        Image(systemName: "book.fill")
                            .foregroundColor(.brown)
                    }
                    .onChange(of: selectedItems, { oldValue, newValue in
                        for newItem in newValue {
                            Task {
                                if let data = try? await newItem.loadTransferable(type: Data.self) {
                                    selectedPhotosData.append(data)
                                }
                            }
                        }
                    })
                }
            }
        }
    }
}
```

以上示例中，我们使用了 `PhotosPicker` 的 `maxSelectionCount` 参数来限制用户最多只能选择 5 张图片。当用户选择图片后，我们将图片数据保存在 `selectedPhotosData` 数组中，并在 `LazyVGrid` 中显示这些图片。



