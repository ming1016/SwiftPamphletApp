ABI 稳定后，Swift 的核心团队可以开始关注 Swift 语言一直缺失的原生并发能力了。最初是由 [Chris Lattner](https://twitter.com/clattner_llvm) 在17年发的 [Swift并发宣言](https://gist.github.com/lattner/31ed37682ef1576b16bca1432ea9f782) ，从此开阔了大家的眼界。后来 Swift Evolution 社区讨论了十几个提案，几十个方案，以及几百页的设计文件，做了大量的改进，社区中用户积极的参与反馈，Chris 也一直在 Evolution 中积极的参与设计。

Swift Concurrency 的实现用了 [LLVM的协程](https://llvm.org/docs/Coroutines.html) 把 async/await 函数转换为基于回调的代码，这个过程发生在编译后期，这个阶段你的代码都没法辨识了。异步的函数被实现为 coroutines，在每次异步调用时，函数被分割成可调用的函数部分和后面恢复的部分。coroutine 拆分的过程发生在生成LLVM IR阶段。Swift使用了哪些带有自定义调用约定的函数保证尾部调用，并专门为Swift进行了调整。

Swift Concurrency 不是建立在 GCD 上，而是使用的一个全新的线程池。GCD 中启动队列工作会很快在提起线程，一个队列阻塞了线程，就会生成一个新线程。基于这种机制 GCD 线程数很容易比 CPU 核心数量多，线程多了，线程就会有大量的调度开销，大量的上下文切换，会使 CPU 运行效率降低。而 Swift Concurrency 的线程数量不会超过 CPU 内核，将上下文切换放到同一个线程中去做。为了实现线程不被阻塞，需要通过语言特性来做。做法是，每个线程都有一个堆栈记录函数调用情况，一个函数占一个帧。函数返回后，这个函数所占的帧就会从堆栈弹出。await 的 async 函数被作为异步帧保存在堆上等待恢复，而不阻碍其它函数入栈执行。在 await 后运行的代码叫 continuation，continuation 会在要恢复时放回到线程的堆栈里。异步帧会根据需要放回栈上。在一个异步函数中调用同步代码将添加帧到线程的堆栈中。这样线程就能够一直向前跑，而不用创建更多线程减少调度。

Douglas 在 Swift 论坛里发的 Swift Concurrency 下个版本的规划贴  [Concurrency in Swift 5 and 6](https://forums.swift.org/t/concurrency-in-swift-5-and-6/49337) ，论坛里还有一个帖子是专门用来 [征集Swift Concurrency意见](https://forums.swift.org/t/swift-concurrency-feedback-wanted/49336) 的，帖子本身列出了 Swift Concurrency 相关的所有提案，也提出欢迎有新提案发出来，除了这些提案可以看外，帖子回复目前已经过百，非常热闹，可以看出大家对 Swift Concurrency 的关注度相当的高。

非常多的人参与了 Swift Concurrency 才使其看起来和用起来那么简单。Doug Gregor 在参与 John Sundell 的播客后，发了很多条推聊 Swift Concurrency，可以看到参与的人非常多，可见背后付出的努力有多大。下面我汇总了 Doug Gregor 在推上发的一些信息，你通过这些信息也可以了解 Swift Concurrency 幕后信息，所做的事和负责的人。

 [@pathofshrines](https://twitter.com/pathofshrines) 是 Swift Concurrency 整体架构师，包括低级别运行时和编译器相关细节。 [@illian](https://twitter.com/illian) 是 async sequences、stream 和 Fundation 的负责人。 [@optshiftk](https://twitter.com/optshiftk) 对 UI 和并发交互的极好的洞察力带来了很棒的 async 接口， [@phausler](https://twitter.com/phausler) 带来了 async sequences。Arnold Schwaighofer、 [@neightchan](https://twitter.com/neightchan) 、 [@typesanitizer](https://twitter.com/typesanitizer) 还有 Tim Northover 实现了 async calling convention。

 [@ktosopl](https://twitter.com/ktosopl) 有很深厚的 actor、分布式计算和 Swift-on-Server 经验，带来了 actor 系统。Erik Eckstein 为 async 函数和actors建立了关键的优化和功能。

SwiftUI是 [@ricketson_](https://twitter.com/ricketson_) 和 [@luka_bernardi](https://twitter.com/luka_bernardi) 完成的async接口。async I/O的接口是 [@Catfish_Man](https://twitter.com/Catfish_Man) 完成的。 [@slava_pestov](https://twitter.com/slava_pestov) 处理了 Swift 泛型问题，还指导其他人编译器实现的细节。async 重构工具是Ben Barham 做的。大量代码移植到 async 是由 [@AirspeedSwift](https://twitter.com/AirspeedSwift) 领导，由 Angela Laar，Clack Cole，Nicole Jacques 和 [@mishaldshah](https://twitter.com/mishaldshah) 共同完成的。

 [@lorentey](https://twitter.com/lorentey) 负责 Swift 接口的改进。 [@jckarter](https://twitter.com/jckarter) 有着敏锐的语言设计洞察力，带来了语言设计经验和编译器及运行时实现技能。 [@mikeash](https://twitter.com/mikeash)  也参与了运行时开发中。操作系统的集成是 [@rokhinip](https://twitter.com/rokhinip) 完成的， [@chimz](https://twitter.com/chimz) 提供了关于 Dispatch 和 OS 很好的建议，Pavel Yaskevich 和
 [@hollyborla](https://ming1016.github.io/2021/07/24/my-little-idea-about-writing-technical-article/) 进行了并发所需要关键类型检查器的改进。 [@kastiglione](https://twitter.com/kastiglione) 、Adrian Prantl和 [@fred_riss](https://twitter.com/fred_riss) 实现了调试。 [@etcwilde](https://twitter.com/etcwilde) 和 [@call1cc](https://twitter.com/call1cc) 实现了语义模型中的重要部分。

 [@evonox](https://twitter.com/evonox) 负责了服务器Linux 的支持。 [@compnerd](https://twitter.com/compnerd) 将 Swift Concurrency 移植到了 Windows。

Swift Concurrency 模型简单，细节都被隐藏了，比 Kotlin 和 C++的 Coroutine 接口要简洁很多。比如 Task 接口形式就很简洁。Swift Concurrency 大体可分为 async/await、Async Sequences、结构化并发和 Actors。
