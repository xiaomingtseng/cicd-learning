# 常見問題解答 (FAQ)

## 🔧 設定相關問題

### Q: GitHub Actions 無法存取我的 Docker Hub 帳號
**A**: 請檢查以下設定：
1. 確認 `DOCKER_USERNAME` 和 `DOCKER_PASSWORD` 已正確設定在 GitHub Secrets
2. 檢查 Docker Hub 的使用者名稱和密碼是否正確
3. 如果使用雙因子認證，請使用 Access Token 而非密碼

### Q: 測試在本地通過但在 CI 環境失敗
**A**: 常見原因：
1. **環境差異**: 檢查 Node.js 版本是否一致
2. **依賴問題**: 使用 `npm ci` 而不是 `npm install`
3. **時區問題**: CI 環境通常使用 UTC 時區
4. **檔案路徑**: Windows 和 Linux 的路徑分隔符不同

### Q: Docker 建置失敗
**A**: 檢查以下項目：
1. Dockerfile 語法是否正確
2. 基礎映像是否存在
3. 複製的檔案路徑是否正確
4. 建置上下文是否包含所需檔案

## 🚀 部署相關問題

### Q: 如何設定不同環境的部署？
**A**: 建議使用不同的 workflow 檔案或條件判斷：
```yaml
# 只在 main 分支部署到生產環境
if: github.ref == 'refs/heads/main'

# 在 develop 分支部署到測試環境
if: github.ref == 'refs/heads/develop'
```

### Q: 部署後應用程式無法啟動
**A**: 檢查清單：
1. 容器的健康檢查是否正常
2. 環境變數是否正確設定
3. 資料庫連線是否正常
4. 查看容器日誌：`docker logs container_name`

### Q: 如何實現零停機部署？
**A**: 可以使用以下策略：
1. **藍綠部署**: 維護兩個相同的環境
2. **滾動更新**: 逐步替換舊版本
3. **Canary 發布**: 先部署到少數使用者

## 🔍 除錯技巧

### Q: 如何檢視 GitHub Actions 的詳細日誌？
**A**: 
1. 進入 repository 的 `Actions` 標籤
2. 點擊失敗的 workflow
3. 點擊失敗的 job
4. 展開失敗的步驟檢視錯誤訊息

### Q: 本地如何測試 Docker 建置？
**A**: 使用以下指令：
```bash
# 建置前端映像
docker build -t test-frontend ./frontend

# 建置後端映像
docker build -t test-backend ./backend

# 使用 docker-compose 測試完整環境
docker-compose up --build
```

### Q: 如何檢查程式碼覆蓋率？
**A**: 
```bash
# 前端
cd frontend && npm run test:coverage

# 後端
cd backend && npm run test:coverage
```

## 🛡️ 安全性問題

### Q: 如何安全地儲存敏感資訊？
**A**: 
1. **GitHub Secrets**: 儲存 API 金鑰、密碼等
2. **環境變數**: 在運行時注入設定
3. **外部服務**: 使用 AWS Secrets Manager、Azure Key Vault 等

### Q: 如何處理依賴套件的安全漏洞？
**A**: 
1. **定期更新**: 使用 `npm audit` 檢查漏洞
2. **自動修復**: 執行 `npm audit fix`
3. **CI 檢查**: 在 pipeline 中加入安全掃描

### Q: Docker 映像的安全性如何確保？
**A**: 
1. **使用官方映像**: 從可信來源獲取基礎映像
2. **定期更新**: 保持基礎映像為最新版本
3. **漏洞掃描**: 使用 Trivy 或 Snyk 掃描
4. **最小權限**: 不使用 root 使用者執行應用

## 📊 效能問題

### Q: CI/CD Pipeline 執行太慢怎麼辦？
**A**: 最佳化策略：
1. **並行執行**: 將獨立的 job 設為並行
2. **快取機制**: 使用 GitHub Actions cache
3. **增量建置**: 只建置變更的部分
4. **最佳化 Docker**: 使用多階段建置、.dockerignore

### Q: 如何減少 Docker 映像大小？
**A**: 
```dockerfile
# 使用多階段建置
FROM node:18-alpine AS builder
# ... 建置步驟

FROM node:18-alpine AS runtime
# 只複製必要檔案
COPY --from=builder /app/dist ./dist
```

### Q: 測試執行太慢
**A**: 
1. **並行測試**: 使用 Jest 的並行功能
2. **測試分層**: 區分單元測試和整合測試
3. **Mock 外部服務**: 避免真實的 API 呼叫

## 🔄 最佳實踐問題

### Q: 應該多久部署一次？
**A**: 取決於團隊和專案：
- **小功能**: 每日多次部署
- **大功能**: 每週部署
- **關鍵修復**: 立即部署

### Q: 如何處理部署失敗？
**A**: 制定回滾策略：
1. **自動回滾**: 健康檢查失敗時自動回滾
2. **手動回滾**: 保留前一版本的映像
3. **Forward Fix**: 快速修復並重新部署

### Q: 團隊協作時的 Git 工作流程建議？
**A**: 
1. **Feature Branch**: 每個功能使用獨立分支
2. **Pull Request**: 強制 code review
3. **保護 main 分支**: 設定分支保護規則
4. **定期同步**: 保持分支與主分支同步

## 🆘 緊急狀況處理

### Q: 生產環境出現嚴重問題如何處理？
**A**: 
1. **立即回滾**: 回到穩定版本
2. **問題分析**: 查看日誌和監控
3. **修復驗證**: 在測試環境驗證修復
4. **重新部署**: 確認修復後再次部署

### Q: CI/CD Pipeline 完全無法執行
**A**: 
1. **檢查 GitHub 狀態**: 確認服務正常
2. **權限檢查**: 確認 secrets 和權限設定
3. **工作流程語法**: 驗證 YAML 格式
4. **降級方案**: 準備手動部署流程

如果以上答案無法解決你的問題，歡迎在 GitHub Issues 中提出，我們會儘快回覆！