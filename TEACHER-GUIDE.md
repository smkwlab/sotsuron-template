# 教員向け添削ワークフローガイド

## 概要

このガイドは、GitHub を使った論文添削の教員向け操作手順です。
ハイブリッドワークフローにより、差分レビューと全体レビューの両方を効率的に実施できます。

## ワークフロー概要

### ブランチ構成

```
initial-empty (空の初期状態) ← レビュー用PRのベース
 ├─ 0th-draft (目次案)
 ├─ 1st-draft (0th-draftベース) ← 差分明確
 ├─ 2nd-draft (1st-draftベース) ← 差分明確
 ├─ 3rd-draft (2nd-draftベース) ← 差分明確
 └─ review-branch (定期的に最新版をマージ)
```

### レビュー用PRの特徴

- **ベース**: `initial-empty` (空の初期状態)
- **ヘッド**: `review-branch` (常に最新の学生版)
- **目的**: 論文全体への添削（merge済み箇所含む）
- **運用**: 絶対にマージしない、最終提出まで維持

### レビューの使い分け

| コメントの種類 | 使用するPR |
| ------------ | ----------- |
| 目次案への指摘 | 0th-draft PR |
| 直前版からの変更点 | 各版のPR (1st-draft等) |
| 論文全体の構成 | レビュー用PR |
| merge済み箇所への追加指摘 | レビュー用PR |
| 章を跨ぐ整合性の確認 | レビュー用PR |
| 最終提出前の全体確認 | レビュー用PR |

## 初期設定

### リポジトリ作成（自動化済み）

```bash
# 複数学生のリポジトリを一括作成
./create-student-repos.sh k21rs001 k21rs002 k21gjk01

# 自動的に以下が実行される：
# 1. リポジトリ作成（テンプレートから）
# 2. LaTeX devcontainer追加 (aldc)
# 3. initial-empty ブランチ作成（空の初期状態）
# 4. 0th-draft ブランチ作成（initial-emptyベース）
# 5. review-branch ブランチ作成（initial-emptyベース）
# 6. レビュー用PR作成（initial-empty → review-branch, do-not-mergeラベル付き）
```

### 手動設定が必要な項目

作成後、必要に応じて以下を設定：

1. **Collaboratorの追加**
   ```bash
   gh api repos/smkwlab/{repo-name}/collaborators/{username} \
     --method PUT \
     --field permission=write
   ```

2. **Branch protection rules**（推奨）
   - main ブランチの保護
   - PR required for merging

## 日常的な添削作業

### 1. 学生からPRが来たとき

#### A. 差分レビュー（各版のPR）

1. **PR内容の確認**
   ```bash
   # PRの詳細を確認
   gh pr view {pr-number}
   
   # 変更差分を確認
   gh pr diff {pr-number}
   ```

2. **レビュー実施**
   - GitHub Web UI でレビューを実施
   - 直前版からの変更部分にコメント
   - 必要に応じてSuggestionを使用

3. **Suggestionを使用する場合の注意**
   ```
   ✅ Do: Suggestionでコメント後、mergeせずに待機
   ❌ Don't: Suggestionがあるのに即座にmerge
   ```

#### B. 全体レビュー（必須）

**重要**: 学生がPRを提出したら、必ずreview-branchを更新してください。

1. **review-branchの更新**
   ```bash
   # update-review-branch.sh スクリプトを使用（推奨）
   
   # リポジトリ名を指定する方法
   ./update-review-branch.sh k21rs001-sotsuron 0th-draft
   ./update-review-branch.sh k21rs001-sotsuron 1st-draft
   ./update-review-branch.sh k21gjk01-master 2nd-draft
   
   # 学生リポジトリディレクトリ内で実行（Gitリモートから自動取得）
   cd k21rs001-sotsuron
   ../update-review-branch.sh 0th-draft
   ../update-review-branch.sh 1st-draft
   
   # 学生リポジトリディレクトリ内で実行（最新PR自動検出）
   cd k21rs001-sotsuron
   ../update-review-branch.sh    # リポジトリ名と最新PRを自動検出
   
   # 手動で実行する場合：
   cd k21rs001-sotsuron  # 該当リポジトリに移動
   git fetch origin
   git checkout review-branch
   git merge origin/0th-draft  # または1st-draft等
   git push
   ```

