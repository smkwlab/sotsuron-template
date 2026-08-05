# 論文テンプレート

九州産業大学理工学部情報科学科の卒業論文・九州産業大学大学院情報科学研究科の修士論文用 LaTeX テンプレートを提供する。
VS Code devContainer を用いて、LaTeX 処理系、および textlint を内包している。

## 🎯 学生向けクイックスタート

執筆の流れ・レビューの受け方の全体像は [STUDENT-WORKFLOW ガイド（エコシステム共通）](https://github.com/smkwlab/latex-ecosystem/blob/main/docs/STUDENT-WORKFLOW.md) を参照。

### 1. リポジトリの作成

#### 前提条件

以下のソフトウェアがインストール済みであること：

1. **Docker Desktop** - LaTeX 環境の実行に必要
2. **GitHub Desktop** - リポジトリ管理・同期に必要
3. **GitHub CLI (gh)** - リポジトリ作成スクリプトの実行に必要
   - [インストール方法](https://github.com/smkwlab/student-repo-management/blob/main/docs/INSTALL-GH.md)

#### 準備

GitHub CLI の認証を完了してください：

```bash
gh auth login
```

**注意:** `gh` コマンドが見つからない場合は [インストール方法](https://github.com/smkwlab/student-repo-management/blob/main/docs/INSTALL-GH.md) を参照してください。

#### リポジトリ作成

```bash
bash <(curl -fsSL https://repo-setup.smkwlab.net) thesis
```

> 💡 短縮 URL は最新の安定版（v1 系）の setup.sh を配信します。

**実行手順:**
1. 上記コマンドを実行（macOS のターミナルまたは Windows の WSL 内）
2. 学籍番号を入力
3. 自動でリポジトリ作成・セットアップ完了

### 2. 執筆環境の起動

1. GitHub Desktop でリポジトリをクローンする（`Code` → `Open with GitHub Desktop`）
2. `Open in Visual Studio Code` で VS Code を開く
3. 「Dev Containers: Reopen in Container」を実行すると、LaTeX Workshop と textlint が使える状態になる
4. `Current Branch` が `0th-draft` になっていることを確認して執筆を始める

操作の詳細は [GITHUB-DESKTOP-GUIDE.md](https://github.com/smkwlab/latex-ecosystem/blob/main/docs/GITHUB-DESKTOP-GUIDE.md) を参照。

### 3. 論文執筆の流れ（draft PR サイクル）

draft ブランチで執筆し、Pull Request で添削を受け、自動作成される次稿ブランチで改稿を続ける繰り返しを **draft PR サイクル**と呼びます。

```
0th-draft: 目次案作成・提出
    ↓ (自動でブランチ作成・教員添削)
1st-draft: 第1稿執筆・提出  
    ↓ (自動でブランチ作成・教員添削)
2nd-draft: 第2稿執筆・提出
    ↓ (自動でブランチ作成・教員添削)
...以降繰り返し
    ↓ (教員の指示で)
abstract-1st: 概要執筆・提出
```

PR はマージせず自分でクローズすること、PR の base は前稿ブランチにすることなど、サイクルの共通ルールは
[STUDENT-WORKFLOW.md](https://github.com/smkwlab/latex-ecosystem/blob/main/docs/STUDENT-WORKFLOW.md) にまとまっています。

> 下川研以外の学生で `0th-draft` ブランチがないリポジトリの場合、draft PR サイクルは使いません。`main` ブランチで自由に執筆してください。

### 4. 関連ドキュメント

| 知りたいこと | 参照先 |
|---|---|
| 執筆の流れ・レビューの受け方・提出までのルール | [STUDENT-WORKFLOW.md](https://github.com/smkwlab/latex-ecosystem/blob/main/docs/STUDENT-WORKFLOW.md) |
| GitHub Desktop・ブラウザの操作手順 | [GITHUB-DESKTOP-GUIDE.md](https://github.com/smkwlab/latex-ecosystem/blob/main/docs/GITHUB-DESKTOP-GUIDE.md) |
| 概要の執筆・論文提出・卒論固有の FAQ | [WRITING-GUIDE.md](../WRITING-GUIDE.md) |
| 執筆環境・ファイル構成・LaTeX の書き方 | 本 README（以下） |

**教員向けツール**: [student-repo-management](https://github.com/smkwlab/student-repo-management)

## 📁 ファイル構成

### 論文タイプ別ファイル

#### 卒業論文用
- **`sotsuron.tex`**: 卒業論文本体（編集対象）
- **`gaiyou.tex`**: 卒業論文概要（教員指示後に編集）

#### 修士論文用  
- **`thesis.tex`**: 修士論文本体（編集対象）
- **`abstract.tex`**: 修士論文概要（教員指示後に編集）

### 参考ファイル（卒業論文）

- **`example.tex`**: 卒業論文執筆の例・参考
- **`example-gaiyou.tex`**: 卒業論文概要執筆の例・参考

### 設定ファイル

- **`plistings.sty`**: プログラムコード表示用
- **`.latexmkrc`**: LaTeX コンパイル設定
- **`.textlintrc`**: 日本語校正設定

## 🛠️ 開発環境

### 自動設定（推奨）

リポジトリには **devcontainer** が設定済みである。

- VS Code で開くと自動的に LaTeX 環境が利用可能
- LaTeX Workshop 拡張機能
- textlint による日本語校正
- 必要なパッケージ類

### 手動設定

独自環境を使用する場合は以下が必要である。

- **LaTeX**: TeX Live（最新版推奨）
- **エディタ**: VS Code + LaTeX Workshop拡張機能
- **校正**: textlint

## 📝 LaTeX の書き方

### 基本的な記述

```latex
% 章の作成
\chapter{研究背景}

% 節の作成  
\section{関連研究}

% 図の挿入
\begin{figure}[h]
\centering
\includegraphics[width=0.8\linewidth]{figure.png}
\caption{図のキャプション}
\label{fig:example}
\end{figure}

% プログラムコード
\begin{lstlisting}[caption=サンプルコード,label=code:sample]
def hello_world():
    print("Hello, World!")
\end{lstlisting}
```

### 図表の管理

- **図表ファイル**: `figures/` ディレクトリに整理する
- **参照**: すべての図表は `\label` と `\ref` で本文中から参照する

## 🔍 PDF 生成・確認

### VS Code 内での操作

1. ▷ ボタン（Build LaTeX project）をクリック
2. 🔍 ボタン（View LaTeX PDF）でプレビュー

**対象ファイル**:
- **卒業論文**: `sotsuron.tex`（本体）、`gaiyou.tex`（概要）
- **修士論文**: `thesis.tex`（本体）、`abstract.tex`（概要）

## 🆘 困った時は

### 執筆環境の問題

- **PDF が生成されない**: VS Code の「問題」タブで LaTeX のコンパイルエラーを確認する
- **LaTeX Workshop が動かない**: devcontainer 環境で開いているか確認する（VS Code 左下に「Dev Container」と表示される）
- **textlint の指摘が出ない**: ファイルを保存してから「問題」タブを確認する

### その他

- **GitHub Desktop の操作・ブランチ・PR のトラブル**: [GITHUB-DESKTOP-GUIDE.md](https://github.com/smkwlab/latex-ecosystem/blob/main/docs/GITHUB-DESKTOP-GUIDE.md) の「よくある質問」
- **執筆の進め方の疑問**: [STUDENT-WORKFLOW.md](https://github.com/smkwlab/latex-ecosystem/blob/main/docs/STUDENT-WORKFLOW.md) の「よくあるつまずき」
- **概要執筆・提出の疑問**: [WRITING-GUIDE.md](../WRITING-GUIDE.md)
- **解決しない場合**: smkwlabML または担当教員に相談

## 📚 参考資料

- **執筆ワークフロー**: [STUDENT-WORKFLOW ガイド（エコシステム共通）](https://github.com/smkwlab/latex-ecosystem/blob/main/docs/STUDENT-WORKFLOW.md) — 執筆の流れ・レビューの受け方の全体像
<!-- textlint-disable -->
- **LaTeX入門**: [overleaf.com/learn/latex](https://www.overleaf.com/learn/latex)
<!-- textlint-enable -->
- **VS Code LaTeX**: [latex-workshop.github.io](https://github.com/James-Yu/LaTeX-Workshop)
- **textlint**: 日本語校正ツール

## 🎓 論文提出について

教員から「論文提出OK」の許可が出たら、提出版のコミットに `submit` タグを付け、教員の指示で概要（`gaiyou.tex` または `abstract.tex`）の執筆に移ります。最終提出は `final` タグです。

- **手順の詳細**: [WRITING-GUIDE.md の「論文提出」](../WRITING-GUIDE.md#論文提出)
- **提出形式**: 電子版は GitHub リポジトリ（`submit` タグ版）、印刷版は学科規定に従って製本・提出

---

**関連リポジトリ**:
- [student-repo-management](https://github.com/smkwlab/student-repo-management) - 詳細ガイド・教員向けツール

**質問・サポート**: smkwlabML または担当教員まで。
