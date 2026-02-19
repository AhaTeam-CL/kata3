@echo off
echo 初始化 Git 仓库...

REM 检查是否已安装 Git
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo 错误: 未找到 Git。请先安装 Git。
    echo 下载地址: https://git-scm.com/downloads
    pause
    exit /b 1
)

REM 初始化仓库
git init

REM 配置用户信息（如果未设置）
git config user.name >nul 2>&1
if %errorlevel% neq 0 (
    echo 请输入您的 Git 用户名:
    set /p username=
    git config --global user.name "%username%"
)

git config user.email >nul 2>&1
if %errorlevel% neq 0 (
    echo 请输入您的 Git 邮箱:
    set /p email=
    git config --global user.email "%email%"
)

REM 添加所有文件
git add .

REM 创建初始提交
git commit -m "Initial commit: Minecraft Launcher documentation site"

echo.
echo Git 仓库初始化完成！
echo.
echo 下一步操作:
echo 1. 在 GitHub 上创建新仓库
echo 2. 运行以下命令关联远程仓库:
echo    git remote add origin https://github.com/your-username/your-repo-name.git
echo 3. 推送代码到 GitHub:
echo    git push -u origin main
echo.
pause