2. **レビュー用PRで全体レビュー実施**
   - 論文全体の構成確認
   - 以前の部分への追加指摘
   - 章を跨ぐ整合性の確認

#### レビューの使い分け例

```
0th-draft (目次案) 提出時:
1. 0th-draft PR: 目次構成のレビュー
2. update-review-branch.sh k21rs001-sotsuron 0th-draft 実行
3. レビュー用PR: 全体的な構成コメント

1st-draft 提出時:
1. 1st-draft PR: 0th-draftからの変更点レビュー  
2. update-review-branch.sh k21rs001-sotsuron 1st-draft 実行
3. レビュー用PR: 論文全体の内容確認（merge済み0th-draft含む）

2nd-draft 提出時:
1. 2nd-draft PR: 1st-draftからの変更点レビュー
2. update-review-branch.sh k21rs001-sotsuron 2nd-draft 実行  
3. レビュー用PR: 論文全体確認（merge済み1st-draft含む）
```

### 2. Suggestion対応フロー

#### 通常のレビューフロー

```
1. 教員: PRをレビュー、Suggestionでコメント
2. 教員: mergeせずに待機
3. 学生: Apply suggestion → Re-request review 🔄
4. 教員: 確認後にPRをmerge
5. 教員: update-review-branch.sh でレビューブランチ更新
```

#### Re-request review受信後の対応

1. **通知の確認**
   ```
   📧 "Re-requested review on PR #3: 1st-draft"
   ```

2. **学生の適用内容を確認**
   ```bash
   # Commit historyでSuggestion適用を確認
   gh pr view {pr-number}
   ```

3. **問題なければPRをmerge**
   ```bash
   gh pr merge {pr-number} --merge
   ```

4. **レビューブランチを更新**
   ```bash
   ./update-review-branch.sh {repo-name} {merged-branch}
   # 例: ./update-review-branch.sh k21rs001-sotsuron 1st-draft
   ```

### 3. 並行作業時のサポート

学生が並行作業をしている場合のサポート手順：

#### 学生向け指示

```
学生への標準的な指示：
「1st-draft PR提出後、2nd-draftブランチを作成して次稿執筆を開始してください。
私のmerge完了後、GitHub Desktop で以下の操作をしてください：
1. Current Branch → main に切り替え
2. Fetch origin で最新版取得
3. Current Branch → 2nd-draft に戻る
4. Branch → Update from main をクリック」
```

#### 競合発生時のサポート

```bash
# 学生のローカルリポジトリで競合が発生した場合
# リモートで確認
git log --oneline --graph {student-branch}

# 必要に応じて学生と画面共有で解決支援
```

## スクリプト活用

### create-student-repos.sh

```bash
# 卒業論文リポジトリ作成
./create-student-repos.sh k21rs001 k21rs002 k21rs003

# 修士論文リポジトリ作成
./create-student-repos.sh k21gjk01 k21gjk02

# 混在も可能
./create-student-repos.sh k21rs001 k21gjk01 k21rs002
```

### update-review-branch.sh

```bash
# 基本的な使用方法
./update-review-branch.sh {リポジトリ名} {マージした稿ブランチ}

# 例
./update-review-branch.sh k21rs001-sotsuron 1st-draft
./update-review-branch.sh k21gjk01-master 2nd-draft

# 学生リポジトリディレクトリ内で実行（Gitリモートから自動取得）
cd k21rs001-sotsuron
../update-review-branch.sh 1st-draft

# 最新PR自動検出
cd k21rs001-sotsuron  
../update-review-branch.sh    # リポジトリ名と最新PRを自動検出
```

## 複数人レビューの運用方法

