字典是无序集合，键值对应。

```swift
var d1 = [
    "k1": "v1",
    "k2": "v2"
]
d1["k3"] = "v3"
d1["k4"] = nil

print(d1) // ["k2": "v2", "k3": "v3", "k1": "v1"]

for (k, v) in d1 {
    print("key is \(k), value is \(v)")
}
/*
 key is k1, value is v1
 key is k2, value is v2
 key is k3, value is v3
 */
 
if d1.isEmpty == false {
    print(d1.count) // 3
}

// mapValues
let d2 = d1.mapValues {
    $0 + "_new"
}
print(d2) // ["k2": "v2_new", "k3": "v3_new", "k1": "v1_new"]

// 对字典的值或键进行分组
let d3 = Dictionary(grouping: d1.values) {
    $0.count
}
print(d3) // [2: ["v1", "v2", "v3"]]

// 从字典中取值，如果键对应无值，则使用通过 default 指定的默认值
d1["k5", default: "whatever"] += "."
print(d1["k5"] ?? "") // whatever.
let v1 = d1["k3", default: "whatever"]
print(v1) // v3

// compactMapValues() 对字典值进行转换和解包。可以解可选类型，并去掉 nil 值
let d4 = [
    "k1": 1,
    "k2": 2,
    "k3": nil
]
let d5 = d4.mapValues { $0 }
let d6 = d4.compactMapValues{ $0 }
print(d5)
// ["k3": nil, "k1": Optional(1), "k2": Optional(2)]
print(d6)
// ["k1": 1, "k2": 2]
```
