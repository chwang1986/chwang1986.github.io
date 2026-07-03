#!/bin/bash
# GitHub Pages 一键部署脚本
# 使用前请确保已在 GitHub 创建同名仓库，并已生成 Personal Access Token

echo "===== Trae Work 部署脚本 ====="
echo ""

# 检查是否在正确的目录
if [ ! -f "index.html" ]; then
    echo "错误：请在 tra_e_workhome 目录下运行此脚本"
    exit 1
fi

# 设置 GitHub 用户名和仓库名
GITHUB_USER="chwang1986"
REPO_NAME="chwang1986.github.io"

echo "GitHub 用户: $GITHUB_USER"
echo "仓库名称: $REPO_NAME"
echo ""

# 配置远程仓库
git remote remove origin 2>/dev/null
git remote add origin https://github.com/$GITHUB_USER/$REPO_NAME.git

echo "远程仓库已配置: https://github.com/$GITHUB_USER/$REPO_NAME.git"
echo ""

# 推送代码
echo "正在推送到 GitHub..."
echo "提示：如果要求输入密码，请使用你的 GitHub Personal Access Token"
echo ""
git push -u origin main

echo ""
echo "===== 部署完成 ====="
echo ""
echo "接下来请在 GitHub 上启用 Pages:"
echo "1. 访问 https://github.com/$GITHUB_USER/$REPO_NAME/settings/pages"
echo "2. Source 选择 'Deploy from a branch'"
echo "3. Branch 选择 'main'，Folder 选择 '/ (root)'"
echo "4. 点击 Save"
echo ""
echo "等待 1-2 分钟后访问:"
echo "https://$GITHUB_USER.github.io/$REPO_NAME/"
