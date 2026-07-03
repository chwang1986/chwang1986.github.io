#!/bin/bash
# ============================================
# 本地启动脚本 — 预览静态网站
# 用法: bash start.sh
# ============================================

set -e

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# 检查 index.html 是否存在
if [ ! -f "index.html" ]; then
    echo "❌ 错误: 未找到 index.html，请确保在项目根目录运行此脚本"
    exit 1
fi

# 检查端口占用并自动选择可用端口
PORT=8080
while lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null 2>&1; do
    PORT=$((PORT + 1))
    if [ $PORT -gt 8100 ]; then
        echo "❌ 错误: 8080-8100 端口均被占用，请手动释放端口后重试"
        exit 1
    fi
done

echo "🚀 启动本地服务器..."
echo "📁 项目目录: $SCRIPT_DIR"
echo "🔗 访问地址: http://localhost:$PORT"
echo ""
echo "📌 可用入口:"
echo "   总览首页: http://localhost:$PORT"
echo "   Mac 指南: http://localhost:$PORT/mac-mini-guide/mac-mini-guide.html"
echo "   AI 学习:  http://localhost:$PORT/ai-guide/index.html"
echo "   趣味物理: http://localhost:$PORT/fun-physics/index.html"
echo ""
echo "🛑 按 Ctrl+C 停止服务器"
echo ""

# 使用 Python 启动 HTTP 服务器
python3 -m http.server $PORT
