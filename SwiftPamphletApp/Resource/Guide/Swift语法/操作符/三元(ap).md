简化 if else 写法

```swift
// if else
func f1(p: Int) {
    if p > 0 {
        print("positive number")
    } else {
        print("negative number")
    }
}

// 三元
func f2(p: Int) {
    p > 0 ? print("positive number") : print("negative number")
}

f1(p: 1)
f2(p: 1)
```
