# Claude Code 思考モード活用ガイド

Claude Codeの思考モード機能の詳細な活用法をまとめたファイルです。

## 思考モードとは

Claude Codeでは、特定のキーワードを使用することで、より深い分析や複雑な問題解決のための「思考時間」を確保できます。これにより、より質の高い回答や実装を得ることができます。

## 思考モードの種類

### 1. `think` - 基本思考モード
- **トークン予算**: 4,000トークン
- **適用場面**: 
  - 中程度の複雑さの問題
  - アーキテクチャの検討
  - 実装方針の決定
  - コードレビューの実施

### 2. `think hard` - 深い思考モード
- **トークン予算**: 10,000トークン
- **適用場面**:
  - 複雑なシステム設計
  - パフォーマンス最適化
  - セキュリティ考慮事項の検討
  - 複数の実装選択肢の比較

### 3. `ultrathink` - 最大思考モード
- **トークン予算**: 31,999トークン
- **適用場面**:
  - 非常に複雑な問題の解決
  - 大規模システムのリファクタリング
  - 新技術の導入検討
  - 包括的な技術調査

## 効果的な使用例

### アーキテクチャ設計での活用
```
think hard about the best architecture for a microservices-based 
e-commerce platform that needs to handle 100,000 concurrent users
```

### パフォーマンス最適化での活用
```
ultrathink about optimizing this database query that's causing 
performance bottlenecks in our user dashboard
```

### セキュリティレビューでの活用
```
think about potential security vulnerabilities in this authentication 
system and suggest improvements
```

## 使用タイミングの判断基準

### `think`を使うべき場合
- [ ] 複数の実装方法がある
- [ ] 既存コードとの整合性を考慮する必要がある
- [ ] テスト戦略を検討したい
- [ ] コードレビューで指摘されたい

### `think hard`を使うべき場合
- [ ] システム全体への影響を考慮する必要がある
- [ ] パフォーマンスが重要な要素
- [ ] セキュリティが重要な要素
- [ ] 複数の技術選択肢を比較したい

### `ultrathink`を使うべき場合
- [ ] 非常に複雑で影響範囲の大きい変更
- [ ] 新しい技術スタックの導入
- [ ] 大規模なリファクタリング
- [ ] 包括的な技術調査が必要

## 実践的な活用パターン

### 1. 段階的思考
```
First, think about the high-level approach for this feature.
Then think hard about the detailed implementation.
Finally, ultrathink about potential edge cases and failure modes.
```

### 2. 比較検討
```
think hard about the pros and cons of using Redux vs Zustand 
for state management in this React application
```

### 3. 問題分析
```
ultrathink about why this distributed system is experiencing 
data consistency issues and propose a comprehensive solution
```

## 組み合わせテクニック

### コンテキスト提供 + 思考モード
```
Given this codebase with 50+ microservices and high traffic requirements,
think hard about the best approach for implementing distributed tracing
```

### 制約条件 + 思考モード
```
With a limited budget and 2-week timeline, think about the most 
pragmatic solution for improving our API response times
```

## 思考モード使用後のアクション

### 1. 実装前の確認
思考モードでの分析結果を受けて、実装前に以下を確認：
- 提案された解決策の妥当性
- 追加で考慮すべき要素の有無
- 実装の優先順位

### 2. ドキュメント化
重要な思考過程は以下にドキュメント化：
- プロジェクトのCLAUDE.md
- アーキテクチャドキュメント
- 技術的意思決定記録（ADR）

### 3. フォローアップ
- 実装後の振り返り
- 思考モードでの予測と実際の結果の比較
- 学習ポイントの抽出

## 注意点とベストプラクティス

### 効果的な使用のために
- **具体的な問題設定**: 曖昧な質問ではなく、具体的な課題を提示
- **コンテキストの提供**: 関連する制約条件や要求事項を明示
- **期待する成果物の明確化**: 何を求めているかを明確に伝える

### 避けるべき使用法
- **単純な問題への過度な適用**: 簡単な問題に`ultrathink`は不要
- **時間制約下での乱用**: 急ぎの場合は適切なレベルを選択
- **思考結果への盲信**: 生成された内容も批判的に評価

## 測定と改善

### 効果測定の指標
- 思考モード使用前後の解決策の質
- 実装時間の短縮効果
- バグや問題の事前発見率

### 継続的改善
- 思考モードの使用パターンを記録
- 効果的だった使用例の蓄積
- チーム内での知見共有

---
Tags: #claude-code #thinking-modes #problem-solving #analysis #best-practices