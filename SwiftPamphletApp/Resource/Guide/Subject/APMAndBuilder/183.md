[Improve app size and runtime performance](https://developer.apple.com/videos/play/wwdc2022/110363)

今年苹果通过更有效的检查 Swift 协议，使 OC 消息发送调用更小，使 autorelease elision 更快更小这几个个方面来让 App 体积更小，性能更高。

Swift 协议检查。

一个协议通过 as 操作符检查传递值是否符合协议，这种检查会在编译器的构建时间被优化掉，所以往往需要在运行时借助之前计算协议检查元数据来看对象是否真的符合了协议。一些元数据是在编译时建的，但还有很多元数据只能在启动时建立，特别是使用泛型时。协议多了，会增加耗时，差不多会多一半启动时间。

今年 Apple 推出新的 Swift 运行时，可以提前计算 Swift 协议元数据，作为 App 可执行文件和它在启动时使用的任何动态库的 dyld 闭包的一部分。这个是在系统上的，因此，只要是使用了今年最新系统的 App 都会享受这个优化，可以理解为，新系统上启动老 App 也会快些。

消息发送。

Xcode 14 中新的编译器和链接器已经将 ARM64 的消息发送调用从 12 字节减少到 8 字节。因此如果你的 App 都是 OC 代码的话，使用 Xcode 14 编出来的二进制文件可以少 2%。老系统也有效。

使用 objc_stubs_small 选项可以只优化大小，获得最大的大小优化。objc_msgSend 调动有 8 个字节指令，也就是2个指令是专门用来准备 selector 的，对于任何特定的 selector，总是相同的代码，由于始终是相同的代码，那么就可以对其共享，每个 selector 只 emit 一次，而不是每次发送消息时都 emit。共享这段代码地方是一个叫 selector stub 的函数。

ARC 会在编译器插入大量的 c 的 retain/release 函数调用。这些调用遵守平台应用二进制接口（ABI）所定义的 c 语言 call convention。也就意味着我们要更多代码来完成这些调用，用来传递正确寄存器的指针。Apple 今年推出了自定义的 call convention 根据指针位置，适时使用正确变量而不用移动它，从而摆脱了调用里的多余代码。Apple 果然是坚持用户体验优先，为了更好体验不惜修改 c 的 ABI。

autorelease elision 。

App 今年对 objc 运行时进行了修改，使 autorelease elision 更小更快。deployment target 为 iOS 16 今年新系统时才可享用哦。

Apple 怎么做的呢？

ARC 在调用方插入一个 retain，在被调用的函数中插入一个 release。当我们返回我们的临时对象时，我们需要在函数中先释放它，因为它要离开 scope。在它还没有任何其它引用时还不能这么做，不然返回前他就会被销毁。Apple 现在使用一个新的 convention ，让其可以返回临时对象。做法是当返回一个自动释放值，编译器会发出一个特殊标记，这个标记会告诉运行时这是符合自动释放条件的。它的后面是 retain，我们会在后面执行。获取返回地址，也就是一个指针，将它先保存起来，然后离开运行时的自动释放调用。在运行时，可以将保留时得到的指正和先前做自动释放时保存的指针进行比较，这样标记指令不再是数据之间的比较，比较指针内存访问少。比较成功就可以省去 autorelease/retain。

autorelease elision 的优化同样也可以减少 2% 大小。感谢 Apple 为了用户和开发者 OKR 的付出。

