# ワークフローと使用例

このドキュメントでは、sotsuron-template のワークフローと詳細なコマンド例を説明します。

## 学生向けワークフロー

### ワークフロー概要

このテンプレートは Pull Request ベースのレビューシステムを採用しています。

**ブランチ構造:**
- **main**: 基準ブランチおよび最終成果物
- **xth-draft**: 順次作成するドラフトブランチ（0th-draft, 1st-draft, 2nd-draft, ...）
- **abstract-xth**: 概要用ブランチ（abstract-1st, abstract-2nd, ...）

### Phase 1: 論文執筆
```
0th-draft → PR (base: main, アウトライン) → レビュー
1st-draft → PR (base: main) → レビュー
2nd-draft → PR (base: 1st-draft, 前回からの差分のみ) → レビュー
3rd-draft → PR (base: 2nd-draft, 前回からの差分のみ) → レビュー
...
```

### Phase 2: 概要執筆
```
abstract-1st → PR (base: 最新のdraft or main) → レビュー
abstract-2nd → PR (base: abstract-1st, 前回からの差分のみ) → レビュー
```

### Phase 3: 最終提出
```
最終版ブランチ → final タグ付与 → 提出完了
```

### ブランチ管理
- **作業ブランチ**: 各 draft PR は直前の draft をベースとする（前回からの差分のみを表示）
- **教員フィードバック**: PR で GitHub のコメントと suggestion 機能を使用
- **次のドラフト**: PR 作成後に自動的に次のブランチが作成される
- **PR の扱い**: PR はマージせず、レビュー完了後にクローズして次稿へ継続

### 教員の Suggest を次のドラフトに取り込む

PR 作成後、教員が Suggest を投稿した場合、それを次のドラフトブランチに取り込むことができます。

```bash
# 現在のブランチで自動判定して取り込み
git checkout 2nd-draft
./scripts/sync-suggestions.sh
# → 自動的に 1st-draft からの Suggest を取り込み

# ブランチを指定して実行
./scripts/sync-suggestions.sh 3rd-draft
# → 自動的に 2nd-draft からの Suggest を取り込み
```

**動作:**
- 現在のブランチ名から前のドラフトを自動判定
- 論文本体（xth-draft）と概要（abstract-xth）の両方に対応
- リモートから最新の変更を取得してマージ
- コンフリクトが発生した場合は手動で解決が必要

**注意事項:**
- `1st-draft` や `abstract-1st` では実行できません（前のドラフトが存在しないため）
- マージ後は `git push origin <ブランチ名>` でリモートに反映してください

## LaTeX コンパイル例

### 学部生論文のコンパイル
```bash
# 論文本体
latexmk -pv sotsuron.tex      # コンパイルとプレビュー
latexmk -c                    # 補助ファイルを削除
latexmk -C                    # PDF を含むすべての生成ファイルを削除

# 概要
latexmk -pv gaiyou.tex        # 概要をコンパイル

# 直接コンパイル（必要な場合、.latexmkrc で設定された uplatex を使用）
uplatex sotsuron.tex          # 本文
upbibtex sotsuron             # 参考文献
uplatex sotsuron.tex          # 2回目
uplatex sotsuron.tex          # 3回目
dvipdfmx sotsuron.dvi         # PDF に変換
```

### 大学院生論文のコンパイル
```bash
# 論文本体
latexmk -pv thesis.tex        # コンパイルとプレビュー
latexmk -c                    # 補助ファイルを削除
latexmk -C                    # PDF を含むすべての生成ファイルを削除

# 概要
latexmk -pv abstract.tex      # 概要をコンパイル

# 直接コンパイル（必要な場合、.latexmkrc で設定された uplatex を使用）
uplatex thesis.tex            # 本文
upbibtex thesis               # 参考文献
uplatex thesis.tex            # 2回目
uplatex thesis.tex            # 3回目
dvipdfmx thesis.dvi           # PDF に変換
```

## 文章品質チェック例

### 基本的な textlint の使用方法
```bash
# すべての .tex ファイルをチェック
textlint *.tex

# 可能な問題を自動修正（注意して使用）
textlint --fix *.tex

# 特定のファイルをチェック
textlint sotsuron.tex         # 学部生論文本体
textlint thesis.tex           # 大学院生論文本体
textlint gaiyou.tex           # 学部生概要
textlint abstract.tex         # 大学院生概要

# サンプルファイルをチェック
textlint example.tex
textlint example-gaiyou.tex
```

