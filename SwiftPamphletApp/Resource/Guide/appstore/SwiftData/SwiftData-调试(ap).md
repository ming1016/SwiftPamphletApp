
CoreData 的调试方式依然适用于 SwiftData。

你可以设置启动参数来让 CoreData 打印出执行的 SQL 语句。在你的项目中，选择 "Product" -> "Scheme" -> "Edit Scheme"，然后在 "Arguments" 标签下的 "Arguments Passed On Launch" 中添加 -com.apple.CoreData.SQLDebug 1。这样，每当 CoreData 执行 SQL 语句时，都会在控制台中打印出来。

使用 `-com.apple.CoreData.SQLDebug 3` 获取后台更多信息。
