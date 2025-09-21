# Frontend Dockerfile
FROM node:18-alpine as build

# 設定工作目錄
WORKDIR /app

# 複製 package files
COPY package*.json ./

# 安裝依賴
RUN npm ci --only=production

# 複製源碼
COPY . .

# 建置應用
RUN npm run build

# 使用 nginx 提供靜態檔案
FROM nginx:alpine

# 複製建置結果到 nginx
COPY --from=build /app/build /usr/share/nginx/html

# 複製 nginx 配置
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]