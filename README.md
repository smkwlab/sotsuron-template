# 論文テンプレート

九州産業大学理工学部情報科学科の卒業論文・九州産業大学大学院情報科学研究科の修士論文用 LaTeX テンプレートを提供する。
VS Code devContainer を用いて、LaTeX 処理系、および textlint を内包している。

## 🎯 学生向けクイックスタート

### 1. リポジトリの作成

**前提条件**: Docker Desktop と GitHub Desktop がインストール済み。

**スクリプトでリポジトリを作成**：
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/smkwlab/thesis-management-tools/main/create-repo/setup.sh)"
```

**実行手順**：
1. 上記コマンドを実行
2. GitHub認証：ワンタイムコードをブラウザで入力
3. 学籍番号を入力
4. 自動でリポジトリ作成・セットアップ完了

### 2. 論文執筆の開始

作成されたリポジトリで執筆を開始する。
下川研以外の学生は、以下の手順2以降で自由に論文を執筆する。「3. Pull Request による添削システム」で説明している `0th-draftブランチ`は存在しないため無視すること。
下川研の学生は、手順3以降のルールにしたがって執筆すること。

1. **GitHub Desktop でリポジトリをクローン**
   - 作成されたリポジトリのURLにアクセス
   - `Code` → `Open with GitHub Desktop` をクリック

2. **VS Code で開く**
   - GitHub Desktop で `Open in Visual Studio Code` をクリック
   - LaTeX Workshop 拡張機能が自動的に利用可能

3. **0th-draft ブランチに切り替え**
   - GitHub Desktop で `Current Branch` → `0th-draft` を選択
   - 以降も、提出後は自動で作成されるブランチ（1st-draft等）を選択

### 3. 論文執筆の流れ

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

**重要**: PRは教員による添削・フィードバック用です。レビューへの対応完了後は**自分でPRをクローズ**し、次の執筆を続けること。

### 4. 詳細な操作手順

**詳細な執筆ガイド**: [WRITING-GUIDE.md](WRITING-GUIDE.md)
- GitHub Desktop の詳細操作
- トラブルシューティング
- よくある質問・対処法
- 高度な使い方

**教員向けツール**: [thesis-management-tools](https://github.com/smkwlab/thesis-management-tools)

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

## ✅ 基本的な執筆手順

### 1. 目次案作成（0th-draft）

1. `sotsuron.tex` を編集
2. 章・節の構成を記述（内容は未記入でOK）
3. commit & push
4. GitHub で Pull Request 作成

### 2. 第1稿執筆（1st-draft）

1. 自動作成された `1st-draft` ブランチに切り替え
2. `sotsuron.tex` に内容を記述
3. 定期的に commit & push
4. 完成したら Pull Request 作成

### 3. 添削対応とPRのクローズ

1. **教員の添削確認**
   - GitHub で教員からのコメントを確認
   - 必要に応じて修正・追記

2. **PRのクローズ**
   ```
   添削対応完了後:
   1. GitHub Web で該当PRページにアクセス
   2. 「Close pull request」ボタンをクリック
   3. 次稿執筆へ進む
   ```

3. **次稿執筆**
   - 各稿のPR作成時に次稿ブランチが自動作成済み
   - 前稿のPRクローズと並行して次稿執筆可能

## 📝 執筆時の注意

### LaTeX 記述

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

### ファイル管理

- **図表**: `figures/` ディレクトリに整理
- **コミット**: こまめに実行（1日1回以上）
- **バックアップ**: GitHub に push することでバックアップ完了

### 印刷推敲

- **必須**: 画面だけでなく印刷して確認
- **推奨**: 章ごとに印刷推敲を実施

## 🔍 PDF 生成・確認

### VS Code 内での操作

1. ▷ ボタン（Build LaTeX project）をクリック
2. 🔍 ボタン（View LaTeX PDF）でプレビュー

**対象ファイル**:
- **卒業論文**: `sotsuron.tex`（本体）、`gaiyou.tex`（概要）
- **修士論文**: `thesis.tex`（本体）、`abstract.tex`（概要）

## 🆘 困った時は

### よくある問題

#### 1. PDF が生成されない
- LaTeX コンパイルエラーを確認
- VS Code の「問題」タブでエラー内容を確認

#### 2. GitHub Desktop で同期できない
- インターネット接続を確認
- GitHub の認証状態を確認

#### 3. ブランチの切り替えができない
- 変更内容を commit してからブランチ切り替え

#### 4. PRをいつクローズすべきか分からない
- 教員の添削を確認し、対応が完了したタイミング
- 次稿執筆前にクローズする必要はなし（並行作業可能）

### サポート

1. **詳細ガイド**: [WRITING-GUIDE.md](WRITING-GUIDE.md)
2. **質問**: smkwlabML で質問共有
3. **トラブル**: 教員に直接相談

## 📚 参考資料

<!-- textlint-disable -->
- **LaTeX入門**: [overleaf.com/learn/latex](https://www.overleaf.com/learn/latex)
<!-- textlint-enable -->
- **VS Code LaTeX**: [latex-workshop.github.io](https://github.com/James-Yu/LaTeX-Workshop)
- **textlint**: 日本語校正ツール

## 🎓 論文提出について

### 論文提出許可時

教員から「論文提出OK」の許可が出たら以下を実行する。

1. **提出版にタグを付与**
   
   GitHub Desktop で：
   - `History` で最新コミットを右クリック
   - `Create Tag...` をクリック
   - `Name` に **submit** と入力
   - `Create Tag` → `Push origin`

2. **概要執筆の開始**
   - 教員の指示に従って概要 (`gaiyou.tex` または `abstract.tex`) の執筆を開始
   - `abstract-1st` ブランチから開始（詳細は [WRITING-GUIDE.md](WRITING-GUIDE.md) 参照）

### 提出形式

- **電子版**: GitHub リポジトリ（submit タグ版）
- **印刷版**: 学科規定に従って製本・提出

### 注意点

- **submit タグ**: 論文本体の提出版をマーク
- **概要執筆**: submit タグ後、教員指示で概要執筆開始
- **以降の手順**: 概要完成後の手順は教員から口頭で説明される

---

**関連リポジトリ**:
- [thesis-management-tools](https://github.com/smkwlab/thesis-management-tools) - 詳細ガイド・教員向けツール

**質問・サポート**: smkwlabML または担当教員まで。
