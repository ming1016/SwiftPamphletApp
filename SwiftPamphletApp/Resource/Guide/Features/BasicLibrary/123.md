数据压缩和解压
```swift
// 对数据的压缩
let d1 = "看看能够压缩多少？看看能够压缩多少？看看能够压缩多少？看看能够压缩多少？看看能够压缩多少？看看能够压缩多少？看看能够压缩多少？看看能够压缩多少？看看能够压缩多少？看看能够压缩多少？看看能够压缩多少？".data(using: .utf8)! as NSData
print("ori \(d1.count) bytes")
do {
    /// 压缩算法
    /// * lz4
    /// * lzma
    /// * zlib
    /// * lzfse
    let compressed = try d1.compressed(using: .zlib)
    print("comp \(compressed.count) bytes")
    
    // 对数据解压
    let decomressed = try compressed.decompressed(using: .zlib)
    let deStr = String(data: decomressed as Data, encoding: .utf8)
    print(deStr ?? "")
} catch {}
/// ori 297 bytes
/// comp 37 bytes
```

