

使用 ``@Relationship` 添加关系，但是不加这个宏也可以，SwiftData 会自动添加模型之间的关系。

```swift
@Model
final class Author {
    var name: String

    @Relationship(deleteRule: .cascade, inverse: \Brew.brewer)
    var articles: [Article] = []
}

@Model
final class Article {
    ...
    var author: Author
}
```

默认情况 deleteRule 是 `.nullify`，这个删除后只会删除引用关系。`.cascade` 会在删除用户后删除其所有文章。

SwiftData 可以添加一对一，一对多，多对多的关系。

限制关系表数量
```swift
@Relationship(maximumModelCount: 5)
    var articles: [Article] = []
```


