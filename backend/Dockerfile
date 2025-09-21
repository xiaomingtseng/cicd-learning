# Backend Dockerfile
FROM node:18-alpine

# 建立應用目錄
WORKDIR /usr/src/app

# 複製 package files
COPY package*.json ./

# 安裝應用依賴
RUN npm ci --only=production

# 複製應用源碼
COPY . .

# 建立非 root 使用者
RUN addgroup -g 1001 -S nodejs
RUN adduser -S backend -u 1001

# 更改檔案擁有者
USER backend

# 暴露 port
EXPOSE 3001

# 定義運行時的環境變數
ENV NODE_ENV=production

# 啟動應用
CMD ["node", "server.js"]