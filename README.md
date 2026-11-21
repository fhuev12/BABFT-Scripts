# BABFT-Scripts

Roblox「造船寻宝」（Build A Boat For Treasure）自动刷钱脚本 —— LZSS 压缩 + 随机密钥异或 + Base64 分片保护构建。

## 调用

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/fhuev12/BABFT-Scripts/main/BABFT_AutoFarm_v1.lua"))()
```

## 构建参数

| 项目 | 值 |
| --- | --- |
| 源文件 | `造船尋寶自動刷錢(1)(1).lua`（329,229 B / 3 行，CRLF） |
| 源 SHA-256 | `b93de4bd81de25d07aa8897df6c4529301b9ca24ec177998018566150aef1a7f` |
| 压缩算法 | LZSS（window 32768 / maxlen 255 / min match 3） |
| 加密 | 4 B 小端压缩长度头 + 28 字符随机密钥循环 XOR |
| 载荷 | Base64 43,692 字符 → 4 片，每片 10,923 B |
| 加载器 | `BABFT_AutoFarm_v1.lua`（3,446 B，blob `366b22fe…`） |
| 密文体积 | 32,764 B（压缩率 10.0%） |

## 目录

```
BABFT_AutoFarm_v1.lua              加载器（解码+解压+执行）
parts/BABFT_AutoFarm_v1.p1.txt     分片 1 / 10,923 B / blob c81e9005…
parts/BABFT_AutoFarm_v1.p2.txt     分片 2 / 10,923 B / blob 54240749…
parts/BABFT_AutoFarm_v1.p3.txt     分片 3 / 10,923 B / blob 92c02c90…
parts/BABFT_AutoFarm_v1.p4.txt     分片 4 / 10,923 B / blob 6d9ac978…
```

## 验证

加载器逐片 `game:HttpGet` 拉取 → 拼接 → 去空白 → Base64 解码 → `bit32.bxor` 解密 → LZSS 解压 → 校验长度头 → `loadstring` 执行。

线上端到端复验：从 `raw.githubusercontent.com` 下载加载器 + 全部 4 片（均 HTTP 200，字节数 3,446 / 10,923×4 一致），用本地桩解码后 SHA-256 = `b93de4bd81de25d07aa8897df6c4529301b9ca24ec177998018566150aef1a7f`，与源文件逐字节相同；解码产物 `luac -p` 编译检查通过（无语法错误）。

## 关于源文件（重要）

本批源文件**本身已经是 VM 级混淆产物**，不是明文脚本：

- 首行注释标注作者 `BABFT AUTO FARM MADE BY Lemon Juice#5058`。
- 整体是 `return (function(string.byte, table.insert, setmetatable) … end)(…)` 形式，内部全部标识符被重写为 `BuildaboatafkautofarmUPDATED_*` 随机后缀，字符串表加密后运行时组装，并夹带 `"1 + 1 = 111"` 类垃圾常量。
- 静态扫描 `FireServer` / `GetService` / `HttpGet` / `loadstring` / `getgenv` / `webhook` 等关键字，命中数**全为 0** —— 所有字符串均在运行时解密，无法不执行代码就还原行为。

因此本仓库实际是**双层保护**：作者混淆层在内，本构建的 LZSS+XOR+Base64 分片层在外。也正因为已经混淆、且字符串全部加密，无法像其他批次那样给出「无后门」的静态结论；只能确认解码产物与交付给你的源文件逐字节一致，未做任何内容增减。

## 警告

这是第三方辅助脚本，未经行为审计。自动刷钱与高频远程调用违反 Roblox 服务条款，存在封号风险；执行器环境下运行未知混淆代码也存在被窃取凭证的可能。仅自行承担使用后果。
