#!/usr/bin/env bash
# Tesla 行车记录仪查看器 - macOS / Linux 启动脚本

cd "$(dirname "$0")"
PORT=${PORT:-8000}

echo "============================================================"
echo "  Tesla 行车记录仪查看器 - 本地服务启动脚本"
echo "============================================================"
echo ""
echo "  即将在本机启动一个本地 HTTP 服务（端口 ${PORT}）"
echo "  服务仅在本机可用，不会对外暴露或联网"
echo ""
echo "  启动后，请在浏览器打开：  http://localhost:${PORT}"
echo "  按 Ctrl+C 可以随时停止服务"
echo ""
echo "============================================================"
echo ""

# 优先 Python 3
if command -v python3 >/dev/null 2>&1; then
  echo "[检测到 python3] 启动本地服务 ..."
  echo
  (sleep 1 && open "http://localhost:${PORT}" 2>/dev/null || xdg-open "http://localhost:${PORT}" 2>/dev/null || true) &
  exec python3 -m http.server "${PORT}"
elif command -v python >/dev/null 2>&1; then
  echo "[检测到 python] 启动本地服务 ..."
  echo
  (sleep 1 && open "http://localhost:${PORT}" 2>/dev/null || xdg-open "http://localhost:${PORT}" 2>/dev/null || true) &
  exec python -m http.server "${PORT}"
elif command -v npx >/dev/null 2>&1; then
  echo "[检测到 npx] 启动本地服务 ..."
  echo
  (sleep 1 && open "http://localhost:${PORT}" 2>/dev/null || xdg-open "http://localhost:${PORT}" 2>/dev/null || true) &
  exec npx --yes http-server -p "${PORT}" -c-1
else
  echo "[警告] 未检测到 Python 或 Node.js，将尝试直接打开 index.html"
  echo
  open index.html 2>/dev/null || xdg-open index.html 2>/dev/null
  exit 0
fi
