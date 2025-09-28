#!/bin/bash

# 提示用户输入 commit subject
read -p "input (Subject): " subject

# 检查输入是否为空
if [ -z "$subject" ]; then
  echo "Error: input Subject can not be empty"
  exit 1
fi

# 生成 description（通过 git status -s 获取变更摘要）
description=$(git status -s | sed 's/^/  - /')  # 格式化输出为列表项

# 执行提交
git add .
git commit -m "$subject" -m "$description"
git push