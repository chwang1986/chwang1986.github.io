# 学习用 VitePress 做静态网站项目

🚀 这是一个使用 [VitePress](https://vitepress.dev/) 构建的静态文档/博客网站项目，托管于 GitHub Pages。

## ✨ 项目想法

- 我有一些本地 Markdown 文件
- 将本地 Markdown 文件转换为现代化静态网站
- 利用 VitePress 的快速构建和响应式布局
- 通过 GitHub 实现自动化部署和版本控制
- 创建个人知识库、技术文档或博客平台

## 📦 前置要求

- Node.js 
- npm（我是Windows平台，其他工具也可以）
- Git

## 🛠️ 本地开发指南

### 1. 创建目录存放自己的MD文件
```
mkdir my_markdowns
cd my_markdowns
```

### 2. 初始化一个 Node.js 项目
```bash
npm init -y
```
这一个快速初始化命令，用来在当前文件夹，自动生成一个默认的 package.json 文件（项目配置文件）。 “-y” 就是跳过交互式提问。

### 3. 安装 VitePress
- 安装 VitePress 和 Vue 作为开发依赖：
     ```bash
     npm install --save-dev vitepress vue
     ```
     “--save-dev”表示将安装的包记录到 package.json中的项目依赖部分，但是不用包含在生产环境中。（这一点我还要体会）

     “vitepress”是我们的主角，他是一个基于 Vite 和 Vue 的静态站点生成器，适合构建文档、博客等静态网站。（我还要多学学）

     “vue”，Vue.js 是 VitePress 的底层框架。

   - 初始化 VitePress 项目：
   	 在这个目录内，执行下面的初始化命令
     ```bash
     npx vitepress init
     ```
     - 第一步提问“where should VitePress initalize the config?”,可以填写docs。这样就是将文档存储在 `docs` 文件夹。这会生成一个基本的 VitePress 项目结构：
       ```
       .
       ├── docs
       │   ├── .vitepress
       │   │   └── config.js
       │   └── index.md
       ├── node_modules
       └── package.json
       ```
```bash
npm run docs:dev
```
访问 `http://localhost:5173`

### 4. 编写内容
- 所有 Markdown 文件放在 `/docs` 目录下
- 修改 `docs/.vitepress/config.js` 进行配置
- 实时预览会自动更新

## 🏗️ 项目结构

```
.
├── docs/                 # 文档根目录
│   ├── index.md          # 首页
│   └── .vitepress/       # VitePress 配置
│       ├── config.js     # 配置文件(或者mts文件)
├── package.json
└── README.md
```

## 🚀 构建与部署

### 构建静态文件
```bash
npm run docs:build
```
生成的文件会在 `docs/.vitepress/dist` 目录
