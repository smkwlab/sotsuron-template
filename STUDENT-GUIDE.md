# 学生向け論文執筆ガイド

## はじめに

このガイドは、GitHub Desktop を使って論文執筆を進める学生向けの操作手順です。
Git の詳しい知識は必要ありません。GitHub Desktop の操作だけで論文執筆を完了できます。

## 前提条件

教員により以下が事前に準備されています：
- 個人用リポジトリの作成
- **LaTeX devcontainer 追加済み**
- 0th-draft ブランチの作成
- レビュー用PRの設定

## 基本的な流れ

1. **リポジトリをPCにクローン**
2. **0th-draft ブランチで目次案を作成・提出**
3. **1st-draft ブランチで第1稿を執筆・提出**
4. **教員の添削を確認し、必要に応じてSuggestionを適用**
5. **2nd-draft ブランチで第2稿を執筆**
6. **3稿目以降も同様に繰り返し**

## 詳細な操作手順

### 1. リポジトリのクローン

1. 教員から通知されたリポジトリのURLにアクセス
2. `Code` ボタンをクリック
3. `Open with GitHub Desktop` をクリック
4. 保存場所を確認して `Clone` ボタンをクリック

### 2. 目次案の作成（0th-draft）

1. GitHub Desktop で `Current Branch` が `0th-draft` になっていることを確認
   - もし `main` になっている場合は `0th-draft` に切り替え
2. VSCode で [sotsuron.tex](sotsuron.tex) を編集し、`chapter`, `section`, `subsection` などを記述
3. **PDF の生成・プレビュー**
   - VSCode で ▷ ボタン（Build LaTeX project）をクリックして PDF を生成
   - 🔍 ボタン（View LaTeX PDF）をクリックして VSCode 内でプレビュー
4. GitHub Desktop で commit & push
5. GitHub Desktop で `Create Pull Request` をクリック
   - `Title` に **0th-draft** を記述
   - 説明や質問があれば記述
   - `Create pull request` をクリック

### 3. 第1稿の執筆（1st-draft）

#### 3.1 ブランチ作成

1. GitHub Desktop で `Current Branch` ボタンをクリック
2. `New Branch` ボタンをクリック
3. `Name` を **1st-draft** とする
4. `Create branch based on...` で **0th-draft** を選択（重要！）
5. `Create Branch` → `Publish branch` をクリック

#### 3.2 論文執筆

1. 現在のブランチが `1st-draft` であることを確認
2. `Open in Visual Studio Code` で編集開始
3. **LaTeX Workshop 拡張機能**を使って論文を執筆
   - `.tex` ファイルを開くと LaTeX Workshop が自動起動
   - ファイル保存時に `textlint` による自動チェックが起動
   - **問題** タブで textlint の指摘を確認し適宜対応
4. **PDF の生成・プレビュー**
   - VSCode で ▷ ボタン（Build LaTeX project）をクリックして PDF 生成
   - 🔍 ボタン（View LaTeX PDF）をクリックして VSCode 内でプレビュー
   - または F1 → `LaTeX Workshop: View PDF` でプレビュー
5. GitHub Desktop で commit & push
6. 執筆完了まで 1〜5 を繰り返し

#### 3.3 添削依頼

1. 印刷して推敲を実施
2. GitHub Desktop で `Create Pull Request` をクリック
3. `Title` に **1st-draft** を記述
4. 変更点などを説明欄に記述
5. `Create pull request` をクリック

### 4. 添削結果の確認

#### 4.1 コメントの確認

添削コメントは **2つのPR** で確認してください：

1. **あなたが作成したPR（1st-draft等）**
   - 直前版からの変更点に対するコメント
   - 新規追加部分への指摘

2. **レビュー用PR**
   - 論文全体に対するコメント
   - 以前の部分への追加指摘
   - 全体構成への意見

#### 4.2 Suggestionへの対応

教員からSuggestionがある場合：

