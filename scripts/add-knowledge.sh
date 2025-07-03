#!/bin/bash

# ナレッジ追加支援スクリプト

set -e

echo "🧠 Claude Code ナレッジ追加ヘルパー"
echo "=================================="

# カテゴリ選択
echo ""
echo "追加するナレッジのカテゴリを選択してください："
echo "1) Languages (言語・フレームワーク)"
echo "2) Development (開発手法・ツール)"
echo "3) Tools (ツール・環境)"
echo "4) Architecture (アーキテクチャ・設計)"
echo "5) Troubleshooting (トラブルシューティング)"

read -p "番号を入力 (1-5): " category_num

case $category_num in
    1) category="Languages" ;;
    2) category="Development" ;;
    3) category="Tools" ;;
    4) category="Architecture" ;;
    5) category="Troubleshooting" ;;
    *) echo "無効な選択です"; exit 1 ;;
esac

# ファイル名入力
echo ""
read -p "ナレッジファイル名を入力 (kebab-case、.md不要): " filename

# ファイル名検証
if [[ ! $filename =~ ^[a-z0-9-]+$ ]]; then
    echo "❌ ファイル名はkebab-case（小文字・数字・ハイフンのみ）で入力してください"
    exit 1
fi

# ディレクトリとファイルパス決定
target_dir="03-Knowledge/$category"
target_file="$target_dir/${filename}.md"

# ディレクトリ作成
mkdir -p "$target_dir"

# テンプレートをコピー
if [ ! -f "$target_file" ]; then
    cp "04-Templates/Note-Templates/knowledge-template.md" "$target_file"
    
    # 現在日時を追加
    current_date=$(date +%Y-%m-%d)
    sed -i "s/\[YYYY-MM-DD\]/$current_date/g" "$target_file"
    
    echo "✅ ナレッジファイルを作成しました: $target_file"
    echo ""
    echo "次のステップ："
    echo "1. ファイルを編集してナレッジを記入"
    echo "2. git add $target_file"
    echo "3. git commit -m 'docs: add [ナレッジ名] knowledge'"
    echo "4. git push"
    echo "5. GitHubでPull Request作成"
    echo ""
    echo "PRテンプレート: .github/pull_request_template/knowledge-addition.md"
else
    echo "❌ ファイルが既に存在します: $target_file"
    exit 1
fi