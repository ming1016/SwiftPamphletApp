使用方法：
```swift
let d1 = Data("keyChain github token".utf8)
let service = "access-token"
let account = "github"
let q1 = [
    kSecValueData: d1,
    kSecClass: kSecClassGenericPassword,
    kSecAttrService: service,
    kSecAttrAccount: account
] as CFDictionary

// 添加一个 keychain
let status = SecItemAdd(q1, nil)

// 如果已经添加过会抛出 -25299 错误代码，需要调用 SecItemUpdate 来进行更新
if status == errSecDuplicateItem {
    let q2 = [
        kSecClass: kSecClassGenericPassword,
        kSecAttrService: service,
        kSecAttrAccount: account
    ] as CFDictionary
    let q3 = [
        kSecValueData: d1
    ] as CFDictionary
    SecItemUpdate(q2, q3)
}

// 读取
let q4 = [
    kSecAttrService: service,
    kSecAttrAccount: account,
    kSecClass: kSecClassGenericPassword,
    kSecReturnData: true
] as CFDictionary

var re: AnyObject?
SecItemCopyMatching(q4, &re)
guard let reData = re as? Data else { return }
print(String(decoding: reData, as: UTF8.self)) // keyChain github token

// 删除
let q5 = [
    kSecAttrService: service,
    kSecAttrAccount: account,
    kSecClass: kSecClassGenericPassword,
] as CFDictionary

SecItemDelete(q5)
```

