# 論文テンプレート

九州産業大学理工学部情報科学科の卒業論文・九州産業大学大学院情報科学研究科の修士論文用 LaTeX テンプレートです。

## 🎯 学生向けクイックスタート

### 1. リポジトリの作成

**前提条件**: Docker Desktop と GitHub Desktop がインストール済み

**ワンライナーでリポジトリを作成**：
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/smkwlab/thesis-management-tools/main/create-repo/setup.sh)"
```

**実行手順**：
1. 上記コマンドを実行
2. GitHub認証：ワンタイムコードをブラウザで入力
3. 学籍番号を入力
4. 自動でリポジトリ作成・セットアップ完了

### 2. 論文執筆の開始

作成されたリポジトリで執筆を開始：

1. **GitHub Desktop でリポジトリをクローン**
   - 作成されたリポジトリのURLにアクセス
   - `Code` → `Open with GitHub Desktop` をクリック

2. **VS Code で開く**
   - GitHub Desktop で `Open in Visual Studio Code` をクリック
   - LaTeX Workshop 拡張機能が自動的に利用可能

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

**重要**: PRは添削用のみです。教員はPRをマージしません。添削対応完了後は**自分でPRをクローズ**します。

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

リポジトリには **devcontainer** が設定済みです：

- VS Code で開くと自動的に LaTeX 環境が利用可能
- LaTeX Workshop 拡張機能
- textlint による日本語校正
- 必要なパッケージ類

### 手動設定

独自環境を使用する場合：

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

### VS Code 内

1. ▷ ボタン（Build LaTeX project）をクリック
2. 🔍 ボタン（View LaTeX PDF）でプレビュー

### コマンド

#### 卒業論文
```bash
# PDF 生成
latexmk -pv sotsuron.tex

# 概要生成
latexmk -pv gaiyou.tex
```

#### 修士論文
```bash
# PDF 生成
latexmk -pv thesis.tex

# 概要生成
latexmk -pv abstract.tex
```

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

- **LaTeX入門**: [overleaf.com/learn/latex](https://www.overleaf.com/learn/latex)
- **VS Code LaTeX**: [latex-workshop.github.io](https://github.com/James-Yu/LaTeX-Workshop)
- **textlint**: 日本語校正ツール

## 🎓 提出について

### 最終提出時

1. 最終稿のPRを教員が承認
2. 自分で最終稿PRをクローズ
3. 教員からOKが出たら `submit` タグを作成
4. 印刷版も忘れずに提出

### 提出形式

- **電子版**: GitHub リポジトリ
- **印刷版**: 学科規定に従って製本・提出

---

**関連リポジトリ**:
- [thesis-management-tools](https://github.com/smkwlab/thesis-management-tools) - 詳細ガイド・教員向けツール

**質問・サポート**: smkwlabML または担当教員まで