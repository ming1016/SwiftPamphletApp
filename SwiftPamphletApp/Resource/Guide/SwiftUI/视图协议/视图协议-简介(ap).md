

SwiftUI 的视图协议定义了构建用户界面的基本规则和结构。以下是一些主要的视图协议：

- `View`：这是所有 SwiftUI 视图的基础协议。它定义了一个视图的基本接口，包括其主体和一些关联类型。
- `ViewModifier`：这个协议定义了可以修改视图并返回新视图的类型。
- `App`：这个协议定义了一个应用程序的结构。它包括一个场景的主体，这个场景是应用程序的入口点。
- `Scene`：这个协议定义了应用程序的一个场景，例如一个窗口或者一个文档。

此外，SwiftUI 还提供了一系列的样式协议，如 `ButtonStyle`，`DatePickerStyle`，`LabelStyle` 等，这些协议允许我们自定义视图的外观和行为。

还有一些专门用于构建和配置小部件的协议，如 `Widget`，`WidgetBundle` 和 `WidgetConfiguration`。

SwiftUI 还提供了一些用于定义形状的协议，如 `Shape` 和 `InsettableShape`，以及用于定义动画的协议，如 `Animatable` 和 `AnimatableModifier`。

环境协议允许我们在视图层次结构中传递数据，如 `EnvironmentKey` 和 `EnvironmentalModifier`。

预览协议允许我们为预览提供正确的上下文，如 `PreviewContext` 和 `PreviewProvider`。

传统桥梁协议允许我们访问传统视图定义，如 `UIViewControllerRepresentable` 和 `UIViewRepresentable`。

响应者链协议允许我们处理来自应用程序不同部分的事件，如 `Commands` 和 `FocusedValueKey`。

工具栏协议允许我们优化/组织工具栏，如 `ToolbarContent` 和 `CustomizableToolbarContent`。

文档协议用于定义支持的文件类型，如 `FileDocument` 和 `ReferenceFileDocument`。

最后，SwiftUI 还提供了一些一次性协议，如 `AlignmentID`，`PreferenceKey`，`DropDelegate`，`DynamicProperty`，`DynamicViewContent` 和 `Gesture`。
