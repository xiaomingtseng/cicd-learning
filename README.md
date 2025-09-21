# CI/CD 學習專案

這是一個用於學習和實踐 CI/CD 流程的示範專案。

## 專案結構

```
cicd-learning/
├── frontend/           # React 前端應用
├── backend/           # Node.js 後端 API
├── docker/           # Docker 配置檔案
├── .github/          # GitHub Actions 工作流程
├── tests/            # 測試檔案
├── docs/             # 文檔
└── scripts/          # 部署和建置腳本
```

## 技術堆疊

- **前端**: React.js
- **後端**: Node.js with Express
- **資料庫**: MongoDB
- **容器化**: Docker
- **CI/CD**: GitHub Actions
- **部署**: Docker Compose

## 開始使用

1. 複製此專案
2. 安裝依賴
3. 設定環境變數
4. 執行測試
5. 啟動應用程式

## CI/CD 流程

此專案包含完整的 CI/CD pipeline，包括：

- 自動化測試
- 程式碼品質檢查
- Docker 映像建置
- 自動部署

詳細的設定說明請參考 `docs/` 資料夾。