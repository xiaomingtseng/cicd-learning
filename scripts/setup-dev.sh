#!/bin/bash

echo "🚀 開始本地開發環境設定..."

# 檢查 Docker 是否安裝
if ! command -v docker &> /dev/null; then
    echo "❌ 請先安裝 Docker"
    exit 1
fi

# 檢查 Docker Compose 是否安裝
if ! command -v docker-compose &> /dev/null; then
    echo "❌ 請先安裝 Docker Compose"
    exit 1
fi

# 建立環境變數檔案
if [ ! -f .env ]; then
    echo "📝 建立環境變數檔案..."
    cat > .env << EOL
# 應用程式設定
NODE_ENV=development
PORT=3001

# 資料庫設定
MONGODB_URI=mongodb://localhost:27017/cicd-learning-dev

# JWT 設定
JWT_SECRET=your-super-secret-jwt-key-here
JWT_EXPIRE=7d

# Docker 設定
DOCKER_USERNAME=your-docker-username
EOL
    echo "✅ 已建立 .env 檔案，請根據需要修改設定"
fi

# 建置和啟動服務
echo "🏗️  建置 Docker 映像..."
docker-compose -f docker-compose.dev.yml build

echo "🚀 啟動開發環境..."
docker-compose -f docker-compose.dev.yml up -d

echo "⏳ 等待服務啟動..."
sleep 10

# 檢查服務狀態
echo "🔍 檢查服務狀態..."
docker-compose -f docker-compose.dev.yml ps

echo "✅ 開發環境設定完成！"
echo ""
echo "🌐 應用程式網址："
echo "   前端: http://localhost:3000"
echo "   後端 API: http://localhost:3001"
echo "   MongoDB: mongodb://localhost:27017"
echo ""
echo "📋 常用指令："
echo "   查看日誌: docker-compose -f docker-compose.dev.yml logs -f"
echo "   停止服務: docker-compose -f docker-compose.dev.yml down"
echo "   重新建置: docker-compose -f docker-compose.dev.yml build --no-cache"