1. **Suggestionの適用**
   ```
   GitHub Web画面で：
   1. suggestion右上の「Apply suggestion」ボタンをクリック
   2. 複数ある場合は「Add suggestion to batch」で一括適用
   3. 「Commit suggestions」でcommit実行
   ```

2. **適用完了の通知**
   ```
   PR画面で：
   1. 右側の「Reviewers」セクションを確認
   2. 教員名の横の🔄アイコンをクリック
   3. 「Re-request review」を選択
   ```

### 5. 次稿の準備（2nd-draft以降）

#### 5.1 ブランチ作成

1. GitHub Desktop で `Current Branch` ボタンをクリック
2. `New Branch` ボタンをクリック
3. `Name` を **2nd-draft** など、次の稿であることが分かる名前にする
4. `Create branch based on...` で以下を選択：
   - **1st-draft → 2nd-draft**: `1st-draft` を選択
   - **2nd-draft → 3rd-draft**: `2nd-draft` を選択
   - ※ **直前の稿をベースとする**（差分を明確にするため）
5. `Create branch` → `Publish branch` をクリック

#### 5.2 効率的な執筆方法

**待機時間を短縮**: 前稿のPR提出後、教員のmerge完了を待たずに次稿の執筆を開始できます。

```
基本的な流れ：
1st-draft PR提出 → すぐに2nd-draft執筆開始
         ↓（並行して）
    教員レビュー・merge完了
         ↓
    2nd-draftを最新版に調整
```

#### 5.3 教員merge完了後の調整

教員から「mergeしました」の連絡があったら：

1. **最新版の取得**
   ```
   Current Branch → main に切り替え
   ↓
   [Fetch origin] ボタンをクリック
   ```

2. **執筆中ブランチの更新**
   ```
   Current Branch → 執筆中草稿ブランチ（例：2nd-draft）に切り替え
   ↓
   Branch → Update from main をクリック
   ```

3. **競合（Conflict）が発生した場合**
   - GitHub Desktop が自動的に競合解決画面を表示
   - 画面の指示に従って競合を手動で解決
   - 解決後、`Continue merge` をクリック

### 6. 最終提出

教員からOKの返事が来たら：

1. **提出版にタグを付与**
   - GitHub Desktop の `History` で最新の履歴を右クリック
   - `Create Tag...` をクリック
   - `Name` に **submit** と入力
   - `Create Tag` → `Push origin` でタグをプッシュ

2. **印刷物の提出** も忘れずに実施

## よくある質問

### Q: ブランチを間違って作成した場合は？
A: GitHub Desktop でブランチを削除し、正しいベースから作り直してください。

### Q: commitを間違えた場合は？
A: 新しいcommitで修正するか、教員に相談してください。

### Q: 競合解決がうまくいかない場合は？
A: 教員に相談してください。一緒に解決方法を確認します。

### Q: Re-request reviewボタンが見つからない場合は？
A: PRがOpenの状態で、かつ教員が一度reviewしている必要があります。

### Q: PDFが生成されない場合は？
A: LaTeX コンパイルエラーが発生している可能性があります。以下を確認してください：
- VSCode の **問題** タブでエラー内容を確認
- LaTeX Workshop の **出力** タブでコンパイルログを確認
- 日本語の文字化けや未定義コマンドがないかチェック

### Q: LaTeX Workshop拡張機能が動作しない場合は？
A: 以下を確認してください：
- devcontainer環境で作業していることを確認
- VSCode左下に「Dev Container」の表示があることを確認
- 拡張機能タブで LaTeX Workshop が有効になっていることを確認


## 注意点

- **ブランチ名の命名**: 0th-draft → 1st-draft → 2nd-draft の順序を守る
- **ベースブランチ**: 第1稿以降は必ず直前の稿をベースにする
- **commit頻度**: こまめにcommitして変更履歴を残す
- **PR作成**: 各稿の完成時に必ずPRを作成する
- **印刷推敲**: 画面だけでなく必ず印刷して確認する

## トラブル時の連絡先

質問があれば、遠慮なく smkwlabML ML へ連絡してください。
他の学生も同じ疑問を持っている可能性があります。
