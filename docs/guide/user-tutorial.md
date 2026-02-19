---
title: 用户使用教程
description: Minecraft 启动器详细使用指南
---

# Minecraft 启动器用户使用教程

这是一个功能完整的 Minecraft 启动器，支持自动下载游戏资源、管理多个游戏版本，并提供流畅的游戏启动体验。

## 简介

Minecraft 启动器是一个现代化的启动解决方案，专为 Minecraft 玩家和开发者设计。它提供了简单易用的界面和强大的功能特性。

## 系统要求

::: tip 系统兼容性
启动器经过优化，可在以下环境中稳定运行：
:::

- Windows 10/11
- .NET 10.0 或更高版本
- Java JDK 21 或更高版本
- 至少 4GB 可用内存

## 安装步骤

### 1. 环境准备

确保您的系统已安装以下软件：

**安装 .NET SDK**
```bash
# 从微软官网下载并安装 .NET 10.0 SDK
# https://dotnet.microsoft.com/download/dotnet/10.0
```

**安装 Java JDK**
```bash
# 推荐使用 JDK 21
# 从 Oracle 或 OpenJDK 下载安装
```

### 2. 项目构建

```bash
# 克隆或下载项目到本地
cd Kata3

# 恢复 NuGet 包
dotnet restore

# 构建项目
dotnet build

# 运行测试程序
dotnet run --project Kata3Test
```

## 基本使用

### 启动配置

在 `Program.cs` 中配置您的启动选项：

```csharp
var options = new LaunchOptions
{
    // Minecraft 数据目录
    MinecraftRoot = Path.GetFullPath(@".minecraft"),
    
    // 游戏版本
    VersionId = "1.19.2",
    
    // 工作目录
    WorkingDirectory = Path.GetFullPath(@".minecraft"),
    
    // Java 路径
    JavaPath = @"C:\Program Files\Java\jdk-21.0.10\bin\java.exe",
    
    // 账户信息
    Account = new Account
    {
        UserName = "您的用户名",
        Uuid = Guid.Parse("您的UUID"),
        AccessToken = "您的访问令牌",
        UserType = "msa"
    },
    
    // 内存设置
    MaxMemory = 4198,  // MB
    Width = 854,       // 窗口宽度
    Height = 480,      // 窗口高度
    
    // 其他选项
    UseVersionIsolation = true,
    OutputHandler = msg => Console.WriteLine($"[GAME] {msg}")
};
```

### 运行游戏

```bash
# 在项目根目录执行
dotnet run --project Kata3Test
```

## 功能特性

### 🚀 自动资源管理
- 自动下载缺失的游戏版本文件
- 自动验证客户端 JAR 文件完整性
- 并发下载游戏资源，提升下载速度

### 📦 版本管理
- 支持多版本 Minecraft 同时存在
- 自动检测和补全游戏文件
- 版本隔离模式支持

### ⚡ 性能优化
- 智能类路径构建
- 原生库自动提取
- 内存优化配置

## 常见问题

### Q: 游戏启动失败怎么办？

A: 检查以下几点：
- ✅ Java 路径是否正确配置
- ✅ Minecraft 数据目录权限是否足够
- ✅ 系统内存是否充足

### Q: 如何更换游戏版本？

A: 修改 `LaunchOptions` 中的 `VersionId` 参数：
```csharp
VersionId = "1.20.1"  // 更改为想要的版本
```

### Q: 资源下载很慢怎么办？

A: 
- 🔍 检查网络连接
- 🔥 确保防火墙未阻止下载
- 💾 可以手动下载资源文件到对应目录

### Q: 出现中文乱码怎么办？

A: 在 PowerShell 中执行：
```powershell
chcp 65001
$env:DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = "0"
```

## 故障排除

### 日志查看

程序会输出详细的调试信息，包括：
- 类路径构建详情
- 游戏参数处理过程
- 资源下载进度
- 启动参数预览

### 目录结构说明

```
.minecraft/
├── assets/          # 游戏资源文件
├── libraries/       # 游戏库文件
└── versions/        # 游戏版本文件
    └── 1.19.2/
        ├── 1.19.2.jar    # 客户端文件
        └── 1.19.2.json   # 版本配置
```

## 技术支持

如遇到问题，请提供：

1. **完整的错误日志**
2. **系统环境信息**
3. **配置文件内容**（敏感信息请脱敏）

---

::: info
**文档版本：** 1.0  
**最后更新：** 2026年2月
:::

::: tip 提示
如果您是开发者，建议查看我们的 [API 参考文档](../api/api-documentation) 和 [开发者文档](../developer/developer-guide) 获取更多技术细节。
:::