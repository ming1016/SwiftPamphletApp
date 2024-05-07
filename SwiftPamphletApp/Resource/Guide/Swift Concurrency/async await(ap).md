通过类似 throws 语法的 async 来指定函数为异步函数，异步函数才能够使用 await，使用异步函数要用 await。await 修饰在 suspension point 时当前线程可以让给其它任务执行，而不用阻塞当前线程，等 await 后面的函数执行完成再回来继续执行，这里需要注意的是回来执行不一定是在离开时的线程上。async/await 提案是 [SE-0296](https://github.com/apple/swift-evolution/blob/main/proposals/0296-async-await.md) 。如果想把现有的异步开发带到 async/await 世界，请使用 withCheckedThrowingContinuation。

async/await 还有一个非常明显的好处，就是不会再有[weak self] dance 了。
