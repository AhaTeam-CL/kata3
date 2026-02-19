---
title: 核心 API 参考
description: Minecraft 启动器核心组件 API 文档
---

# 核心 API 参考手册

本文档详细描述了 Minecraft 启动器核心库的公共接口和使用方法，适用于集成开发和二次开发场景。

## 文档概览

本参考手册包含以下核心组件的完整 API 规范：

- **启动核心** - 游戏启动流程控制
- **资源配置** - 版本和资源文件管理  
- **认证系统** - 用户身份验证机制
- **工具组件** - 辅助功能和实用工具

## 核心组件 API

### 启动器核心 (MinecraftLauncher)

游戏启动流程的主要控制器，封装了完整的启动逻辑和资源管理。

#### 构造器

```csharp
public MinecraftLauncher()
```

初始化启动器实例，准备启动环境。

#### 核心方法

##### LaunchAsync

执行异步游戏启动流程。

```csharp
public async Task<LaunchResult> LaunchAsync(
    LaunchOptions options, 
    IProgress<AssetDownloadProgress>? assetProgress = null)
```

**参数说明**

| 参数 | 类型 | 描述 |
|------|------|------|
| `options` | `LaunchOptions` | 启动配置参数 |
| `assetProgress` | `IProgress<AssetDownloadProgress>?` | 资源下载进度监听器 |

**返回类型**
`Task<LaunchResult>` - 启动操作结果

**使用示例**

```csharp
var launcher = new MinecraftLauncher();
var launchOptions = new LaunchOptions 
{ 
    /* 配置参数 */ 
};

var progressReporter = new Progress<AssetDownloadProgress>(progress => 
{
    Console.WriteLine($"资源下载: {progress.Percentage:F1}%");
});

var result = await launcher.LaunchAsync(launchOptions, progressReporter);

if (result.Success)
{
    Console.WriteLine("游戏启动成功");
    await result.Process.WaitForExitAsync();
}
else
{
    Console.WriteLine($"启动失败: {result.Error}");
}
```

##### EnsureGameIntegrityAsync

验证并确保游戏文件完整性，不执行实际启动。

```csharp
public async Task<VersionMeta> EnsureGameIntegrityAsync(
    string minecraftRoot, 
    string versionId)
```

**参数说明**

| 参数 | 类型 | 描述 |
|------|------|------|
| `minecraftRoot` | `string` | 游戏根目录路径 |
| `versionId` | `string` | 目标版本标识符 |

**返回类型**
`Task<VersionMeta>` - 版本元数据信息

### 启动配置 (LaunchOptions)

启动参数配置容器，定义游戏启动所需的所有设置。

#### 配置属性

| 属性 | 类型 | 必需 | 描述 |
|------|------|------|------|
| `MinecraftRoot` | `string` | ✓ | 游戏数据根目录 |
| `VersionId` | `string` | ✓ | 目标版本标识 |
| `WorkingDirectory` | `string` | ✓ | 工作目录路径 |
| `JavaPath` | `string` | ✓ | Java 可执行文件路径 |
| `Account` | `Account` | ✓ | 用户账户信息 |
| `MaxMemory` | `int` | | 最大内存分配(MB) |
| `MinMemory` | `int` | | 最小内存分配(MB) |
| `Width` | `int` | | 游戏窗口宽度 |
| `Height` | `int` | | 游戏窗口高度 |
| `UseVersionIsolation` | `bool` | | 版本隔离模式 |
| `JvmArguments` | `List<string>` | | 自定义 JVM 参数 |
| `GameArguments` | `List<string>` | | 自定义游戏参数 |
| `OutputHandler` | `Action<string>` | | 控制台输出处理器 |

### 账户信息 (Account)

用户身份凭证和认证信息容器。

#### 账户属性

| 属性 | 类型 | 必需 | 描述 |
|------|------|------|------|
| `UserName` | `string` | ✓ | 用户显示名称 |
| `Uuid` | `Guid` | ✓ | 用户唯一标识符 |
| `AccessToken` | `string` | ✓ | 认证访问令牌 |
| `ClientId` | `string` | | 客户端标识符 |
| `Xuid` | `string` | | Xbox 用户 ID |
| `UserType` | `string` | | 账户类型(默认:"msa") |

### 启动结果 (LaunchResult)

启动操作执行结果和状态信息。

#### 结果属性

| 属性 | 类型 | 描述 |
|------|------|------|
| `Success` | `bool` | 启动是否成功 |
| `Process` | `Process?` | 游戏进程实例 |
| `Error` | `string?` | 错误信息(失败时) |

## 资源管理 API

### 资源下载进度 (AssetDownloadProgress)

资源文件下载进度跟踪和报告。

#### 进度属性

| 属性 | 类型 | 描述 |
|------|------|------|
| `Completed` | `int` | 已完成文件数 |
| `Total` | `int` | 总文件数 |
| `Percentage` | `double` | 完成百分比 |

### 版本元数据 (VersionMeta)

游戏版本配置和依赖信息描述。

#### 元数据属性

