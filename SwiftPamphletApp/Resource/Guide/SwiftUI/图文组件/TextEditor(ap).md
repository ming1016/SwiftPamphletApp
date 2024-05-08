![](https://ming1016.github.io/qdimg/240505/texteditor-ap01.png)

对应的代码如下：

```swift
import SwiftUI

struct PlayTextEditorView: View {
    // for TextEditor
    @State private var txt: String = "一段可编辑文字...\n"
    @State private var count: Int = 0
    
    var body: some View {
        
        // 使用 SwiftUI 自带 TextEditor
        TextEditor(text: $txt)
            .font(.title)
            .lineSpacing(10)
            .disableAutocorrection(true)
            .padding()
            .onChange(of: txt) { newValue in
                count = txt.count
            }
        Text("字数：\(count)")
            .foregroundColor(.secondary)
            .font(.footnote)
        
        // 包装的 NSTextView
        HSplitView {
            PNSTextView(text: .constant("左边写...\n"), onDidChange: { (s, i) in
                print("Typing \(i) times.")
            })
                .padding()
            PNSTextView(text: .constant("右边写...\n"))
                .padding()
        } // end HSplitView
    } // end body
}

// MARK: - 自己包装 NSTextView
struct PNSTextView: NSViewRepresentable {
    @Binding var text: String
    var onBeginEditing: () -> Void = {}
    var onCommit: () -> Void = {}
    var onDidChange: (String, Int) -> Void = { _,_  in }
    
    // 返回要包装的 NSView
    func makeNSView(context: Context) -> PNSTextConfiguredView {
        let t = PNSTextConfiguredView(text: text)
        t.delegate = context.coordinator
        return t
    }
    
    func updateNSView(_ view: PNSTextConfiguredView, context: Context) {
        view.text = text
        view.selectedRanges = context.coordinator.sRanges
    }
    
    // 回调
    func makeCoordinator() -> TextViewDelegate {
        TextViewDelegate(self)
    }
}

// 处理 delegate 回调
extension PNSTextView {
    class TextViewDelegate: NSObject, NSTextViewDelegate {
        var tView: PNSTextView
        var sRanges: [NSValue] = []
        var typeCount: Int = 0
        
        init(_ v: PNSTextView) {
            self.tView = v
        }
        // 开始编辑
        func textDidBeginEditing(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else {
                return
            }
            self.tView.text = textView.string
            self.tView.onBeginEditing()
        }
        // 每次敲字
        func textDidChange(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else {
                return
            }
            typeCount += 1
            self.tView.text = textView.string
            self.sRanges = textView.selectedRanges
            self.tView.onDidChange(textView.string, typeCount)
        }
        // 提交
        func textDidEndEditing(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else {
                return
            }
            self.tView.text = textView.string
            self.tView.onCommit()
        }
    }
}

// 配置 NSTextView
final class PNSTextConfiguredView: NSView {
    weak var delegate: NSTextViewDelegate?
    
    private lazy var tv: NSTextView = {
        let contentSize = sv.contentSize
        let textStorage = NSTextStorage()
        
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        
        let textContainer = NSTextContainer(containerSize: sv.frame.size)
        textContainer.widthTracksTextView = true
        textContainer.containerSize = NSSize(
            width: contentSize.width,
            height: CGFloat.greatestFiniteMagnitude
        )
        
        layoutManager.addTextContainer(textContainer)
        
        let t = NSTextView(frame: .zero, textContainer: textContainer)
        t.delegate = self.delegate
        t.isEditable = true
        t.allowsUndo = true
        
        t.font = .systemFont(ofSize: 24)
        t.textColor = NSColor.labelColor
        t.drawsBackground = true
        t.backgroundColor = NSColor.textBackgroundColor
        
        t.maxSize = NSSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        t.minSize = NSSize(width: 0, height: contentSize.height)
        t.autoresizingMask = .width

        t.isHorizontallyResizable = false
        t.isVerticallyResizable   = true
        
        return t
    }()
    
    private lazy var sv: NSScrollView = {
        let s = NSScrollView()
        s.drawsBackground = true
        s.borderType = .noBorder
        s.hasVerticalScroller = true
        s.hasHorizontalRuler = false
        s.translatesAutoresizingMaskIntoConstraints = false
        s.autoresizingMask = [.width, .height]
        return s
    }()
    
    var text: String {
        didSet {
            tv.string = text
        }
    }
    
    var selectedRanges: [NSValue] = [] {
        didSet {
            guard selectedRanges.count > 0 else {
                return
            }
            tv.selectedRanges = selectedRanges
        }
    }

    required init?(coder: NSCoder) {
        fatalError("Error coder")
    }
    
    init(text: String) {
        self.text = text
        super.init(frame: .zero)
    }
    
    override func viewWillDraw() {
        super.viewWillDraw()
        sv.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sv)
        NSLayoutConstraint.activate([
            sv.topAnchor.constraint(equalTo: topAnchor),
            sv.trailingAnchor.constraint(equalTo: trailingAnchor),
            sv.bottomAnchor.constraint(equalTo: bottomAnchor),
            sv.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        sv.documentView = tv
    } // end viewWillDraw

}
```

SwiftUI 中用 NSView，可以通过 NSViewRepresentable 来包装视图，这个协议主要是实现 makeNSView、updateNSView 和 makeCoordinator 三个方法。makeNSView 要求返回需要包装的 NSView。每当 SwiftUI 的状态变化时触发 updateNSView 方法的调用。为了实现 NSView 里的 delegate 和 SwiftUI 通信，就要用 makeCoordinator 返回一个用于处理 delegate 的实例。