### パターン1: 役割分担型（推奨）

#### レビュアーの役割分担

```
主指導教員（Primary Reviewer）:
- 全体構成・内容の妥当性
- 研究手法・結果の評価
- 最終的な合否判断

副指導教員/先輩（Secondary Reviewer）:
- 文章表現・日本語
- LaTeX記法・体裁
- 参考文献の形式

第三者（External Reviewer）※任意:
- 客観的視点での確認
- 専門外の人への分かりやすさ
```

#### 作業手順

1. **学生がPR提出**
   ```bash
   # 通常通りPR作成
   gh pr create --title "1st-draft" --body "第1稿の提出"
   ```

2. **主指導教員が最初にレビュー**
   ```bash
   # Reviewersに副指導教員を追加
   gh pr edit {pr-number} --add-reviewer {sub-teacher-username}
   
   # 内容・構成をレビュー
   # 「Changes requested」または「Comment」でレビュー実施
   ```

3. **副指導教員が文章・体裁をレビュー**
   ```bash
   # 主指導教員のレビュー後に実施
   # textlint以外の日本語表現チェック
   # LaTeX記法の改善提案
   ```

4. **Suggestionの調整**
   ```
   ルール例:
   - 文章修正のSuggestion: 副指導教員が担当
   - 内容修正の指示: 主指導教員がコメントのみ
   - 学生は全Suggestion適用後にRe-request review
   ```

### パターン2: 段階的レビュー型

#### フェーズ分けでの対応

```
Phase 1 (構成確認): 主指導教員のみ
└─ 構成OKなら Phase 2 へ

Phase 2 (詳細確認): 主指導教員 + 副指導教員
└─ 文章・体裁を並行してレビュー

Phase 3 (最終確認): 全員
└─ 最終チェック・承認
```

#### GitHub上での運用

```bash
# Phase 1: 主指導教員のみをアサイン
gh pr create --title "1st-draft (Phase1: 構成確認)" 

# Phase 2: 副指導教員を追加
gh pr edit {pr-number} --add-reviewer {sub-teacher-username}
gh pr edit {pr-number} --title "1st-draft (Phase2: 詳細確認)"

# Phase 3: 外部レビュアーも追加（必要時）
gh pr edit {pr-number} --add-reviewer {external-reviewer}
gh pr edit {pr-number} --title "1st-draft (Phase3: 最終確認)"
```

### パターン3: 完全並行レビュー型

#### 同時レビューでの効率化

```bash
# 最初から全レビュアーをアサイン
gh pr create --title "1st-draft" \
  --reviewer {primary-teacher},{sub-teacher},{external-reviewer}
```

#### 競合回避のルール

```
コメント重複の防止:
- Primary: 章・節レベルの大きな指摘
- Secondary: 段落・文レベルの細かい指摘  
- External: 全体的な分かりやすさ

Suggestionの調整:
- 内容に関わるもの: Primary のみ
- 表現・体裁: Secondary のみ
- 学生への説明: 誰でも可
```

### 複数人レビュー時の設定

#### 1. GitHub設定の調整

```bash
# PR作成時のデフォルトレビュアー設定
# .github/CODEOWNERS に記載
* @primary-teacher @sub-teacher

# 必要な承認数の設定（2人以上など）
gh api repos/smkwlab/{repo}/branches/main/protection \
  --method PUT \
  --field required_pull_request_reviews='{"required_approving_review_count":2}'
```

#### 2. update-review-branch.sh の拡張

```bash
# 複数人レビュー対応版の作成検討
./update-review-branch.sh k21rs001 1st-draft --multi-reviewer
```

#### 3. 通知の管理

```
効率的な通知管理:
- GitHub通知設定でPR関連のみ有効化
- Slack/Teams連携でリアルタイム共有
- 週次進捗会議での一括確認
```

### 複数人レビューのベストプラクティス

#### レビュー品質の向上

