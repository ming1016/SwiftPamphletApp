
描述人名
```swift
// 名字
let f2 = PersonNameComponentsFormatter()
var nc1 = PersonNameComponents()
nc1.familyName = "戴"
nc1.givenName = "铭"
nc1.nickname = "铭哥"
print(f2.string(from: nc1)) // 戴铭
f2.style = .short
print(f2.string(from: nc1)) // 铭哥
f2.style = .abbreviated
print(f2.string(from: nc1)) // 戴

var nc2 = PersonNameComponents()
nc2.familyName = "Dai"
nc2.givenName = "Ming"
nc2.nickname = "Starming"
f2.style = .default
print(f2.string(from: nc2)) // Ming Dai
f2.style = .short
print(f2.string(from: nc2)) // Starming
f2.style = .abbreviated
print(f2.string(from: nc2)) // MD

// 取出名
let componets = f2.personNameComponents(from: "戴铭")
print(componets?.givenName ?? "") // 铭
```

描述地址
```swift
// 地址
import Contacts

let f4 = CNPostalAddressFormatter()
let address = CNMutablePostalAddress()
address.street = "海淀区王庄路XX号院X号楼X门XXX"
address.postalCode = "100083"
address.city = "北京"
address.country = "中国"
print(f4.string(from: address))
/// 海淀区王庄路XX号院X号楼X门XXX
/// 北京 100083
/// 中国
```
