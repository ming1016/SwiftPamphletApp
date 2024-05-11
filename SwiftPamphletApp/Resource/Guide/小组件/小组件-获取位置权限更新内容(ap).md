
小组件获取位置权限和主应用 target 里获取方式很类似，步骤：

- 在 info 里添加 `NSWidgetUseLocation = ture`。
- 使用 CLLocationManager 来获取位置信息，设置较低的精度。
- 用 `isAuthorizedForWidgetUpdates` 请求位置权限。

