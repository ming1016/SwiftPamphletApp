如果SwiftUI要求数据Model都是遵循Identifiable协议的，而有的json没有id这个字段，可以使用扩展struct的方式解决：

```swift
struct CommitModel: Decodable, Hashable {
  var sha: String
  var author: AuthorModel
  var commit: CommitModel
}
extension CommitModel: Identifiable {
  var id: String {
    return sha
  }
}
```
