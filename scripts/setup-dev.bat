@echo off
echo 🚀 開始本地開發環境設定...

:: 檢查 Docker 是否安裝
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ 請先安裝 Docker
    exit /b 1
)

:: 檢查 Docker Compose 是否安裝
docker-compose --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ 請先安裝 Docker Compose
    exit /b 1
)

:: 建立環境變數檔案
if not exist .env (
    echo 📝 建立環境變數檔案...
    (
        echo # 應用程式設定
        echo NODE_ENV=development
        echo PORT=3001
        echo.
        echo # 資料庫設定
        echo MONGODB_URI=mongodb://localhost:27017/cicd-learning-dev
        echo.
        echo # JWT 設定
        echo JWT_SECRET=your-super-secret-jwt-key-here
        echo JWT_EXPIRE=7d
        echo.
        echo # Docker 設定
        echo DOCKER_USERNAME=your-docker-username
    ) > .env
    echo ✅ 已建立 .env 檔案，請根據需要修改設定
)

:: 建置和啟動服務
echo 🏗️  建置 Docker 映像...
docker-compose -f docker-compose.dev.yml build

echo 🚀 啟動開發環境...
docker-compose -f docker-compose.dev.yml up -d

echo ⏳ 等待服務啟動...
timeout /t 10 /nobreak >nul

:: 檢查服務狀態
echo 🔍 檢查服務狀態...
docker-compose -f docker-compose.dev.yml ps

echo ✅ 開發環境設定完成！
echo.
echo 🌐 應用程式網址：
echo    前端: http://localhost:3000
echo    後端 API: http://localhost:3001
echo    MongoDB: mongodb://localhost:27017
echo.
echo 📋 常用指令：
echo    查看日誌: docker-compose -f docker-compose.dev.yml logs -f
echo    停止服務: docker-compose -f docker-compose.dev.yml down
echo    重新建置: docker-compose -f docker-compose.dev.yml build --no-cache

pause