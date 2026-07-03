#!/bin/bash
# ============================================
# GitHub 推送脚本 — 一键同步代码到 GitHub
# 
# 首次使用前的配置（只需执行一次）：
#   1. 在 GitHub 创建仓库（仓库名: trae-work）
#   2. 生成 Personal Access Token:
#      https://github.com/settings/tokens → Generate new token
#      勾选 "repo" 权限
#   3. 配置本脚本（两种方式选一种）：
#      
#      方式A - 环境变量（推荐）:
#        export GITHUB_USER="你的用户名"
#        export GITHUB_TOKEN="ghp_xxxxxxxx"
#      
#      方式B - 直接修改本脚本第 25-26 行
#
# 用法: bash push-to-github.sh
# ============================================

set -e

# ---------- 配置区（请修改为你自己的信息）----------
GITHUB_USER="${GITHUB_USER:-chwang1986}"
GITHUB_TOKEN="${GITHUB_TOKEN:-}"
REPO_NAME="chwang1986.github.io"
BRANCH="main"
# --------------------------------------------------

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "===== GitHub 推送脚本 ====="
echo ""

# 检查配置
if [ -z "$GITHUB_TOKEN" ]; then
    echo "⚠️  未配置 GitHub Token"
    echo ""
    echo "请按以下步骤配置："
    echo "1. 访问 https://github.com/settings/tokens"
    echo "2. 点击 'Generate new token (classic)'"
    echo "3. 勾选 'repo' 权限，生成 Token"
    echo "4. 配置方式（二选一）："
    echo "   方式A - 临时生效:"
    echo "     export GITHUB_TOKEN='ghp_你的token'"
    echo "     bash push-to-github.sh"
    echo ""
    echo "   方式B - 永久生效（写入 .bash_profile）:"
    echo "     echo 'export GITHUB_TOKEN=\"ghp_你的token\"' >> ~/.bash_profile"
    echo "     source ~/.bash_profile"
    echo ""
    exit 1
fi

# 检查 git
if ! command -v git &> /dev/null; then
    echo "❌ 错误: 未找到 git，请先安装"
    exit 1
fi

# 检查仓库
if [ ! -d ".git" ]; then
    echo "🔧 初始化 Git 仓库..."
    git init
    git branch -M main
fi

# 检查远程仓库
REMOTE_URL="https://${GITHUB_USER}:${GITHUB_TOKEN}@github.com/${GITHUB_USER}/${REPO_NAME}.git"
if ! git remote get-url origin >/dev/null 2>&1; then
    echo "🔧 添加远程仓库..."
    git remote add origin "$REMOTE_URL"
else
    echo "🔧 更新远程仓库地址..."
    git remote set-url origin "$REMOTE_URL"
fi

# 检查是否有变更
echo "📋 检查文件变更..."
git add -A

# 获取变更摘要
CHANGED=$(git diff --cached --name-only)
if [ -z "$CHANGED" ]; then
    echo "✅ 没有需要提交的变更，本地与上次提交一致"
    echo ""
    echo "检查远程是否有更新..."
    git fetch origin main 2>/dev/null || true
    LOCAL=$(git rev-parse @ 2>/dev/null || echo "none")
    REMOTE=$(git rev-parse @{u} 2>/dev/null || echo "none")
    if [ "$LOCAL" != "$REMOTE" ] && [ "$REMOTE" != "none" ]; then
        echo "🔄 远程有更新，执行推送..."
        git push origin "$BRANCH"
        echo "✅ 推送完成"
    else
        echo "✅ 远程也已是最新，无需操作"
    fi
    echo ""
    echo "🌐 访问你的 GitHub Pages:"
    echo "   https://${GITHUB_USER}.github.io/${REPO_NAME}/"
    exit 0
fi

# 显示变更摘要
echo "📦 即将提交的文件:"
echo "$CHANGED" | sed 's/^/   - /'
echo ""

# 生成提交信息（带时间戳）
COMMIT_MSG="update: sync local changes ($(date '+%Y-%m-%d %H:%M'))"

# 提交
echo "💾 正在提交..."
git commit -m "$COMMIT_MSG"

# 推送
echo "🚀 推送到 GitHub..."
if git push -u origin "$BRANCH"; then
    echo ""
    echo "✅ 推送成功！"
    echo ""
    echo "🌐 访问你的 GitHub Pages:"
    echo "   https://${GITHUB_USER}.github.io/${REPO_NAME}/"
    echo ""
    echo "📂 仓库地址:"
    echo "   https://github.com/${GITHUB_USER}/${REPO_NAME}"
else
    echo ""
    echo "❌ 推送失败，可能的原因:"
    echo "   - Token 无效或已过期"
    echo "   - 仓库名不正确"
    echo "   - 网络连接问题"
    echo ""
    echo "请检查:"
    echo "   1. Token 是否有 'repo' 权限"
    echo "   2. GitHub 仓库 ${REPO_NAME} 是否存在"
    echo "   3. 网络是否能访问 github.com"
    exit 1
fi

echo ""
echo "===== 完成 ====="
