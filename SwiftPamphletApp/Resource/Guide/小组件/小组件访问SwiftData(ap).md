
Wdiget target 访问主应用 target 的 SwiftData 数据步骤如下：

- 对主应用和 Widget 的 target 中的 Signing & Capabilities 都添加 App Groups，并创建一个新组，名字相同。
- SwiftData 的模型同时在主应用和 Widget 的 target 中。
- StaticConfiguration 或 AppIntentConfiguration 中添加 `modelContainer()` 修饰符，让 SwiftData 的容器可用。