| 属性 | 类型 | 描述 |
|------|------|------|
| `Id` | `string` | 版本标识符 |
| `MainClass` | `string` | 主启动类名 |
| `Libraries` | `List<Library>` | 依赖库列表 |
| `Arguments` | `Arguments?` | 启动参数配置 |
| `LegacyArguments` | `string?` | 传统参数格式 |
| `AssetIndex` | `AssetIndexRef?` | 资源索引引用 |
| `AssetsVersion` | `string?` | 资源版本号 |
| `ReleaseTime` | `DateTime` | 版本发布时间 |

## 工具组件 API

### 操作系统助手 (OsHelper)

跨平台操作系统检测和兼容性处理。

#### 核心方法

##### Matches

验证当前操作系统是否符合指定规则。

```csharp
public bool Matches(string? name, string? version, string? arch)
```

**参数说明**

| 参数 | 类型 | 描述 |
|------|------|------|
| `name` | `string?` | 操作系统名称 |
| `version` | `string?` | 系统版本要求 |
| `arch` | `string?` | 架构要求 |

### 路径助手 (PathHelper)

文件路径处理和目录管理工具。

#### 核心方法

##### GetNativeDirectory

获取原生库文件存储目录。

```csharp
public static string GetNativeDirectory(
    string minecraftRoot, 
    string versionId, 
    bool isolated)
```

**参数说明**

| 参数 | 类型 | 描述 |
|------|------|------|
| `minecraftRoot` | `string` | 游戏根目录 |
| `versionId` | `string` | 版本标识符 |
| `isolated` | `bool` | 是否启用版本隔离 |

### HTTP 下载器 (HttpDownloader)

网络资源下载和文件传输管理。

#### 核心方法

##### DownloadFileAsync

异步下载远程文件到本地。

```csharp
public async Task DownloadFileAsync(
    string url, 
    string destinationPath, 
    string? expectedHash = null, 
    CancellationToken cancellationToken = default)
```

**参数说明**

| 参数 | 类型 | 描述 |
|------|------|------|
| `url` | `string` | 文件下载地址 |
| `destinationPath` | `string` | 本地保存路径 |
| `expectedHash` | `string?` | 期望的SHA1校验值 |
| `cancellationToken` | `CancellationToken` | 取消令牌 |

## 高级使用模式

### 进度监控示例

```csharp
// 创建详细的进度报告器
var detailedProgress = new Progress<AssetDownloadProgress>(progress => 
{
    var barLength = 30;
    var filledLength = (int)(barLength * progress.Percentage / 100);
    var progressBar = new string('█', filledLength) + 
                     new string('░', barLength - filledLength);
    
    Console.WriteLine($"\r[{progressBar}] {progress.Percentage:F1}% " +
                     $"({progress.Completed}/{progress.Total})");
});

var result = await launcher.LaunchAsync(options, detailedProgress);
```

### 错误处理最佳实践

```csharp
try 
{
    var result = await launcher.LaunchAsync(launchOptions);
    
    if (!result.Success) 
    {
        // 记录启动失败信息
        Logger.LogError($"启动失败: {result.Error}");
        HandleLaunchFailure(result.Error);
        return;
    }
    
    // 监控游戏进程生命周期
    result.Process.Exited += (sender, e) => 
    {
        Logger.LogInformation("游戏进程正常退出");
    };
    
    await result.Process.WaitForExitAsync();
}
catch (FileNotFoundException ex)
{
    Logger.LogError($"缺少必要文件: {ex.Message}");
    // 可触发自动文件完整性检查
    await launcher.EnsureGameIntegrityAsync(rootPath, versionId);
}
catch (UnauthorizedAccessException ex)
{
    Logger.LogError($"权限不足: {ex.Message}");
    // 提示用户检查目录权限
}
catch (Exception ex)
{
    Logger.LogError($"未知错误: {ex.Message}");
    // 记录完整异常堆栈
}
```

### 配置验证模式

```csharp
public class LaunchConfigurationValidator
{
    public ValidationResult Validate(LaunchOptions options)
    {
        var errors = new List<string>();
        
        // 必需字段验证
        if (string.IsNullOrWhiteSpace(options.JavaPath))
            errors.Add("Java 路径未配置");
            
        if (!File.Exists(options.JavaPath))
            errors.Add("指定的 Java 路径不存在");
            
        if (options.MaxMemory < 512)
            errors.Add("内存分配过低(<512MB)");
            
        if (options.MaxMemory > 16384)
            errors.Add("内存分配过高(>16GB)");
            
        // 路径安全性检查
        if (!Path.IsPathRooted(options.MinecraftRoot))
            errors.Add("游戏目录必须使用绝对路径");
            
        return new ValidationResult(!errors.Any(), errors);
    }
}
```

## 性能优化建议

### 资源管理优化

- 合理设置并发下载数(推荐: 4-8个连接)
- 复用 HttpDownloader 实例避免重复初始化
- 及时清理临时下载文件释放磁盘空间

### 内存使用优化

- 根据系统配置动态调整 MaxMemory 值
- 避免同时加载多个版本的元数据
- 及时释放不再使用的对象引用

### 网络传输优化

- 利用 CDN 加速资源下载
- 实现断点续传减少重复下载
- 设置合理的下载超时时间

---

::: info
**API 版本：** 1.0  
**最后更新：** 2026年2月  
**兼容性：** .NET 10.0+, Windows 10/11
:::

::: tip 提示
建议在生产环境中启用详细的日志记录以便问题诊断，
并定期验证游戏文件完整性确保最佳运行体验。
:::