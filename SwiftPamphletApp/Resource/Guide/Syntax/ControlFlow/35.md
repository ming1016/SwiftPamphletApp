```swift
func f1(pa: String, t:(String, Int)) {
    var p1 = 0
    var p2 = 10
    switch pa {
    case "one":
        p1 = 1
    case "two":
        p1 = 2
        fallthrough // 继续到下个 case 中
    default:
        p2 = 0
    }
    print("p1 is \(p1)")
    print("p2 is \(p2)")
    
    // 元组
    switch t {
    case ("0", 0):
        print("zero")
    case ("1", 1):
        print("one")
    default:
        print("no")
    }
}

f1(pa: "two", t:("1", 1))
/*
 p1 is 2
 p2 is 0
 one
 */

// 枚举
enum E {
    case one, two, three, unknown(String)
}

func f2(pa: E) {
    var p: String
    switch pa {
    case .one:
        p = "1"
    case .two:
        p = "2"
    case .three:
        p = "3"
    case let .unknown(u) where Int(u) ?? 0 > 0 : // 枚举关联值，使用 where 增加条件
        p = u
    case .unknown(_):
        p = "negative number"
    }
    print(p)
}

f2(pa: E.one) // 1
f2(pa: E.unknown("10")) // 10
f2(pa: E.unknown("-10")) // negative number
```
