#!/bin/bash

# ナレッジ追加支援スクリプト

set -e

echo "🧠 ナレッジ追加ヘルパー（超簡単！）"
echo "=================================="
echo ""
echo "他のプロジェクトで発見したナレッジを追加しよう🦈"
echo ""

# カテゴリ選択
echo "どんなナレッジ？"
echo "1) Languages (React、Python、Go等の言語・フレームワーク)"
echo "2) Development (開発手法、テスト、デバッグ等)"
echo "3) Tools (VS Code、Docker、CI/CD等のツール)"
echo "4) Architecture (設計パターン、システム構成等)"
echo "5) Troubleshooting (エラー解決、問題対処等)"

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
echo "ファイル名を決めよう（英語、ハイフン区切り）"
echo "例: react-performance-tips, docker-troubleshooting, api-design-patterns"
read -p "ファイル名: " filename

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
    echo "🎯 次にやること："
    echo "1. ファイルを開いて [この部分] を埋める"
    echo "2. 以下のコマンドで共有："
    echo ""
    echo "   git add ."
    echo "   git commit -m \"docs: add $filename knowledge\""
    echo "   git push"
    echo ""
    echo "たったこれだけ！🦈"
else
    echo "❌ ファイルが既に存在します: $target_file"
    exit 1
fi