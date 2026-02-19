---
# https://vitepress.dev/reference/default-theme-home-page
layout: home

hero:
  name: "Minecraft 启动器"
  text: "现代化的启动解决方案"
  tagline: 功能强大、易于使用的 Minecraft 启动器，支持自动资源管理、多版本支持和性能优化
  image:
    src: /logo.png
    alt: Minecraft Launcher Logo
  actions:
    - theme: brand
      text: 快速开始
      link: /guide/user-tutorial
    - theme: alt
      text: API 参考
      link: /api/api-documentation
    - theme: alt
      text: GitHub
      link: https://github.com/your-repo/kata3

features:
  - icon: 🚀
    title: 自动资源管理
    details: 自动下载缺失的游戏文件，验证客户端完整性，并发下载提升速度
  - icon: 📦
    title: 多版本支持
    details: 支持多个 Minecraft 版本同时存在，智能版本隔离和文件管理
  - icon: ⚡
    title: 性能优化
    details: 智能类路径构建，原生库自动提取，内存优化配置
  - icon: 🔧
    title: 易于集成
    details: 简洁的 API 设计，完善的文档支持，丰富的配置选项
  - icon: 🛡️
    title: 安全可靠
    details: 严格的输入验证，安全的路径处理，完善的错误处理机制
  - icon: 📚
    title: 完善文档
    details: 详细的用户指南、API 参考和开发者文档
---

<div class="vp-doc">

## 为什么选择我们的启动器？

Minecraft 启动器是一个专为现代 Minecraft 玩家和开发者设计的高性能启动解决方案。

### 🎯 核心优势

- **开箱即用** - 简单配置即可快速启动游戏
- **智能管理** - 自动处理游戏资源下载和版本管理
- **高性能** - 优化的启动流程和内存使用
- **可扩展** - 模块化设计，易于定制和扩展

### 🏗️ 技术特点

```csharp
var launcher = new MinecraftLauncher();
var result = await launcher.LaunchAsync(options);

if (result.Success)
{
    Console.WriteLine("游戏启动成功！");
}
```

### 📊 当前状态

- 支持 Minecraft 1.19+ 版本
- Windows 10/11 完全兼容
- .NET 10.0+ 运行时支持
- 持续更新和维护

## 快速链接

<div class="container">
  <div class="grid">
    <div class="card">
      <h3>🎮 用户指南</h3>
      <p>了解如何安装、配置和使用启动器</p>
      <a href="/guide/user-tutorial">查看详情 →</a>
    </div>
    <div class="card">
      <h3>📚 API 参考</h3>
      <p>开发者 API 文档和使用示例</p>
      <a href="/api/api-documentation">查看详情 →</a>
    </div>
    <div class="card">
      <h3>🔧 开发者文档</h3>
      <p>深入了解项目架构和设计模式</p>
      <a href="/developer/developer-guide">查看详情 →</a>
    </div>
  </div>
</div>

<style>
.container {
  max-width: 1200px;
  margin: 2rem auto;
  padding: 0 1rem;
}

.grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
  margin-top: 2rem;
}

.card {
  border: 1px solid var(--vp-c-divider);
  border-radius: 8px;
  padding: 1.5rem;
  transition: border-color 0.25s, box-shadow 0.25s;
}

.card:hover {
  border-color: var(--vp-c-brand);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.card h3 {
  margin-top: 0;
  color: var(--vp-c-text-1);
}

.card p {
  color: var(--vp-c-text-2);
  margin: 0.5rem 0 1rem 0;
}

.card a {
  color: var(--vp-c-brand);
  text-decoration: none;
  font-weight: 500;
}

.card a:hover {
  text-decoration: underline;
}
</style>

</div>

