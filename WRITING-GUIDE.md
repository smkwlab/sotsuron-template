# 論文執筆ガイド（卒業論文・修士論文）

卒業論文・修士論文の執筆で、他の文書と違う部分だけをまとめたガイドです。

- **執筆プロセスの流れとルール**（draft PR サイクル・PR の base・PR クローズ） → [STUDENT-WORKFLOW.md](https://github.com/smkwlab/latex-ecosystem/blob/main/docs/STUDENT-WORKFLOW.md)
- **GitHub Desktop とブラウザの操作**（クローン・ブランチ切り替え・commit & push・PR 作成・Suggestion 適用） → [GITHUB-DESKTOP-GUIDE.md](https://github.com/smkwlab/latex-ecosystem/blob/main/docs/GITHUB-DESKTOP-GUIDE.md)
- **執筆環境・ファイル構成・LaTeX の書き方** → [テンプレートの README](https://github.com/smkwlab/sotsuron-template/blob/main/.github/README.md)
- **本書** → 概要の執筆、論文提出、卒論・修論固有の疑問

## 概要の執筆

**重要**: 概要の執筆は、**教員から指示があったタイミング**で開始します。通常、論文本体がある程度完成した段階（3rd-draft 以降）です。指示があるまで始めないでください。

### 概要用ブランチの作成

最初の概要ブランチだけは自分で作成します（以降は自動作成されます）。

- ブランチ名: `abstract-1st`（英文概要 `abstract.tex`）/ `gaiyou-1st`（日本語概要 `gaiyou.tex`）
- 分岐元: **その時点で最新の稿ブランチ**（例: `5th-draft`。`submit` タグを付けた後であれば、そのタグを付けたブランチ）

操作手順は [GITHUB-DESKTOP-GUIDE.md の「ブランチを自分で作る場合」](https://github.com/smkwlab/latex-ecosystem/blob/main/docs/GITHUB-DESKTOP-GUIDE.md#ブランチを自分で作る場合) を参照してください。

### 概要の執筆と提出

1. 概要ファイル（`gaiyou.tex` または `abstract.tex`）を編集する
2. 論文本体と同様に commit & push する
3. PR を作成する（タイトル例: `abstract-1st`）
   - base は論文本体と同じ考え方で**前の稿のブランチ**にする
   - `abstract-1st` の PR: base は分岐元のブランチ（例: `base: 5th-draft` ← `compare: abstract-1st`）
   - `abstract-2nd` 以降の PR: 1 つ前の概要ブランチ（例: `base: abstract-1st` ← `compare: abstract-2nd`）
4. PR を作成すると次の概要ブランチ（`abstract-2nd` など）が自動作成される
5. 添削への対応と PR のクローズは論文本体と同じ

概要完成後の手順は教員から口頭で説明されます。

## 論文提出

教員から「論文提出 OK」の許可が出たら、提出版のコミットにタグを付けます。タグの付け方は [GITHUB-DESKTOP-GUIDE.md の「タグを付ける」](https://github.com/smkwlab/latex-ecosystem/blob/main/docs/GITHUB-DESKTOP-GUIDE.md#8-タグを付ける) を参照してください。

### `submit` タグ（論文本体の提出）

1. 提出版のコミットに **`submit`** タグを付けて push する
2. **印刷物の提出**も忘れずに行う
3. その後、教員の指示で概要の執筆に移る

`submit` タグは論文本体の提出許可版を示す目印です。このタグで `main` への自動処理は起こりません（タグを push すると PDF 付きの Release が作成されます）。

### `final` タグ（最終提出）

概要も含めて最終提出の許可が出たら、教員の指示に従って **`final`** または `final-*` 形式のタグを付けます。このタグを push すると、`main` への提出 PR が自動作成されます。**この PR のマージは教員が行います**。

## 卒論・修論でよくある質問

### Q: いつ概要の執筆を始めれば良いですか？

教員からの指示を待ってください。通常、論文本体の構成が固まった段階（3rd-draft 以降）で指示があります。その時点で最新の稿ブランチを分岐元にして `abstract-1st` を作成します。

### Q: PDF が生成されません

LaTeX のコンパイルエラーが発生している可能性があります。次を確認してください。

- VS Code の **問題** タブでエラー内容を確認する
- LaTeX Workshop の **出力** タブでコンパイルログを確認する
- 日本語の文字化けや未定義コマンドがないか確認する

### Q: LaTeX Workshop 拡張機能が動作しません

- devcontainer 環境で作業していることを確認する（VS Code 左下に「Dev Container」と表示される）
- 拡張機能タブで LaTeX Workshop が有効になっていることを確認する

### Q: 卒業論文と修士論文でファイルが違います

自分の種別に対応するファイルだけがリポジトリに置かれています。

- **卒業論文**: `sotsuron.tex`（本体）、`gaiyou.tex`（概要）、`example.tex` / `example-gaiyou.tex`（参考例）
- **修士論文**: `thesis.tex`（本体）、`abstract.tex`（概要）

## 執筆時の注意

- **印刷推敲**: 画面だけでなく、必ず印刷して読み直す（章ごとの印刷推敲を推奨）
- **commit 頻度**: こまめに commit して変更履歴を残す
- **textlint**: 保存時に日本語校正の指摘が出るので、**問題** タブで確認して対応する

## 質問・相談

質問があれば、遠慮なく smkwlabML へ連絡してください。他の学生も同じ疑問を持っている可能性があります。
