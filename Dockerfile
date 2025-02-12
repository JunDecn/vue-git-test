# 使用 Node.js 作為建置環境
FROM node:18 AS build-stage

# 設定工作目錄
WORKDIR /app

# 複製 package.json 和 package-lock.json（如果有的話）
COPY package*.json ./

# 安裝依賴
RUN npm install

# 複製其他專案文件
COPY . .

# 編譯 Vue 3 應用
RUN npm run build

# 使用 Nginx 作為前端服務器
FROM nginx:alpine AS production-stage

# 設定工作目錄
WORKDIR /usr/share/nginx/html

# 移除預設 Nginx 靜態文件
RUN rm -rf ./*

# 複製 Vue 3 編譯後的檔案到 Nginx 目錄
COPY --from=build-stage /app/dist .

# 複製自定義 Nginx 設定
COPY nginx.conf /etc/nginx/conf.d/default.conf

# 暴露 80 端口
EXPOSE 80

# 啟動 Nginx
CMD ["nginx", "-g", "daemon off;"]
