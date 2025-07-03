#!/bin/bash

# ナレッジコミット用スクリプト

set -e

VAULT_PATH="/home/hoshi/project/cc_env/claude-code-vault"

echo "📝 ナレッジコミットヘルパー"
echo "=========================="

# 元のディレクトリを保存
ORIGINAL_DIR=$(pwd)

# ナレッジベースに移動
cd "$VAULT_PATH"

# 変更があるかチェック
if git diff --quiet && git diff --cached --quiet; then
    echo "❌ コミットする変更がありません"
    cd "$ORIGINAL_DIR"
    exit 1
fi

# 変更されたファイルを表示
echo "変更されたファイル:"
git status --porcelain

echo ""
read -p "コミットメッセージのキーワード (例: react-hooks-tips): " keyword

if [ -z "$keyword" ]; then
    echo "❌ キーワードが必要です"
    cd "$ORIGINAL_DIR"
    exit 1
fi

# コミット実行
git add .
git commit -m "docs: add $keyword knowledge

🤖 Generated with Claude Code

Co-Authored-By: Claude <noreply@anthropic.com>"

echo "✅ コミット完了！"

# プッシュするか確認
read -p "GitHubにプッシュしますか？ (y/N): " push_confirm

if [[ $push_confirm =~ ^[Yy]$ ]]; then
    git push
    echo "🚀 プッシュ完了！"
else
    echo "ℹ️  あとで 'git push' でプッシュしてください"
fi

# 元のディレクトリに戻る
cd "$ORIGINAL_DIR"