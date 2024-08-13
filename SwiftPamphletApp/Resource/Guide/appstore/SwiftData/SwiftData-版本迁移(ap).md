
以下的小改动 SwiftData 会自动执行轻量迁移：

- 增加模型
- 增加有默认值的新属性
- 重命名属性
- 删除属性
- 增加或删除 `.externalStorage` 或 `.allowsCloudEncryption` 属性。
- 增加所有值都是唯一属性为 `.unique`
- 调整关系的删除规则

其他情况需要用到版本迁移，版本迁移步骤如下：

- 用 VersionedSchema 创建 SwiftData 模型的版本
- 用 SchemaMigrationPlan 对创建的版本进行排序
- 为每个迁移定义一个迁移阶段

设置版本

```swift
enum ArticleV1Schema: VersionedSchema {
    static var versionIdentifier: String? = "v1"
    static var models: [any PersistentModel.Type] { [Article.self] }

    @Model
    final class Article {
        ...
    }
}
```

SchemaMigrationPlan 轻量迁移

```swift
enum ArticleMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [ArticleV1Schema.self, ArticleV2Schema.self]
    }

    static var stages: [MigrationStage] {
        [migrateV1toV2]
    }

    static let migrateV1toV2 = MigrationStage.lightweight(
        fromVersion: ArticleV1Schema.self,
        toVersion: ArticleV2Schema.self
    )
}
```

自定义迁移

```swift
static let migrateV1toV2 = MigrationStage.custom(
    fromVersion: ArticleV1Schema.self,
    toVersion: ArticleV2Schema.self,
    willMigrate: { context in
        // 合并前的处理
    },
    didMigrate: { context in
        // 合并后的处理
    }
)
```
