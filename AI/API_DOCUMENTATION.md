# Minecraft 启动器 API 文档

## 概述

这是一个面向开发者的 API 文档，详细介绍了 Minecraft 启动器的核心组件和使用方法。

## 核心类参考

### MinecraftLauncher

主启动器类，负责协调整个启动流程。

#### 构造函数
```csharp
public MinecraftLauncher()
```

#### 方法

##### LaunchAsync
异步启动 Minecraft 游戏。

**签名：**
```csharp
public async Task<LaunchResult> LaunchAsync(
    LaunchOptions options, 
    IProgress<AssetDownloadProgress>? assetProgress = null)
```

**参数：**
- `options`: 启动选项配置
- `assetProgress`: 资源下载进度回调（可选）

**返回值：**
- `LaunchResult`: 启动结果对象

**示例：**
```csharp
var launcher = new MinecraftLauncher();
var result = await launcher.LaunchAsync(options, progress);
if (result.Success)
{
    await result.Process.WaitForExitAsync();
}
```

##### EnsureGameIntegrityAsync
仅检查并补全游戏文件，不启动游戏。

**签名：**
```csharp
public async Task<VersionMeta> EnsureGameIntegrityAsync(
    string minecraftRoot, 
    string versionId)
```

**参数：**
- `minecraftRoot`: Minecraft 根目录路径
- `versionId`: 版本 ID

**返回值：**
- `VersionMeta`: 版本元数据

### LaunchOptions

启动配置选项类。

#### 属性

| 属性 | 类型 | 描述 |
|------|------|------|
| MinecraftRoot | string | Minecraft 数据根目录 |
| VersionId | string | 游戏版本 ID |
| WorkingDirectory | string | 工作目录 |
| JavaPath | string | Java 可执行文件路径 |
| Account | Account | 账户信息 |
| MaxMemory | int | 最大内存（MB） |
| MinMemory | int | 最小内存（MB） |
| Width | int | 窗口宽度 |
| Height | int | 窗口高度 |
| UseVersionIsolation | bool | 是否使用版本隔离 |
| JvmArguments | List<string> | 额外的 JVM 参数 |
| GameArguments | List<string> | 额外的游戏参数 |
| OutputHandler | Action<string> | 输出处理回调 |

### Account

Minecraft 账户信息类。

#### 属性

| 属性 | 类型 | 描述 |
|------|------|------|
| UserName | string | 用户名 |
| Uuid | Guid | 用户 UUID |
| AccessToken | string | 访问令牌 |
| ClientId | string | 客户端 ID |
| Xuid | string | Xbox 用户 ID |
| UserType | string | 用户类型（默认 "msa"） |

### LaunchResult

启动结果类。

#### 属性

| 属性 | 类型 | 描述 |
|------|------|------|
| Success | bool | 启动是否成功 |
| Process | Process? | 启动的游戏进程 |
| Error | string? | 错误信息（如果启动失败） |

## 服务类参考

### AssetDownloadProgress

资源下载进度类。

#### 属性

| 属性 | 类型 | 描述 |
|------|------|------|
| Completed | int | 已完成数量 |
| Total | int | 总数量 |
| Percentage | double | 完成百分比 |

### VersionMeta

版本元数据类。

#### 属性

| 属性 | 类型 | 描述 |
|------|------|------|
| Id | string | 版本 ID |
| MainClass | string | 主类名称 |
| Libraries | List<Library> | 依赖库列表 |
| Arguments | Arguments? | 启动参数 |
| LegacyArguments | string? | 旧版参数 |
| AssetIndex | AssetIndexRef? | 资源索引引用 |
| AssetsVersion | string? | 资源版本 |
| ReleaseTime | DateTime | 发布时间 |

## 工具类参考

### OsHelper

操作系统辅助类。

#### 方法

##### Matches
检查操作系统规则是否匹配。

**签名：**
```csharp
public bool Matches(string? name, string? version, string? arch)
```

### PathHelper

