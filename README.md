# GitHub 設定與專案上傳完整指南

這份指南將帶你完成從建立 GitHub repository 到設定 SSH 和上傳專案的所有必要步驟，並解釋每個步驟背後的原因，幫助你理解每個動作的目的。

## 目錄
- [第一部分：安裝與設定 Git](#第一部分安裝與設定-git)
- [第二部分：建立與設定 GitHub 帳號](#第二部分建立與設定-github-帳號)
- [第三部分：SSH 金鑰設定](#第三部分ssh-金鑰設定)
- [第四部分：建立與設定 Repository](#第四部分建立與設定-repository)
- [第五部分：專案上傳與管理](#第五部分專案上傳與管理)
- [常見問題與解決方案](#常見問題與解決方案)

## 第一部分：安裝與設定 Git

### 1.1 安裝 Git

**Windows:**
```bash
# 從官網下載安裝包
https://git-scm.com/download/win
```

**macOS:**
```bash
# 使用 Homebrew 安裝
brew install git
```

**Linux (Ubuntu/Debian):**
```bash
sudo apt-get update
sudo apt-get install git
```

**為什麼需要安裝 Git?**
Git 是分散式版本控制系統，它能追蹤檔案的變更歷史，讓你輕鬆回溯先前版本，並能與他人協作處理同一專案。

### 1.2 設定 Git 基本資訊

```bash
git config --global user.name "你的名字"
git config --global user.email "你的電子郵件"
```

**為什麼需要這樣設定?**
這些資訊會附加在你的每次提交中，幫助識別誰完成了特定更改。這在團隊協作中特別重要。

### 1.3 設定預設分支名稱

```bash
git config --global init.defaultBranch main
```

**為什麼設定預設分支名稱?**
近年來，許多開發社群已從使用 `master` 轉向使用 `main` 作為預設分支名稱，這是一種更具包容性的做法。

## 第二部分：建立與設定 GitHub 帳號

### 2.1 建立 GitHub 帳號

1. 前往 [GitHub 官網](https://github.com/)
2. 點擊「Sign up」（註冊）
3. 依照指示完成註冊流程

**為什麼選擇 GitHub?**
GitHub 是全球最大的程式碼託管平台，提供許多協作工具、開源專案互動，以及整合 CI/CD 的能力，幫助開發者管理與分享程式碼。

### 2.2 設定雙因素驗證 (2FA)

1. 前往 GitHub 的設定頁面
2. 選擇「Password and authentication」（密碼與認證）
3. 依照指示設定雙因素驗證

**為什麼設定 2FA?**
雙因素驗證為你的帳號提供額外一層的安全保護，即使密碼洩漏，未經授權的人也無法輕易存取你的帳號。

## 第三部分：SSH 金鑰設定

### 3.1 檢查現有 SSH 金鑰

```bash
ls -la ~/.ssh
```

### 3.2 生成新的 SSH 金鑰

```bash
ssh-keygen -t ed25519 -C "你的電子郵件"
```

**為什麼使用 ED25519?**
ED25519 是一種現代的加密演算法，提供更佳的安全性與效能，相較於較舊的 RSA 演算法。

### 3.3 啟動 SSH 代理並添加金鑰

**Windows:**
```bash
# 啟動 SSH 代理
eval "$(ssh-agent -s)"

# 加入 SSH 金鑰
ssh-add ~/.ssh/id_ed25519
```

**macOS/Linux:**
```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

### 3.4 將 SSH 公鑰添加到 GitHub

1. 複製你的 SSH 公鑰
```bash
cat ~/.ssh/id_ed25519.pub
# 複製輸出的內容
```

2. 前往 GitHub 的設定頁面
3. 選擇「SSH and GPG keys」（SSH 和 GPG 金鑰）
4. 點擊「New SSH key」（新增 SSH 金鑰）
5. 填寫標題並貼上你的公鑰
6. 點擊「Add SSH key」（新增 SSH 金鑰）

**為什麼使用 SSH 而非 HTTPS?**
- 更安全：SSH 提供加密連接
- 更方便：無需每次推送時輸入密碼
- 更適合頻繁操作：減少認證步驟，提高工作效率

### 3.5 測試 SSH 連接

```bash
ssh -T git@github.com
```

如果成功，你會看到類似這樣的訊息：
```
Hi username! You've successfully authenticated, but GitHub does not provide shell access.
```

## 第四部分：建立與設定 Repository

### 4.1 在 GitHub 上建立新的 Repository

1. 登入 GitHub
2. 點擊右上角的「+」圖示，選擇「New repository」（新增儲存庫）
3. 輸入儲存庫名稱、描述
4. 選擇是否為公開或私有
5. 可選：初始化 README、.gitignore 和授權條款
6. 點擊「Create repository」（建立儲存庫）

**設定選項解釋：**
- **Public vs Private**：公開儲存庫任何人都能看到，私有儲存庫只有你和被授權的協作者可見
- **README**：簡介專案的文件
- **.gitignore**：指定 Git 應忽略的檔案類型
- **授權條款**：定義如何允許他人使用你的程式碼

### 4.2 克隆遠端 Repository 到本地

```bash
git clone git@github.com:你的使用者名稱/儲存庫名稱.git
```

**為什麼要克隆?**
克隆建立了遠端儲存庫的本地複本，讓你可以在自己的電腦上工作，然後再將變更推送回 GitHub。

### 4.3 或從現有本地專案建立 Repository

如果你已經有一個本地專案想上傳到 GitHub：

```bash
# 切換到你的專案目錄
cd 你的專案路徑

# 初始化 Git
git init

# 添加 GitHub 儲存庫作為遠端來源
git remote add origin git@github.com:你的使用者名稱/儲存庫名稱.git
```

## 第五部分：專案上傳與管理

### 5.1 基本 Git 工作流程

```bash
# 查看檔案狀態
git status

# 將檔案添加到暫存區
git add 檔案名稱    # 添加特定檔案
git add .          # 添加所有變更的檔案

# 提交變更
git commit -m "描述這次變更的訊息"

# 將變更推送到 GitHub
git push -u origin main  # 第一次推送
git push                 # 之後的推送
```

**為什麼分為暫存和提交兩個步驟?**
這種設計允許你選擇性地決定哪些變更要包含在下一次提交中，提供更精確的版本控制。

### 5.2 分支操作

```bash
# 創建新分支
git branch 分支名稱

# 切換到該分支
git checkout 分支名稱

# 或一步完成創建與切換
git checkout -b 分支名稱

# 推送新分支到 GitHub
git push -u origin 分支名稱

# 合併分支
git checkout main        # 先切換到目標分支
git merge 來源分支名稱     # 將來源分支合併到當前分支
```

**為什麼使用分支?**
分支讓你能夠同時處理多項功能或修復，互不影響，然後再視需要將它們合併。這是團隊協作的關鍵功能。

### 5.3 保持本地儲存庫與遠端同步

```bash
# 從遠端儲存庫獲取更新
git fetch

# 將遠端變更合併到當前分支
git pull

# 或明確指定
git pull origin main
```

## 常見問題與解決方案

### 1. 處理合併衝突

當兩個分支修改了同一個檔案的同一部分時，會發生合併衝突。Git 會標記衝突區域：

```
<<<<<<< HEAD
你的變更
=======
其他分支的變更
>>>>>>> branch-name
```

解決步驟：
1. 打開有衝突的檔案
2. 找到並編輯衝突區域，決定保留什麼內容
3. 移除衝突標記
4. 儲存檔案
5. 執行 `git add` 標記為已解決
6. 完成合併 `git commit`

### 2. 復原變更

```bash
# 復原工作目錄中的變更
git checkout -- 檔案名稱

# 復原已暫存的變更
git reset HEAD 檔案名稱

# 復原最近一次提交
git reset --soft HEAD~1
```

### 3. 查看歷史記錄

```bash
# 簡單查看提交歷史
git log

# 圖形化顯示分支歷史
git log --graph --oneline --all
```

### 4. 設定 .gitignore

.gitignore 檔案指定 Git 應忽略的檔案模式。例如：

```
# 忽略編譯後的檔案
*.o
*.out

# 忽略日誌檔案
*.log

# 忽略特定目錄
node_modules/
dist/
build/

# 忽略環境檔案
.env
.env.local
```

### 5. Git 與 GitHub 最佳實踐

- 經常提交小的變更，而非偶爾提交大量變更
- 撰寫清晰的提交訊息
- 使用分支開發新功能
- 經常從主分支更新你的功能分支
- 使用有意義的分支命名
- 設定適當的 .gitignore 檔案
- 在合併前執行程式碼審查

---

這份指南涵蓋了從設定 Git 與 GitHub 到管理專案的基本流程。隨著你對這些工具的熟悉，你可以探索更多進階功能，如 GitHub Actions、Pull Requests 和 GitHub Pages 等。

祝你的專案開發順利！
