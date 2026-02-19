# Minecraft 启动器

现代化的 Minecraft 启动器解决方案，基于 .NET 技术栈构建。

## 🚀 特性

- **自动资源管理** - 智能下载和验证游戏文件
- **多版本支持** - 同时管理多个 Minecraft 版本
- **性能优化** - 高效的启动流程和内存管理
- **易于集成** - 简洁的 API 设计和完善的文档

## 📚 文档

访问我们的在线文档获取更多信息：

- [快速开始指南](./docs/guide/user-tutorial.md)
- [API 参考文档](./docs/api/api-documentation.md)
- [开发者文档](./docs/developer/developer-guide.md)

或者访问在线文档网站：[文档链接]

## 🛠️ 技术栈

- .NET 10.0+
- C# 10+
- VitePress (文档站点)
- Vue 3.5

## 📦 安装

```bash
# 克隆仓库
git clone https://github.com/your-repo/kata3.git
cd kata3

# 安装依赖
yarn install

# 构建项目
dotnet build

# 运行测试
dotnet run --project Kata3Test
```

## 📖 使用示例

```csharp
using Kata3.Launcher.Core;
using Kata3.Launcher.Core.Models.Auth;
using Kata3.Launcher.Core.Models.Launch;

var launcher = new MinecraftLauncher();
var options = new LaunchOptions
{
    MinecraftRoot = Path.GetFullPath(@".minecraft"),
    VersionId = "1.19.2",
    JavaPath = @"C:\Program Files\Java\jdk-21.0.10\bin\java.exe",
    Account = new Account
    {
        UserName = "player123",
        Uuid = Guid.Parse("00000000-ffff-ffff-ffff-ffffffff4de2"),
        AccessToken = "your-access-token"
    },
    MaxMemory = 4096
};

var result = await launcher.LaunchAsync(options);
if (result.Success)
{
    Console.WriteLine("游戏启动成功！");
}
```

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

1. Fork 仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启 Pull Request

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情

## 📞 支持

如有问题，请：
1. 查看 [文档](./docs/)
2. 提交 [Issue](https://github.com/your-repo/kata3/issues)
3. 联系开发团队