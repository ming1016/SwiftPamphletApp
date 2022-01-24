更好地处理异常情况

```swift
// guard
func f1(p: String) -> String {
    guard p.isEmpty != true else {
        return "Empty string."
    }
    return "String \(p) is not empty."
}

print(f1(p: "")) // Empty string.
print(f1(p: "lemon")) // String lemon is not empty.

// guard let
func f2(p1: String?) -> String {
    guard let p2 = p1 else {
        return "Nil."
    }
    return "String \(p2) is not nil."
}

print(f2(p1: nil)) // Nil.
print(f2(p1: "lemon")) // String lemon is not nil.
```
