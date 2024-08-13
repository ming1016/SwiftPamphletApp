

widget bundle 可以支持多个小组件。

```swift
@main
struct FirstWidgetBundle: WidgetBundle {
    
    @WidgetBundleBuilder
    var body: some Widget {
        FirstWidget()
        SecondWidget()
        ...
        SecondWidgetBundle().body
    }
}

struct SecondWidgetBundle: WidgetBundle {

    @WidgetBundleBuilder
    var body: some Widget {
        SomeWidgetOne()
        SomeWidgetTwo()
        ...
    }
}
```
