@echo off
echo 推送代码到 GitHub...

REM 检查 Git 状态
git status --porcelain >nul 2>&1
if %errorlevel% equ 0 (
    echo 检测到未提交的更改
    echo.
    git status
    echo.
    echo 是否提交这些更改？(y/n)
    set /p confirm=
    if /i "%confirm%"=="y" (
        echo 请输入提交信息:
        set /p commit_msg=
        git add .
        git commit -m "%commit_msg%"
    ) else (
        echo 跳过提交
    )
)

REM 推送到 GitHub
echo 正在推送到 GitHub...
git push origin main

if %errorlevel% equ 0 (
    echo.
    echo ✅ 推送成功！
    echo 访问: https://github.com/your-username/your-repo-name
) else (
    echo.
    echo ❌ 推送失败，请检查:
    echo 1. 是否已设置正确的远程仓库地址
    echo 2. 是否有推送权限
    echo 3. 网络连接是否正常
)

pause