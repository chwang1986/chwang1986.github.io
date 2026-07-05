# 项目文档目录

本目录存放项目的开发文档、部署脚本和页面模板。

## 项目说明

**Mac 新手入门站** — 一个专注于 macOS 入门教程的静态网站，部署在 GitHub Pages 上。

## 文件说明

| 文件 | 说明 |
|------|------|
| `deploy.sh` | GitHub Pages 部署脚本（完整版，含配置说明） |
| `gitee-deploy.sh` | Gitee (码云) Pages 部署脚本 |
| `github-pages-deployment-guide.html` | GitHub Pages 部署步骤图文指南 |
| `project-structure.html` | 项目文件结构总览页面 |
| `_templates/` | HTML 页面模板（开发新页面时复制使用） |

## 根目录保留的脚本

| 文件 | 说明 |
|------|------|
| `start.sh` | 本地预览服务器（会自动打开浏览器） |
| `push-to-github.sh` | GitHub 快速推送脚本 |

## 使用方式

### 本地预览
```bash
cd /Users/wangchao/Documents/trae_workhome/wang_gitpage
bash start.sh
```

### 推送到 GitHub
```bash
cd /Users/wangchao/Documents/trae_workhome/wang_gitpage
bash push-to-github.sh
```
