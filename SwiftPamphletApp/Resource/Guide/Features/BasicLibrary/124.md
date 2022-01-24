文件的一些基本操作的代码如下：
```swift
let path1 = "/Users/mingdai/Downloads/1.html"
let path2 = "/Users/mingdai/Documents/GitHub/"

let u1 = URL(string: path1)
do {
    // 写入
    let url1 = try FileManager.default.url(for: .itemReplacementDirectory, in: .userDomainMask, appropriateFor: u1, create: true) // 保证原子性安全保存
    print(url1)

    // 读取
    let s1 = try String(contentsOfFile: path1, encoding: .utf8)
    print(s1)

} catch {}

// 检查路径是否可用
let u2 = URL(fileURLWithPath:path2)
do {
    let values = try u2.resourceValues(forKeys: [.volumeAvailableCapacityForImportantUsageKey])
    if let capacity = values.volumeAvailableCapacityForImportantUsage {
        print("可用: \(capacity)")
    } else {
        print("不可用")
    }
} catch {
    print("错误: \(error.localizedDescription)")
}
```

怎么遍历多级目录结构中的文件呢？看下面的代码的实现：
```swift
// 遍历路径下所有目录
let u3 = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
let fm = FileManager.default
fm.enumerator(atPath: u3.path)?.forEach({ path in
    guard let path = path as? String else {
        return
    }
    let url = URL(fileURLWithPath: path, relativeTo: u3)
    print(url.lastPathComponent)
})
```

可以使用 FileWrapper 来创建文件夹和文件。举个例子：
```swift
// FileWrapper 的使用
// 创建文件
let f1 = FileWrapper(regularFileWithContents: Data("# 第 n 个文件\n ## 标题".utf8))
f1.fileAttributes[FileAttributeKey.creationDate.rawValue] = Date()
f1.fileAttributes[FileAttributeKey.modificationDate.rawValue] = Date()
// 创建文件夹
let folder1 = FileWrapper(directoryWithFileWrappers: [
    "file1.md": f1
])
folder1.fileAttributes[FileAttributeKey.creationDate.rawValue] = Date()
folder1.fileAttributes[FileAttributeKey.modificationDate.rawValue] = Date()

do {
    try folder1.write(
        to: URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent("NewFolder"),
        options: .atomic,
        originalContentsURL: nil
    )
} catch {}
print(FileManager.default.currentDirectoryPath)
```

上面代码写起来比较繁琐，对 FileWrapper 更好的封装可以参考这篇文章《 [A Type-Safe FileWrapper | Heberti Almeida](https://heberti.com/posts/filewrapper/) 》。

文件读写处理完整能力可以参看这个库  [GitHub - JohnSundell/Files: A nicer way to handle files & folders in Swift](https://github.com/JohnSundell/Files) 

本地或者网络上，比如网盘和FTP的文件发生变化时，怎样知道能够观察到呢？

通过 HTTPHeader 里的 If-Modified-Since、Last-Modified、If-None-Match 和 Etag 等字段来判断文件的变化，本地则是使用 DispatchSource.makeFileSystemObjectSource 来进行的文件变化监听。可以参考  [KZFileWatchers](https://github.com/krzysztofzablocki/KZFileWatchers)  库的做法。

