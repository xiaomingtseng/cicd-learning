# GitHub CI/CD 設定指南

## 🚀 GitHub Repository 設定步驟

### 1. 建立 GitHub Repository

1. 登入 GitHub 帳號
2. 點擊右上角的 `+` 按鈕，選擇 `New repository`
3. 輸入 Repository 名稱：`cicd-learning`
4. 選擇 `Public` 或 `Private`（建議選擇 Public 以使用免費的 GitHub Actions）
5. **不要**勾選 "Add a README file"（我們已經有了）
6. 點擊 `Create repository`

### 2. 將本地程式碼推送到 GitHub

在專案根目錄執行以下指令：

```bash
# 初始化 Git repository
git init

# 新增所有檔案到暫存區
git add .

# 建立第一個 commit
git commit -m "Initial commit: 建立 CI/CD 學習專案"

# 新增遠端 repository（請替換 YOUR_USERNAME）
git remote add origin https://github.com/YOUR_USERNAME/cicd-learning.git

# 建立 main 分支並推送
git branch -M main
git push -u origin main
```

### 3. 設定 GitHub Secrets

為了讓 CI/CD 流程正常運作，需要設定以下 Secrets：

1. 進入你的 GitHub repository
2. 點擊 `Settings` 標籤
3. 在左側選單中選擇 `Secrets and variables` > `Actions`
4. 點擊 `New repository secret` 按鈕

需要設定的 Secrets：

#### Docker Hub 設定
- **DOCKER_USERNAME**: 你的 Docker Hub 使用者名稱
- **DOCKER_PASSWORD**: 你的 Docker Hub 密碼或存取權杖

#### 程式碼品質工具（可選）
- **SONAR_TOKEN**: SonarCloud 的存取權杖
- **CODECOV_TOKEN**: Codecov 的上傳權杖

### 4. 建立 Docker Hub Repository

1. 登入 [Docker Hub](https://hub.docker.com/)
2. 點擊 `Create Repository`
3. 建立兩個 repository：
   - `cicd-learning-frontend`
   - `cicd-learning-backend`
4. 選擇 `Public` 或 `Private`

### 5. 設定分支保護規則

1. 在 GitHub repository 中，進入 `Settings` > `Branches`
2. 點擊 `Add rule`
3. 在 `Branch name pattern` 輸入 `main`
4. 勾選以下選項：
   - ✅ Require a pull request before merging
   - ✅ Require status checks to pass before merging
   - ✅ Require branches to be up to date before merging
   - ✅ Include administrators

5. **重要**: Status checks 設定說明
   - 如果這是新的 repository，您可能還看不到 `Status checks` 選項
   - Status checks 只有在 GitHub Actions 至少執行過一次後才會出現
   - 暫時可以先跳過此步驟，等第一次 Actions 執行後再回來設定

6. 點擊 `Create`

### ⚠️ Status Checks 後續設定

當您完成第一次 Pull Request 並且 GitHub Actions 執行後：

1. 回到 `Settings` > `Branches` > 編輯剛建立的規則
2. 在 `Status checks that are required` 部分會看到：
   - `test (18.x)` 和 `test (16.x)` - 來自測試 job
   - `build` - 來自建置 job  
   - `security-scan` - 來自安全掃描 job
3. 選擇您想要作為必要檢查的項目
4. 點擊 `Save changes`

### 6. 啟用 GitHub Actions

GitHub Actions 預設是啟用的，但如果沒有：

1. 進入 repository 的 `Actions` 標籤
2. 如果看到啟用提示，點擊 `I understand my workflows, go ahead and enable them`

### 7. 測試 CI/CD Pipeline

1. 建立一個新的分支：
   ```bash
   git checkout -b feature/test-pipeline
   ```

2. 修改 README.md 檔案：
   ```bash
   echo "\n## 測試 CI/CD Pipeline" >> README.md
   ```

3. Commit 並推送：
   ```bash
   git add README.md
   git commit -m "測試: 新增 CI/CD pipeline 測試"
   git push origin feature/test-pipeline
   ```

4. 在 GitHub 上建立 Pull Request：
   - 進入 repository
   - 點擊 `Compare & pull request`
   - 填寫 PR 標題和描述
   - 點擊 `Create pull request`

5. 觀察 GitHub Actions 的執行：
   - 在 PR 頁面底部可以看到 status checks
   - 點擊 `Details` 查看詳細的執行日誌
   - 進入 `Actions` 標籤查看完整的工作流程

### 8. 設定自動部署（進階）

如果你有部署伺服器，可以設定自動部署：

1. 在伺服器上設定 SSH 金鑰
2. 將私鑰新增到 GitHub Secrets（命名為 `DEPLOY_SSH_KEY`）
3. 修改 `.github/workflows/ci-cd.yml` 中的部署步驟

### 9. 監控設定

#### 電子郵件通知：
GitHub 預設會發送 workflow 失敗的通知到你的註冊信箱。

## 🔧 故障排除

### 常見問題：

1. **Actions 執行失敗**
   - 檢查 Secrets 是否正確設定
   - 查看 Actions 日誌找出錯誤原因

2. **Docker 推送失敗**
   - 確認 Docker Hub 帳號和權限
   - 檢查 repository 名稱是否正確

3. **測試失敗**
   - 在本地執行 `npm test` 確認測試通過
   - 檢查依賴是否正確安裝

## 📚 進階學習資源

- [GitHub Actions 官方文檔](https://docs.github.com/en/actions)
- [Docker 官方教學](https://docs.docker.com/get-started/)
- [CI/CD 最佳實踐](https://docs.github.com/en/actions/learn-github-actions/essential-features-of-github-actions)

## 🎯 下一步

完成基本設定後，你可以：

1. 新增更多測試案例
2. 設定不同環境的部署
3. 整合更多程式碼品質工具
4. 實施藍綠部署或滾動更新策略