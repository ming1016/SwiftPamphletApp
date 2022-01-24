Set 是无序集合，元素唯一

```swift
let s0: Set<Int> = [2, 4]
let s1: Set = [2, 10, 6, 4, 8]
let s2: Set = [7, 3, 5, 1, 9, 10]

let s3 = s1.union(s2) // 合集
let s4 = s1.intersection(s2) // 交集
let s5 = s1.subtracting(s2) // 非交集部分
let s6 = s1.symmetricDifference(s2) // 非交集的合集
print(s3) // [4, 2, 1, 7, 3, 10, 8, 9, 6, 5]
print(s4) // [10]
print(s5) // [8, 4, 2, 6]
print(s6) // [9, 1, 3, 4, 5, 2, 6, 8, 7]

// s0 是否被 s1 包含
print(s0.isSubset(of: s1)) // true
// s1 是否包含了 s0
print(s1.isSuperset(of: s0)) // true

let s7: Set = [3, 5]
// s0 和 s7 是否有交集
print(s0.isDisjoint(with: s7)) // true

// 可变 Set
var s8: Set = ["one", "two"]
s8.insert("three")
s8.remove("one")
print(s8) // ["two", "three"]
```
