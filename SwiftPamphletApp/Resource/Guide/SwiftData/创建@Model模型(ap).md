
## 创建

用 `@Model` 宏装饰类
```swift
@Model
final class Article {
    let title: String
    let author: String
    let content: String
    let publishedDate: Date
    
    init(title: String, author: String, content: String, publishedDate: Date) {
        self.title = title
        self.author = author
        self.content = content
        self.publishedDate = publishedDate
    }
}
```

以下数据类型默认支持：
- 基础类型：Int, Int8, Int16, Int32, Int64, UInt, UInt8, UInt16, UInt32, UInt64, Float, Double, Bool, String, Date, Data 等
- 复杂的类型：Array, Dictionary, Set, Optional, Enum, Struct, Codable 等
- 模型关系：一对一、一对多、多对多

默认数据库路径： `Data/Library/Application Support/default.store`

## `@Attribute`

一些常用的：

- spotlight：使其能出现在 Spotlight 搜索结果里
- unique：值是唯一的
- externalStorage：值存储为二进制数据
- transient：值不存储
- encrypt：加密存储

使用方法
```swift
@Attribute(.externalStorage) var imgData: Data? = nil
```

二进制会将其存储为单独的文件，然后在数据库中引用文件名。文件会存到  `Data/Library/Application Support/.default_SUPPORT/_EXTERNAL_DATA` 目录下。

## `@Transient` 不存

如果有的属性不希望进行存储，可以使用 `@Transient`

```swift
@Model
final class Article {
    let title: String
    let author: String
    @Transient var content: String
    ...
}
```

## transformable

SwiftData 除了能够存储字符串和整数这样基本类型，还可以存储更复杂的自定义类型。要存储自定义类型，可用 transformable。

```swift
@Model
final class Article {
    let title: String
    let author: String
    let content: String
    let publishedDate: Date
    @Attribute(.transformable(by: UIColorValueTransformer.self)) var bgColor: UIColor
    ...
}
```

UIColorValueTransformer 类的实现

```swift
class UIColorValueTransformer: ValueTransformer {
    
    // return data
    override func transformedValue(_ value: Any?) -> Any? {
        guard let color = value as? UIColor else { return nil }
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: true)
            return data
        } catch {
            return nil
        }
    }
    
    // return UIColor
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        
        do {
            let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data)
            return color
        } catch {
            return nil 
        }
    }
}
```

注册

```swift
struct SwiftPamphletAppApp: App {
    init() {
        ValueTransformer.setValueTransformer(UIColorValueTransformer(), forName: NSValueTransformerName("UIColorValueTransformer"))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Article.self])
        }
    }
}
```
