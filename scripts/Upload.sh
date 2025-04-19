#!/bin/bash

# 輸入 commit messgage
echo "請輸入 commit message:"
read message

# 確認當下 git 狀態
echo "Git 狀態："
git status

# 加入變更內容
echo "添加變更內容.."
git add .

# 提交
echo "正在提交：$message"
git commit -m "$message"

# 推送到雲端
echo "推送到雲端倉庫.."
git push

echo "成功！"
