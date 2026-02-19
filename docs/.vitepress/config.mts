import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "Minecraft 启动器",
  description: "现代化的 Minecraft 启动器解决方案",
  base: '/',
  appearance: true,
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: '首页', link: '/' },
      { text: '快速开始', link: '/guide/user-tutorial' },
      { text: 'API 文档', link: '/api/api-documentation' },
      { text: '开发者指南', link: '/developer/developer-guide' },
      { 
        text: '更多', 
        items: [
          { text: 'GitHub 仓库', link: 'https://github.com/your-repo/kata3' },
          { text: '问题反馈', link: 'https://github.com/your-repo/kata3/issues' },
          { text: '更新日志', link: 'https://github.com/your-repo/kata3/releases' }
        ]
      }
    ],

    sidebar: [
      {
        text: '用户指南',
        items: [
          { text: '快速开始', link: '/guide/user-tutorial' }
        ]
      },
      {
        text: 'API 参考',
        items: [
          { text: '核心类参考', link: '/api/api-documentation#核心类参考' },
          { text: '服务类参考', link: '/api/api-documentation#服务类参考' },
          { text: '工具类参考', link: '/api/api-documentation#工具类参考' },
          { text: '使用示例', link: '/api/api-documentation#使用示例' }
        ]
      },
      {
        text: '开发者文档',
        items: [
          { text: '项目架构', link: '/developer/developer-guide#项目架构概述' },
          { text: '核心设计模式', link: '/developer/developer-guide#核心设计模式' },
          { text: '关键算法解析', link: '/developer/developer-guide#关键算法解析' },
          { text: '性能优化策略', link: '/developer/developer-guide#性能优化策略' }
        ]
      }
    ],

    socialLinks: [
      { icon: 'github', link: 'https://github.com/your-repo/kata3' }
    ],

    footer: {
      message: 'Released under the MIT License.',
      copyright: 'Copyright © 2026-present Kata3 Team'
    },

    // editLink: {
    //   pattern: 'https://github.com/your-repo/kata3/edit/main/docs/:path',
    //   text: '在 GitHub 上编辑此页面'
    // },

    // lastUpdated: {
    //   text: '最后更新',
    //   formatOptions: {
    //     dateStyle: 'short',
    //     timeStyle: 'medium'
    //   }
    // }
  },

  locales: {
    root: {
      label: '简体中文',
      lang: 'zh-CN'
    }
  }
})
