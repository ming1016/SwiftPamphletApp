AsyncSequence 的使用方式是 for-await-in 和 for-try-await-in，系统提供了一些接口，如下：

* FileHandle.standardInput.bytes.lines
* URL.lines
* URLSession.shared.data(from: URL)
* let (localURL, _ ) = try await session.download(from: url) 下载和get请求数据区别是需要边请求边存储数据以减少内存占用
* let (responseData, response) = try await session.upload(for: request, from: data)
* URLSession.shared.bytes(from: URL)
* NotificationCenter.default.notifications
