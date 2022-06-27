session [Debug Swift debugging with LLDB](https://developer.apple.com/videos/play/wwdc2022-110370)

编译器编译 swift 文件生成 `.o` 文件会有 `__debug_info` 段，其中有可以映射到源文件和行号的地址。debug 信息可以链接到 `.dSYM` 包。debug 信息链接器叫 dsymutil，dsymutil 可以为每个动态库、framework 或 dylib 和可执行文件打包一个 debug 信息存档（`.dSYM` 包）。

image 和路径怎么重映射。使用 `image list nameOfFramework` 来检查 LLDB 是否找到了我们应用程序里嵌入的第三方框架的 debug dSYM。使用 `image lookup 0xMemoryAddressHere` 获取当前地址更多信息。要重新映射源文件 `.dSYM` 路径，使用 `settings set target.source-map old/path new/path`。每个 `.dSYM` 都有一个 `UUID.plist`，我们可以在其中设置 DBGSourcePathRemapping 这个字典。

Xcode 14 新增 `swift-healthcheck` 命令，这个命令可以了解 module 为何导入失败。

LLDB 怎么找到 Swift module？每个 `.dSYM` 包都可以包含二级制 swift module，其中可能包含桥头文件、swift 接口文件 `.swiftinterface`，还有 debug 信息。静态存档不是由链接器生成的，需要向链接器注册 swift module，使用 `ld ... -add-ast-path /path/to/My.swiftmodule` ，动态库和可执行文件的话，Xcode 会自动完成此操作。可以使用 dsymutil 来 dump 你可执行文件的符号表，并用 grep 找 swiftmodule，命令是 `dsymutil -s MyApp | grep .swiftmodule` 。

