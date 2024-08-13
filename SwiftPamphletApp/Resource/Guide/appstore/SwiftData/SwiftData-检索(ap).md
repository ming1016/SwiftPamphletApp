
## `@Query`
使用 `@Query` 会从数据库中获取数据。

```swift
@Query private var articles: [Article]
```

`@Query` 还支持 filter、sort、order 和 animation 等参数。

```swift
@Query(sort: \Article.title, order: .forward) private var articles: [Article]
```

sort 可支持多个 SortDescriptor，SwiftData 会按顺序处理。

```swift
@Query(sort: [SortDescriptor(\Article.isArchived, order: .forward),SortDescriptor(\Article.updateDate, order: .reverse)]) var articles: [Article]
```

## Predicate

filter 使用的是 `#Predicate` 

```swift
static var now: Date { Date.now }

@Query(filter: #Predicate<Article> { article in
    article.releaseDate > now
}) var draftArticles: [Article]
```

Predicate 支持的内置方法主要有 `contains`、`allSatisfy`、`flatMap`、`filter`、`subscript`、`starts`、`min`、`max`、`localizedStandardContains`、`localizedCompare`、`caseInsensitiveCompare` 等。

```swift
@Query(filter: #Predicate<Article> { article in
    article.title.starts(with: "苹果发布会")
}) var articles: [Article]
```

需要注意的是 `.isEmpty`  不能使用  `article.title.isEmpty == false` ，否则会崩溃。

## FetchDescriptor

FetchDescriptor 可以在模型中查找数据，而不必在视图层做。

```swift
@Model
final class Article {
    var title: String
    ...
    static var all: FetchDescriptor<Article> {
        FetchDescriptor(sortBy: [SortDescriptor(\Article.updateDate, order: .reverse)])
    }
}

struct SomeView: View {   
    @Query(Article.all) private var articles: [Article]
    ...
}
```

## 获取数量而不加载

使用 `fetchCount()` 方法，可完成整个计数，且很快，内存占用少。

```swift
let descriptor = FetchDescriptor<Article>(predicate: #Predicate { $0.words > 50 })
let count = (try? modelContext.fetchCount(descriptor)) ?? 0
```

## fetchLimit 限制获取数量

```swift
var descriptor = FetchDescriptor<Article>(
  predicate: #Predicate { $0.read },
  sortBy: [SortDescriptor(\Article.updateDate,
           order: .reverse)])
descriptor.fetchLimit = 30
let articles = try context.fetch(descriptor)

// 翻页
let pSize = 30
let pNumber = 1
var fetchDescriptor = FetchDescriptor<Article>(sortBy: [SortDescriptor(\Article.updateDate, order: .reverse)])
fetchDescriptor.fetchOffset = pNumber * pSize
fetchDescriptor.fetchLimit = pSize
```

## 限制获取的属性

只请求要用的属性

```swift
var fetchDescriptor = FetchDescriptor<Article>(sortBy: [SortDescriptor(\.updateDate, order: .reverse)])
fetchDescriptor.propertiesToFetch = [\.title, \.updateDate]
```
