# CLAUDE.md ベストプラクティス・リファレンス

Claude CodeのCLAUDE.mdファイルに関する知見とベストプラクティスをまとめたファイルです。

## 参考にしたWebサイト

### 1. Apidog Blog - "What's a Claude.md File? 5 Best Practices"
https://apidog.com/blog/claude-md/
- CLAUDE.mdファイルの基本概念と5つのベストプラクティス
- プロジェクト構造、場所、内容の推奨事項

### 2. Anthropic公式 - "Claude Code Best Practices"
https://www.anthropic.com/engineering/claude-code-best-practices
- 公式のベストプラクティス
- ワークフロー、テスト駆動開発、視覚的反復開発

### 3. Simon Willison's Blog - "Claude Code: Best practices for agentic coding"
https://simonwillison.net/2025/Apr/19/claude-code-best-practices/
- 思考モードの活用法
- 拡張思考の活用

### 4. Nathan LeClaire's Blog - "Vibing Best Practices with Claude Code"
https://nathanleclaire.com/blog/2025/03/10/vibing-best-practices-with-claude-code/
- 実践的なワークフロー
- 批判的思考の重要性

## CLAUDE.mdファイルとは

CLAUDE.mdは、Claude Codeが自動的にコンテキストに取り込む特別なMarkdownファイルです。プロジェクト固有の要求事項や規約をAIに理解させるための「制御パネル」「憲法」的役割を果たします。

## ベストプラクティス

### 1. 簡潔で効率的な記述
- **短い宣言文**: 箇条書きを使用
- **冗長性の排除**: 長い段落的記述は避ける
- **必要な情報のみ**: Claudeが作業に必要なルールのみ含める
- **トークン効率**: ファイル内容は毎回プロンプトに追加されるため、簡潔性が重要

### 2. 明確な構造化
```markdown
# プロジェクト名
## 技術スタック
## プロジェクト構造
## コマンド
## コードスタイル
## 制約事項
```

### 3. 推奨コンテンツ
- **共通のbashコマンド**
- **コアファイルとユーティリティ関数**
- **コードスタイルガイドライン**
- **テスト手順**
- **リポジトリエチケット**（ブランチ命名、マージ vs リベース）
- **開発環境セットアップ**
- **予期しない動作や警告**

### 4. ファイル配置オプション
- **リポジトリルート**: `CLAUDE.md`（最も一般的）
- **親ディレクトリ**: モノレポに有用
- **サブディレクトリ**: 特定部分のコンテキスト用
- **ホームフォルダ**: `~/.claude/CLAUDE.md`
- **ローカルオーバーライド**: `CLAUDE.local.md`

### 5. 動的なドキュメント管理
- **反復的開発**: `/init`コマンドから始める
- **生きた文書**: 継続的に更新・改良
- **有機的構築**: セッション中に`#`を押してリアルタイム更新
- **定期的な見直し**: 簡潔性と関連性を保つ

## 高度なテクニック

### 思考モードの活用
- `think`: 4,000トークン予算
- `think hard`: 10,000トークン予算  
- `ultrathink`: 31,999トークン予算

### プロンプト改善
- Anthropicでは定期的にCLAUDE.mdファイルをプロンプト改善ツールで最適化
- "IMPORTANT"や"YOU MUST"などの強調表現で遵守率向上

### ワークフロー推奨事項
1. **探索・計画・コード・コミット**のサイクル
2. **テスト駆動開発**の実践
3. **視覚的反復**による設計実装
4. **早期の軌道修正**

## 注意点

### 批判的思考の維持
- AIを完全に信頼せず、人間の監視を維持
- 生成されたコードの論理的妥当性を検証
- 必要に応じてアプローチの変更を躊躇しない

### 厳格な品質管理
- 積極的なlint設定
- 定期的なフォーマット・テストツール実行
- 手動でのコード検証

## 2025年のトレンド

- Markdownファイルによる自動ワークフロー起動
- コードコミットではなく文書変更に基づくタスク実行
- AI支援開発における人間の意図とAI実行の橋渡し役としての重要性増大

## 関連ドキュメント
- [[01-Global/CLAUDE]] - グローバルCLAUDE.md設定
- [[01-Global/CLAUDE-ja]] - 日本語版グローバル設定
- [[Thinking Modes]] - 思考モードの詳細活用法

## まとめ

CLAUDE.mdファイルは、Claude Codeを「汎用チャットボットから専門的で不可欠な開発チームメンバー」に変貌させる重要なツールです。適切に構成・管理することで、効率的なAI支援開発が実現できます。

---
Tags: #claude-code #best-practices #claude-md #documentation #workflow