路径辅助类。

#### 方法

##### GetNativeDirectory
获取原生库目录路径。

**签名：**
```csharp
public static string GetNativeDirectory(
    string minecraftRoot, 
    string versionId, 
    bool isolated)
```

### HttpDownloader

HTTP 下载器类。

#### 方法

##### DownloadFileAsync
异步下载文件。

**签名：**
```csharp
public async Task DownloadFileAsync(
    string url, 
    string destinationPath, 
    string? expectedHash = null, 
    CancellationToken cancellationToken = default)
```

## 使用示例

### 基本启动示例

```csharp
using Kata3.Launcher.Core;
using Kata3.Launcher.Core.Models.Auth;
using Kata3.Launcher.Core.Models.Launch;

// 配置账户信息
var account = new Account
{
    UserName = "player123",
    Uuid = Guid.Parse("00000000-ffff-ffff-ffff-ffffffff4de2"),
    AccessToken = "your-access-token",
    UserType = "msa"
};

// 配置启动选项
var options = new LaunchOptions
{
    MinecraftRoot = Path.GetFullPath(@".minecraft"),
    VersionId = "1.19.2",
    WorkingDirectory = Path.GetFullPath(@".minecraft"),
    JavaPath = @"C:\Program Files\Java\jdk-21.0.10\bin\java.exe",
    Account = account,
    MaxMemory = 4096,
    Width = 854,
    Height = 480,
    UseVersionIsolation = true,
    OutputHandler = msg => Console.WriteLine($"[GAME] {msg}")
};

// 创建进度回调
var progress = new Progress<AssetDownloadProgress>(p =>
{
    Console.WriteLine($"下载进度: {p.Completed}/{p.Total} ({p.Percentage:F1}%)");
});

// 启动游戏
var launcher = new MinecraftLauncher();
var result = await launcher.LaunchAsync(options, progress);

if (result.Success)
{
    Console.WriteLine("游戏启动成功！");
    await result.Process.WaitForExitAsync();
    Console.WriteLine("游戏已退出。");
}
else
{
    Console.WriteLine($"启动失败: {result.Error}");
}
```

### 仅检查文件完整性

```csharp
var launcher = new MinecraftLauncher();
try
{
    var versionMeta = await launcher.EnsureGameIntegrityAsync(
        @".minecraft", 
        "1.19.2");
    Console.WriteLine($"版本 {versionMeta.Id} 文件完整");
}
catch (Exception ex)
{
    Console.WriteLine($"文件检查失败: {ex.Message}");
}
```

## 错误处理

### 常见异常类型

| 异常类型 | 触发条件 |
|----------|----------|
| FileNotFoundException | 缺少必要的游戏文件 |
| InvalidOperationException | 配置无效或不完整 |
| HttpRequestException | 网络下载失败 |
| UnauthorizedAccessException | 文件访问权限不足 |

### 最佳实践

```csharp
try
{
    var result = await launcher.LaunchAsync(options);
    
    if (!result.Success)
    {
        // 处理启动失败
        LogError(result.Error);
        return;
    }
    
    // 监控游戏进程
    result.Process.Exited += (sender, e) => {
        Console.WriteLine("游戏进程已退出");
    };
}
catch (FileNotFoundException ex)
{
    Console.WriteLine($"缺少文件: {ex.Message}");
    // 可以调用 EnsureGameIntegrityAsync 来自动补全
}
catch (Exception ex)
{
    Console.WriteLine($"启动过程中发生错误: {ex.Message}");
}
```

## 性能优化建议

### 资源管理
- 合理设置并发下载数量
- 复用 HttpDownloader 实例
- 及时清理临时文件

### 内存使用
- 根据系统配置调整 MaxMemory
- 避免同时加载过多版本数据
- 及时释放不需要的对象

### 网络优化
- 使用 CDN 加速资源下载
- 实现断点续传功能
- 添加下载超时控制

---
*API 版本：1.0*
*最后更新：2026年2月*