今年 iOS 和 iPadOS 也可以使用去年只能在 macOS 上使用的 Table了，据 digital lounges 里说，iOS table 的性能和 list 差不多，table 默认为 plian list。我想 iOS 上加上 table 只是为了兼容 macOS 代码吧。

table 使用示例如下：
```swift
Table(attendeeStore.attendees) {
    TableColumn("Name") { attendee in
        AttendeeRow(attendee)
    }
    TableColumn("City", value: \.city)
    TableColumn("Status") { attendee in
        StatusRow(attendee)
    }
}
.contextMenu(forSelectionType: Attendee.ID.self) { selection in
    if selection.isEmpty {
        Button("New Invitation") { addInvitation() }
    } else if selection.count == 1 {
        Button("Mark as VIP") { markVIPs(selection) }
    } else {
        Button("Mark as VIPs") { markVIPs(selection) }
    }
}
```
