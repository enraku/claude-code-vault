#!/bin/bash

# グローバルナレッジ追加スクリプト
# どのディレクトリからでも実行可能

set -e

# ナレッジベースのパスを設定
VAULT_PATH="/home/hoshi/project/cc_env/claude-code-vault"

echo "🧠 グローバルナレッジ追加（どこからでもOK！）"
echo "=============================================="
echo ""
echo "現在のディレクトリ: $(pwd)"
echo "追加先: $VAULT_PATH"
echo ""

# ディレクトリ存在確認
if [ ! -d "$VAULT_PATH" ]; then
    echo "❌ ナレッジベースが見つかりません: $VAULT_PATH"
    exit 1
fi

# 元のディレクトリを保存
ORIGINAL_DIR=$(pwd)

# ナレッジベースに移動して実行
cd "$VAULT_PATH"

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
    *) echo "無効な選択です"; cd "$ORIGINAL_DIR"; exit 1 ;;
esac

# ファイル名入力
echo ""
echo "ファイル名を決めよう（英語、ハイフン区切り）"
echo "例: react-performance-tips, docker-troubleshooting, api-design-patterns"
read -p "ファイル名: " filename

# ファイル名検証
if [[ ! $filename =~ ^[a-z0-9-]+$ ]]; then
    echo "❌ ファイル名はkebab-case（小文字・数字・ハイフンのみ）で入力してください"
    cd "$ORIGINAL_DIR"
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
    echo "2. ナレッジベースディレクトリで以下のコマンド実行："
    echo ""
    echo "   cd $VAULT_PATH"
    echo "   git add ."
    echo "   git commit -m \"docs: add $filename knowledge\""
    echo "   git push"
    echo ""
    echo "または、簡単コマンド:"
    echo "   commit-knowledge"
    echo ""
    echo "たったこれだけ！🦈"
else
    echo "❌ ファイルが既に存在します: $target_file"
fi

# 元のディレクトリに戻る
cd "$ORIGINAL_DIR"