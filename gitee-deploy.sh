#!/bin/bash
# ============================================
# Gitee (码云) 一键部署脚本
# 国内访问速度比 GitHub Pages 快很多
# ============================================

set -e

REPO_NAME="trae-work"
GITEE_USER="chwang1986"

echo "===== Gitee Pages 部署脚本 ====="
echo ""

# 检查目录
if [ ! -f "index.html" ]; then
    echo "错误：请在项目根目录运行此脚本"
    exit 1
fi

# 检查 git
if ! command -v git &> /dev/null; then
    echo "错误：未找到 git，请先安装"
    exit 1
fi

echo "1. 配置 Gitee 远程仓库..."
git remote remove gitee 2>/dev/null || true
git remote add gitee "https://gitee.com/${GITEE_USER}/${REPO_NAME}.git" 2>/dev/null || git remote set-url gitee "https://gitee.com/${GITEE_USER}/${REPO_NAME}.git"

echo "2. 推送到 Gitee..."
echo "   提示：如果要求输入密码，请使用 Gitee 的私人令牌"
git push -u gitee main

echo ""
echo "3. 启用 Gitee Pages..."
echo "   请手动完成以下步骤："
echo "   a. 访问 https://gitee.com/${GITEE_USER}/${REPO_NAME}"
echo "   b. 点击 服务 → Gitee Pages"
echo "   c. 部署分支选择 main，部署目录选择 /"
echo "   d. 点击 启动"
echo ""
echo "4. 访问地址："
echo "   https://${GITEE_USER}.gitee.io/${REPO_NAME}"
echo ""
echo "===== 部署完成 ====="
