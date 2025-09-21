# GitHub CI/CD 設定指南（簡化版）

## 🚀 快速開始 CI/CD 測試

### 1. 建立 GitHub Repository

1. 登入 GitHub 帳號
2. 點擊右上角的 `+` 按鈕，選擇 `New repository`
3. 輸入 Repository 名稱：`cicd-learning`
4. 選擇 `Public`（免費使用 GitHub Actions）
5. 點擊 `Create repository`

### 2. 推送程式碼到 GitHub

```bash
# 初始化並推送程式碼
git init
git add .
git commit -m "Initial commit: 建立 CI/CD 學習專案"
git remote add origin https://github.com/YOUR_USERNAME/cicd-learning.git
git branch -M main
git push -u origin main
```

### 3. 測試 CI/CD Pipeline

1. 建立測試分支：
   ```bash
   git checkout -b feature/test-pipeline
   echo "## 測試 CI/CD Pipeline" >> README.md
   git add README.md
   git commit -m "test: CI/CD pipeline 測試"
   git push origin feature/test-pipeline
   ```

2. 在 GitHub 建立 Pull Request：
   - 進入 repository
   - 點擊 `Compare & pull request`
   - 點擊 `Create pull request`

3. 觀察 GitHub Actions 執行：
   - 查看 PR 頁面底部的 status checks
   - 點擊 `Details` 查看執行日誌
   - 進入 `Actions` 標籤看完整流程

### 4. 基本分支保護（可選）

Settings > Branches > Add rule：
- Branch name pattern: `main`
- ✅ Require a pull request before merging
- ✅ Require status checks to pass before merging

## 🎯 就這麼簡單！

目前的 `simple-ci.yml` workflow 只做基本測試，不需要任何外部服務或 secrets。

### 執行流程：
1. **Test** - 基本程式碼檢查 ✅
2. **Build** - 模擬建置過程 🏗️  
3. **Deploy** - 模擬部署過程 🚀

## 🔧 如果想要更進階功能

稍後可以加入：
- Docker 建置（需要 Docker Hub secrets）
- 程式碼品質檢查（需要 SonarCloud）
- 自動部署到伺服器
- Slack 通知

完成基本測試後，您可以根據需要逐步加入更多功能！

## 📚 相關資源

- [GitHub Actions 文檔](https://docs.github.com/en/actions)
- [CI/CD 基礎概念](./cicd-concepts.md)
- [常見問題](./faq.md)