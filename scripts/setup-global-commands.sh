#!/bin/bash

# グローバルコマンド設定スクリプト

echo "🌍 グローバルナレッジコマンド設定"
echo "================================"
echo ""

VAULT_PATH="/home/hoshi/project/cc_env/claude-code-vault"

# シェル種別判定
if [ -n "$ZSH_VERSION" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
    SHELL_NAME="zsh"
elif [ -n "$BASH_VERSION" ]; then
    SHELL_CONFIG="$HOME/.bashrc"
    SHELL_NAME="bash"
else
    echo "❌ サポートされていないシェルです"
    exit 1
fi

echo "検出されたシェル: $SHELL_NAME"
echo "設定ファイル: $SHELL_CONFIG"
echo ""

# 関数を追加
FUNCTIONS="
# Claude Code ナレッジ管理コマンド
function add-knowledge() {
    bash $VAULT_PATH/scripts/global-add-knowledge.sh
}

function commit-knowledge() {
    bash $VAULT_PATH/scripts/commit-knowledge.sh
}

function open-vault() {
    cd $VAULT_PATH
}
"

# 既存の設定をチェック
if grep -q "add-knowledge" "$SHELL_CONFIG" 2>/dev/null; then
    echo "⚠️  既にナレッジコマンドが設定されています"
    read -p "上書きしますか？ (y/N): " overwrite
    if [[ ! $overwrite =~ ^[Yy]$ ]]; then
        echo "設定をキャンセルしました"
        exit 0
    fi
    # 既存の設定を削除
    sed -i '/# Claude Code ナレッジ管理コマンド/,/^$/d' "$SHELL_CONFIG"
fi

# 新しい設定を追加
echo "$FUNCTIONS" >> "$SHELL_CONFIG"

echo "✅ グローバルコマンドを設定しました！"
echo ""
echo "使用可能なコマンド:"
echo "  add-knowledge      - どこからでもナレッジ追加"
echo "  commit-knowledge   - ナレッジのコミット・プッシュ"
echo "  open-vault        - ナレッジベースに移動"
echo ""
echo "設定を有効にするには以下を実行："
echo "  source $SHELL_CONFIG"
echo ""
echo "または新しいターミナルを開いてください 🦈"