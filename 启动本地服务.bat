@echo off
chcp 65001 > nul
setlocal

cd /d "%~dp0"

cls
echo ============================================================
echo   Tesla 行车记录仪查看器 - 本地服务启动脚本
echo ============================================================
echo.
echo   即将在本机启动一个本地 HTTP 服务（端口 8000）
echo   服务仅在本机可用，不会对外暴露或联网
echo.
echo   启动后，请在浏览器打开：  http://localhost:8000
echo   按 Ctrl+C 可以随时停止服务
echo.
echo ============================================================
echo.

REM 尝试用 Python 启动
where python > nul 2>&1
if %ERRORLEVEL% == 0 (
    echo [检测到 Python] 使用 Python 启动本地服务 ...
    echo.
    start "" "http://localhost:8000"
    python -m http.server 8000
    goto :end
)

where py > nul 2>&1
if %ERRORLEVEL% == 0 (
    echo [检测到 Python Launcher] 使用 Python 启动本地服务 ...
    echo.
    start "" "http://localhost:8000"
    py -3 -m http.server 8000
    goto :end
)

where node > nul 2>&1
if %ERRORLEVEL% == 0 (
    echo [检测到 Node.js] 使用 Node 启动本地服务 ...
    echo.
    start "" "http://localhost:8000"
    npx --yes http-server -p 8000 -c-1
    goto :end
)

echo [警告] 未检测到 Python 或 Node.js，将尝试直接打开 index.html
echo.
start "" "%~dp0index.html"

:end
echo.
echo 服务已停止，按任意键关闭窗口 ...
pause > nul