```
1. 観点の明確化:
   各レビュアーが何を見るかを事前に決定

2. 重複排除:
   同じ指摘が複数人から出ないよう調整

3. 優先順位付け:
   Critical/Major/Minor での分類

4. 建設的フィードバック:
   改善案も合わせて提示
```

#### 学生への配慮

```
1. 混乱防止:
   相反する指摘がある場合は教員間で調整

2. 段階的修正:
   一度に大量の修正を求めない

3. 成長支援:
   なぜその修正が必要かの説明を重視

4. モチベーション維持:
   良い点も積極的に評価
```

### トラブル時の対処法

#### 教員間での意見相違

```bash
# PR上でのディスカッション
gh pr comment {pr-number} --body "@sub-teacher この部分についてどう思われますか？"

# 必要に応じてオフラインで議論
# 学生には統一見解を提示
```

#### レビュー遅延の対応

```
対策例:
- レビュー期限の明確化（48時間以内など）
- 代理レビュー体制の構築
- 緊急時の連絡方法確立
```

## 効率的な添削のコツ

### 1. レビューの使い分けパターン

```
目次案 (0th-draft):
→ 0th-draft PR で構成の相談・確認

第1稿 (1st-draft):
→ 1st-draft PR で新規執筆部分をレビュー
→ レビュー用PR で全体構成確認

第2稿以降:
→ 各版PR で変更点をレビュー（効率重視）
→ レビュー用PR で必要に応じて全体確認
```

### 2. Suggestionの効果的な使用

```
効果的なケース:
- 軽微な修正（誤字、表現改善）
- 具体的な修正提案がある場合

避けるべきケース:
- 大幅な構成変更
- 学生の理解が必要な概念的修正
```

### 3. 推奨スケジュール

```
月曜: 学生がPR提出
火曜: 教員がreview実施
水曜: 学生がsuggestion適用 + re-request（該当時）
木曜: 教員がmerge実行 + review-branch更新
金曜: 学生が次版執筆開始
```

## トラブルシューティング

### よくある問題と対処法

#### 1. レビュー用PRでコンフリクト

```bash
# review-branchをリセット
git checkout review-branch
git reset --hard 0th-draft
git merge origin/{latest-student-branch}
git push --force-with-lease
```

#### 2. 学生のブランチ作成ミス

```bash
# 正しいベースブランチを指定してブランチ作成支援
git checkout {correct-base-branch}
git checkout -b {new-branch-name}
git push -u origin {new-branch-name}
```

#### 3. aldc実行ファイルの残留

```bash
# 一時ファイルの削除
find . -name "*-aldc" -type f -delete
```

## セキュリティとベストプラクティス

### 1. リポジトリアクセス管理

- プライベートリポジトリの確認
- 必要最小限のCollaborator設定
- 定期的なアクセス権限見直し

### 2. ブランチ保護

```bash
# main ブランチ保護設定例
gh api repos/smkwlab/{repo}/branches/main/protection \
  --method PUT \
  --field required_status_checks='{"strict":true,"contexts":[]}' \
  --field enforce_admins=true \
  --field required_pull_request_reviews='{"required_approving_review_count":1}'
```

### 3. バックアップ

```bash
# 重要な節目でのバックアップ
git tag v1.0-{student-id}-submit
git push origin v1.0-{student-id}-submit
```

## 最終提出時の処理

### 1. 提出版の確認

```bash
# submitタグの確認
git tag -l "*submit*"
git show submit

# 最終PDF生成確認
# GitHub Actions の実行状況確認
```

### 2. リポジトリのアーカイブ

```bash
# 提出完了後のアーカイブ（任意）
gh repo archive smkwlab/{student-repo}
```

## その他

### GitHub Actions設定

- PDF自動生成の確認
- Reviewer自動アサインの確認
- 必要に応じてworkflow調整

### 学生指導のポイント

- GitHub Desktopの基本操作支援
- ブランチ概念の簡単な説明
- commit頻度の指導
- 印刷推敲の重要性

質問がある場合は smkwlabML で共有し、ノウハウを蓄積していきましょう。