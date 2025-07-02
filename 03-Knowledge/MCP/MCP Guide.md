# MCP (Model Context Protocol) ガイド

Claude CodeのMCP機能に関する知見をまとめたファイルです。

## MCPとは
MCPは「LLMが外部ツールやデータソースにアクセスできるオープンプロトコル」です。Claude Codeの機能を拡張し、従来の言語モデル以上の操作を可能にします。

## 主要コンポーネント

### サーバータイプ
- **Stdio servers**: 標準入出力を使用
- **SSE servers**: Server-Sent Eventsを使用  
- **HTTP servers**: HTTP通信を使用

### サーバースコープ
- **Local**: 個人・プロジェクト固有の設定
- **Project**: チーム共有の設定
- **User**: プロジェクト横断で利用可能

## セットアップ方法

### 基本的な追加コマンド
```bash
claude mcp add <name> <command> [args...]
```

### 具体例
```bash
# Stdioサーバー
claude mcp add my-server -e API_KEY=123 -- /path/to/server arg1 arg2

# SSEサーバー  
claude mcp add --transport sse sse-server https://example.com/sse-endpoint

# HTTPサーバー
claude mcp add --transport http http-server https://example.com/mcp
```

## 使用方法

### 1. @メンション - MCPリソースを参照
```
> Can you analyze @github:issue://123 and suggest a fix?
```

### 2. スラッシュコマンド - MCPプロンプトを実行
```
> /mcp__github__list_prs
```

## 管理コマンド
- `/mcp` - サーバー接続を管理
- `claude mcp` - MCP設定の確認・管理

## 重要な注意点
- リモートサーバーはOAuth 2.0で認証
- サードパーティMCPサーバーの安全性に注意
- 設定ファイルの場所とスコープを理解して適切に管理

## 利点
- 外部ツールやデータとの柔軟な連携
- プロトコルの拡張性
- プロジェクト間での設定共有
- 多様なトランスポート方式のサポート

## 関連ドキュメント
- [[Obsidian MCP Integration]] - ObsidianとのMCP連携
- [[01-Global/CLAUDE]] - グローバル設定でのMCP活用

## 参考
- 公式ドキュメント: https://docs.anthropic.com/en/docs/claude-code/mcp

---
Tags: #mcp #claude-code #integration #protocol