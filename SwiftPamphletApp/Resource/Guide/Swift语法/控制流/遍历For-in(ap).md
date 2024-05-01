```swift
let a = ["one", "two", "three"]
for str in a {
    print(str)
}

// 使用下标范围
for i in 0..<10 {
    print(i)
}

// 使用 enumerated
for (i, str) in a.enumerated() {
    print("第\(i + 1)个是:\(str)")
}

// for in where
for str in a where str.prefix(1) == "t" {
    print(str)
}

// 字典 for in，遍历是无序的
let dic = [
    "one": 1,
    "two": 2,
    "three": 3
]

for (k, v) in dic {
    print("key is \(k), value is \(v)")
}

// stride
for i in stride(from: 10, through: 0, by: -2) {
    print(i)
}
/*
 10
 8
 6
 4
 2
 0
 */
```
