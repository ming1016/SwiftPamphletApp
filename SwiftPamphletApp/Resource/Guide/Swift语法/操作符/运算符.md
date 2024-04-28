位运算符

```swift
let i1: UInt8 = 0b00001111
let i2 = ~i1 // Bitwise NOT Operator（按位取反运算符），取反

let i3: UInt8 = 0b00111111
let i4 = i1 & i3 // Bitwise AND Operator（按位与运算符），都为1才是1
let i5 = i1 | i3 // Bitwise OR Operator（按位或运算符），有一个1就是1
let i6 = i1 ^ i3 // Bitwise XOR Operator（按位异或运算符），不同为1，相同为0

print(i1,i2,i3,i4,i5,i6)

// << 按位左移，>> 按位右移
let i7 = i1 << 1
let i8 = i1 >> 2
print(i7,i8)
```

溢出运算符，有 &+、&- 和 &*

```swift
var i1 = Int.max
print(i1) // 9223372036854775807
i1 = i1 &+ 1
print(i1) // -9223372036854775808
i1 = i1 &+ 10
print(i1) // -9223372036854775798

var i2 = UInt.max
i2 = i2 &+ 1
print(i2) // 0
```

运算符函数包括前缀运算符、后缀运算符、复合赋值运算符以及等价运算符。另，还可以自定义运算符，新的运算符要用 operator 关键字进行定义，同时要指定 prefix、infix 或者 postfix 修饰符。
