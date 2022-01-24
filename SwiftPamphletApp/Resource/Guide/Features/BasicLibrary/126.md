效果如下：

![](https://user-images.githubusercontent.com/251980/150132322-20c5c2d4-6452-4d06-9202-4b93cffd8133.png)

代码如下：
```swift
var aStrs = [AttributedString]()
var aStr1 = AttributedString("""
标题
正文内容，具体查看链接。
这里摘出第一个重点，还要强调的内容。
""")
// 标题
let title = aStr1.range(of: "标题")
guard let title = title else {
    return aStrs
}

var c1 = AttributeContainer() // 可复用容器
c1.inlinePresentationIntent = .stronglyEmphasized
c1.font = .largeTitle
aStr1[title].setAttributes(c1)

// 链接
let link = aStr1.range(of: "链接")
guard let link = link else {
    return aStrs
}

var c2 = AttributeContainer() // 链接
c2.strokeColor = .blue
c2.link = URL(string: "https://ming1016.github.io/")
aStr1[link].setAttributes(c2.merging(c1)) // 合并 AttributeContainer

// Runs
let i1 = aStr1.range(of: "重点")
let i2 = aStr1.range(of: "强调")
guard let i1 = i1, let i2 = i2 else {
    return aStrs
}

var c3 = AttributeContainer()
c3.foregroundColor = .yellow
c3.inlinePresentationIntent = .stronglyEmphasized
aStr1[i1].setAttributes(c3)
aStr1[i2].setAttributes(c3)

for r in aStr1.runs {
    print("-------------")
    print(r.attributes)
}

aStrs.append(aStr1)

// Markdown
do {
    let aStr2 = try AttributedString(markdown: """
    内容[链接](https://ming1016.github.io/)。需要**强调**的内容。
    """)
    
    aStrs.append(aStr2)
    
} catch {}
```


SwiftUI 的 Text 可以直接读取 AttributedString 来进行显示。
