@echo off
echo 正在设置 GitHub 仓库连接...

REM 检查是否已安装 Git
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo 错误: 未找到 Git。请先安装 Git。
    echo 下载地址: https://git-scm.com/downloads
    pause
    exit /b 1
)

echo Git 已安装，版本信息:
git --version

echo.
echo 正在初始化 Git 仓库...
git init

echo.
echo 正在配置用户信息...
REM 检查是否已设置用户名
git config user.name >nul 2>&1
if %errorlevel% neq 0 (
    echo 请输入您的 Git 用户名:
    set /p username=
    git config --global user.name "%username%"
) else (
    echo 用户名已设置: 
    git config user.name
)

REM 检查是否已设置邮箱
git config user.email >nul 2>&1
if %errorlevel% neq 0 (
    echo 请输入您的 Git 邮箱:
    set /p email=
    git config --global user.email "%email%"
) else (
    echo 邮箱已设置:
    git config user.email
)

echo.
echo 正在添加远程仓库...
git remote add origin https://github.com/AhaTeam-CL/kata3.git

echo.
echo 正在添加所有文件...
git add .

echo.
echo 正在创建初始提交...
git commit -m "Initial commit: Minecraft Launcher documentation site"

echo.
echo 正在推送到 GitHub...
git push -u origin main

echo.
echo 设置完成！
echo 您的项目已成功连接到 GitHub 仓库: https://github.com/AhaTeam-CL/kata3.git
pause