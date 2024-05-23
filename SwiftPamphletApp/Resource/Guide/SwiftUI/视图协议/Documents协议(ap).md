
Documents 协议包括：

- `FileDocument`
- `ReferenceFileDocument`

`Documents` 协议主要包括 `FileDocument` 和 `ReferenceFileDocument`，它们用于处理文件的读取和写入。

- `FileDocument`：这个协议用于处理文件的读取和写入。它要求我们提供一个 `init(configuration:)` 初始化方法来从文件读取数据，以及一个 `fileWrapper(configuration:)` 方法来将数据写入文件。例如，我们可以创建一个表示漫画的 `FileDocument`：

```swift
struct ComicDocument: FileDocument {
    var comic: String

    init(comic: String) {
        self.comic = comic
    }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let comic = String(data: data, encoding: .utf8) else {
            throw CocoaError(.fileReadCorruptFile)
        }
        self.comic = comic
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = comic.data(using: .utf8)!
        return .init(regularFileWithContents: data)
    }
}
```

在这个例子中，`ComicDocument` 是一个遵循 `FileDocument` 协议的类型，它表示一个漫画。它有一个 `comic` 属性，这个属性是漫画的内容。它的 `init(configuration:)` 方法从文件读取数据，然后将数据转换为字符串。它的 `fileWrapper(configuration:)` 方法将 `comic` 转换为数据，然后将数据写入文件。

- `ReferenceFileDocument`：这个协议用于处理文件的读取和写入，但是它不会将文件的内容加载到内存中。它要求我们提供一个 `init(url:)` 初始化方法来从文件读取数据，以及一个 `write(to:)` 方法来将数据写入文件。例如，我们可以创建一个表示漫画的 `ReferenceFileDocument`：

```swift
struct ComicDocument: ReferenceFileDocument {
    var comic: String

    init(comic: String) {
        self.comic = comic
    }

    init(url: URL, contentType: UTType) throws {
        let data = try Data(contentsOf: url)
        guard let comic = String(data: data, encoding: .utf8) else {
            throw CocoaError(.fileReadCorruptFile)
        }
        self.comic = comic
    }

    func write(to url: URL) throws {
        let data = comic.data(using: .utf8)!
        try data.write(to: url)
    }
}
```

在这个例子中，`ComicDocument` 是一个遵循 `ReferenceFileDocument` 协议的类型，它表示一个漫画。它的 `init(url:)` 方法从文件读取数据，然后将数据转换为字符串。它的 `write(to:)` 方法将 `comic` 转换为数据，然后将数据写入文件。
