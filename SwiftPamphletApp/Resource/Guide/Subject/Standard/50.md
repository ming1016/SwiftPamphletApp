参考：

* [Swift Style Guide](https://google.github.io/swift/)

多用静态特性。swift 在编译期间所做的优化比 OC 要多，这是由于他的静态派发、泛型特化、写时复制这些静态特性决定的。另外通过 final  和 private 这样的表示可将动态特性转化为静态方式，编译开启 WMO 可以自动推导出哪些动态派发可转化为静态派发。

如何避免崩溃？

* 字典：用结构体替代
* Any：可用泛型或关联关联类型替代
* as? ：少用 AnyObject，多用泛型或不透明类型
* !：要少用

好的实践？

* 少用继承，多用 protocol
* 多用 extension 对自己代码进行管理
