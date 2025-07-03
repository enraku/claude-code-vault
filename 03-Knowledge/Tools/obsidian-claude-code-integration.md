# Obsidian + Claude Code + MCP統合によるナレッジ管理

## ナレッジ情報

### タイトル
Obsidian + Claude Code + MCP統合によるナレッジ管理システム

### カテゴリ
- [x] 開発ツール・環境
- [ ] 言語・フレームワーク
- [ ] アーキテクチャ・設計パターン
- [ ] トラブルシューティング
- [ ] パフォーマンス・最適化
- [ ] セキュリティ
- [ ] その他

### 発見元プロジェクト
Claude Code環境統一プロジェクト (claude-code-vault)

### 重要度
- [x] 高 - 多くのプロジェクトで活用可能
- [ ] 中 - 特定の技術スタックで有用
- [ ] 低 - 参考程度

## ナレッジ内容

### 概要
ObsidianをナレッジベースとしながらClaude CodeとMCPで連携し、AIがナレッジにアクセス・更新できる統合システムの構築方法

### 詳細

#### システム構成
1. **Obsidianボルト**: Markdownベースのナレッジ管理
2. **Claude Code**: AI開発支援ツール
3. **MCP (Model Context Protocol)**: Claude CodeとObsidianの橋渡し
4. **Git**: バージョン管理とチーム共有

#### セットアップ手順

```bash
# 1. Obsidianボルト構造作成
mkdir -p vault/{00-Dashboard,01-Global,02-Languages,03-Knowledge,04-Templates,05-Archive}

# 2. MCP設定スクリプト実行
./scripts/setup-mcp.sh

# 3. グローバルCLAUDE.md設定
ln -s $(pwd)/01-Global/CLAUDE.md ~/.claude/CLAUDE.md
```

#### MCPサーバー設定例

```javascript
// MCP server for Obsidian vault access
claude mcp add obsidian-vault --transport stdio -- node -e "
const fs = require('fs');
const path = require('path');

process.stdin.on('data', (data) => {
  const request = JSON.parse(data.toString());
  
  if (request.method === 'read_file') {
    const filePath = path.join(VAULT_PATH, request.params.path);
    const content = fs.readFileSync(filePath, 'utf8');
    process.stdout.write(JSON.stringify({
      id: request.id,
      result: { content }
    }) + '\\n');
  }
});
"
```

### 適用場面
- ナレッジの継続的蓄積が必要なプロジェクト
- チーム開発でのナレッジ共有
- AI支援開発環境の構築
- ドキュメント中心の開発プロセス

### 注意点・制約
- Obsidianプラグインのバージョン依存性
- MCPサーバーの安定性確保が必要
- ファイル命名規則の統一（kebab-case推奨）
- Git競合回避のためのワークフロー整備

### 関連リソース
- [Obsidian公式ドキュメント](https://help.obsidian.md/)
- [Claude Code MCP Documentation](https://docs.anthropic.com/en/docs/claude-code/mcp)
- [Model Context Protocol Specification](https://modelcontextprotocol.io/)
- [[obsidian-mcp-integration|詳細なMCP統合ガイド]]

## メタ情報

### 作成者
gura (Claude Code AI Assistant)

### 作成日
2025-07-03

### 更新履歴
- 2025-07-03 初版作成 - システム構築経験をナレッジ化

---
Tags: #knowledge #tools #obsidian #claude-code #mcp #knowledge-management