# 下川研卒業論文テンプレート

## 目次
  - [はじめに](#はじめに)
  - [1.基本的な使い方](#1-基本的な使い方)
  - [2.具体的な作業内容](#2-具体的な作業内容)
    - [2.1 自分用のリモートリポジトリの作成](#21-自分用のリモートリポジトリの作成)
    - [2.2 リポジトリをローカルにコピーし、作業用ワーキングディレクトリを作成](#22-リポジトリをローカルにコピーし作業用ワーキングディレクトリを作成)
    - [2.3 LaTeX環境の構築](#23-aldc-によるlatex環境の構築)
    - [2.4 commitとpush](#24-commit-push)
    - [2.5 目次案の記入](#25-目次案の記述)
    - [2.6 第1版用作業ブランチを作成](#26-第1版用作業ブランチを作成)
    - [2.7 編集作業](#27-編集作業)
    - [2.8 添削依頼](#28-添削依頼)
    - [2.9 次版用ブランチ作成](#29-次版用ブランチ作成)
    - [2.10 添削結果待ち](#210-添削結果待ち)
    - [2.11 作業サンプル](#211-作業サンプル)
  - [3.卒論の書き方 (sotsuron.tex の更新)](#3-卒業論文の書き方-sotsurontex-の更新)
    - [3.1 卒業論文としての注意事項](#31-卒業論文としての注意事項)
    - [3.2 日本語的な注意事項](#32-日本語的な注意事項)
    - [3.3 LaTeX的な注意事項](#33-latex的な注意事項)
  - [4. GitHub Actions](#4-github-actions)
    - [4.1 Reviewer割当](#41-reviewer-割当)
    - [4.2 PDF生成](#42-pdf-生成)
  - [5. その他](#5-その他)

## はじめに

これは、九州産業大学 理工学部 情報科学科 下川研究室で利用している卒業論文のテンプレートリポジトリである。
下川研では、卒業論文を作成する標準的な環境として、LaTeX と GitHub を利用する。
文章作成に LaTeX、バージョン管理およびバックアップとして GitHub を使う。

## 1. 基本的な使い方

卒業論文を執筆する上で、論文をバージョン管理していく。
目次案（第0版）、第1版である初版、それに対する添削結果を受けて執筆した改定版、
最終的に、卒論提出締切日に提出する提出版など。

下川研では、これらを第n版として番号で管理し、版毎に Git のブランチを作成する。

**前提条件**: 教員により以下が事前に準備されています
- 個人用リポジトリの作成
  - LaTeX devcontainer 追加済み
- 0th-draft ブランチの作成
- レビュー用PRの設定

学生は以下の手順で論文執筆をすすめる。
これらの具体的な操作手順については[2.具体的な操作手順](#2-具体的な操作手順)で説明する。

1. リポジトリーをPCにクローン
2. **0th-draft ブランチ上で目次案の記述・提出**
3. 第1稿用草稿ブランチ(1st-draft)を作成（0th-draftベース）
   - 今後、草稿ブランチは直前版をベースに作成
4. 草稿ブランチ上でレポートを作成（更新）
5. 添削を依頼するために Pull Request を送信
6. 提出したので、次の草稿ブランチを作成
7. 下川から OK のリプライが来たら終了。NG だった場合は、下川からのリプライにしたがって、5. で作成した**新しい草稿ブランチ**上でレポートを更新(3. に戻る)

## 2. 具体的な操作手順

以下の説明の section の枝番号は 1. の箇条書きの番号と対応している。

### 2.1 リポジトリをローカルにコピーし、ワーキングディレクトリを作成

**前提**: 下川からリポジトリのURLが通知されています

1. 通知されたリポジトリのURLにアクセス
2. `Code` ボタンをクリック
3. `Open with GitHub Desktop` をクリック
4. 自分のPCでリポジトリーを置くディレクトリを確認して `Clone` ボタンをクリック

### 2.2 0th-draft ブランチで目次案の記述

**前提**: 0th-draft ブランチは教員により事前に作成され、クローン時に自動的に選択されています

1. クローン後、GitHub Desktop で `Current Branch` が `0th-draft` になっていることを確認
   - もし `main` になっている場合は `0th-draft` に切り替え
2. おそらく目次案の作成が終わっているはずなので、作成済みの目次案を元に [sotsuron.tex](../sotsuron.tex) を編集し`chapter`, `section`, `subsection` などを記述
3. VSCode 上で ▷ ボタンをクリックすることで sotsuron.pdf を生成
    - ▷の右横の虫眼鏡が右下に描かれたアイコンをクリックしてVSCode 上で PDF をプレビュー
4. GitHub Desktop で commit & push
5. **目次案の添削依頼**: GitHub Desktop で `Create Pull Request` をクリックして、**0th-draft** の Pull Request を作成
   - `Title` に **0th-draft** を記述
   - 目次案の説明や質問があれば `Write` タブに記述

### 2.3 第1稿用草稿ブランチを作成

1. GitHub Desktop で `Current Branch` ボタンをクリック
   - 現在は `0th-draft` が選択されているはず
2. 表示されるメニュー中の`New Branch` ボタンをクリック
3. `Create a Branch`というダイアログが出るので、`Name` を **1st-draft** とする。*第1稿*という意味
4. `Create branch based on...` で **0th-draft** を選択（重要！）
5. `Create Branch` ボタンをクリック
6. `Publish branch` ボタンをクリック
7. `Current Branch` が `1st-draft` に変わったことを確認

### 2.4 草稿編集

1. GitHub Desktop で現在の草稿ブランチが選択されていることを確認して sotsuron.tex を編集
   - `Open in Visual Studio Code` をクリックして Visual Studio Code で操作
   - このとき、Visual Studio Code の左下に、ブランチの名前が表示されている
   - 必要に応じて別のファイル（画像など）を追加したりして良い
2. ファイルを保存する度に `textlint` による自動チェックが起動
   - チェック結果が **VSCode** の **問題** に表示されるので内容を確認し適宜対応
3. VSCode 上で ▷ ボタンをクリックすることで PDF を生成
   - ▷の右横の虫眼鏡が右下に描かれたアイコンをクリックしてVSCode上でプレビュー
4. プレビューに問題ないことを確認したら、GitHub Desktop で commit
5. `Push origin` をクリックして、リモートリポジトリーに Push
6. 1.に戻る

### 2.5 添削依頼

1. sotsuron.pdf を印刷し、その印刷版を読み（可能であれば音読）、推敲。問題があれば、[2.4](#24-編集作業)に戻る
2. GitHub Desktop で `Create Pull Request` をクリックして、**Pull Request** を作成
3. ブラウザが開くので、`Title` に **現在のブランチ名** を記述
   - `Title` はデフォルトでなんらかの文字列が入っているが、それは削除する。
   - **現在のブランチ名** とは、最初であれば `1st-draft` であり、２回めであれば `2nd-draft`になるはず
4. `Write` タブに変更点などを記述
5. `Create pull request` ボタンをクリック

### 2.6 次稿用草稿ブランチ作成

1. GitHub Desktop で `Current Branch` ボタンをクリック
2. `New Branch` ボタンをクリック
3. `Name` を **2nd-draft** など、次の稿であることが分かる名前にする
4. 下の `Create branch based on...` で以下を選択：
   - **1st-draft → 2nd-draft**: `1st-draft` を選択
   - **2nd-draft → 3rd-draft**: `2nd-draft` を選択
   - ※ 第1稿以降は直前の稿をベースとする（差分を明確にするため）
5. `Create branch` ボタンをクリック
6. `Publish branch` ボタンをクリック

**効率的な執筆方法**: 前稿のPR提出後、教員のmerge完了を待たずに次稿の執筆を開始できます。詳細は[2.8](#28-並行執筆時の調整方法)を参照してください。

### 2.7 添削結果待ち

1. 下川からの返事を待つ
2. 返事の内容は、リモートリポジトリの `Pull Requests` タブの中にある
    - そこにも見当たらなければ `1 Closed` のようなリンクをクリックすると見えるはず
    - 見当たらなければ下川に問い合わせる
    - 下川は、添削結果を返信する際に、皆さんの草稿ブランチの内容を main ブランチに反映させる操作(merge) もしている
    - また、レビュー用ブランチ(review-branch)も最新版で更新している
    - したがって、返信が来たときには、リポジトリ上の main ブランチとreview-branchは提出した草稿と同じ内容に更新されている
3. **重要**: 添削コメントは2つのPRで確認してください
    - **各版のPR**: 直前版からの変更点に対するコメント
    - **レビュー用PR**: 論文全体に対するコメント
4. **Suggestionへの対応**（該当する場合）
    - PR画面で「Apply suggestion」をクリックして適用
    - 適用完了後、PR右側「Reviewers」で教員名横の🔄をクリック
    - 「Re-request review」を選択して再レビュー依頼
    - **効率化**: 次稿執筆は並行して開始可能（[2.8](#28-並行執筆時の調整方法)参照）
5. OK ならば提出可能。以下の提出準備をする
    - 提出版の原稿に `submit` というタグを打つ
      - GitHub Desktop の `History` で一番上にある(最新の)履歴を右クリック
      - `Create Tag...` をクリック
      - `Name` に **submit** と入力し `Create Tag` ボタンをクリックしてタグを付与
      - `Push origin` をクリックして、タグを Github にプッシュ
      - 提出準備終了
      - 提出締め切りまでに印刷物を提出するのを忘れない
      - なお、論文提出後は、[概要](../gaiyou.tex)の作成と口頭試問の準備
6. NG ならば現在の草稿上で編集([2.4](#24-草稿編集))に戻る

### 2.8 並行執筆時の調整方法

**待機時間を短縮**: 前稿のPR提出後、教員のmerge完了を待たずに次稿の執筆を開始できます。

#### 基本的な流れ

```
1st-draft PR提出 → すぐに2nd-draft執筆開始
         ↓（並行して）
    教員レビュー・merge完了
         ↓
    2nd-draftを最新版に調整
```

#### 具体的な手順

**1. 次稿執筆の開始**
- [2.6](#26-次稿用草稿ブランチ作成)の手順で次稿ブランチを作成
- 教員のmerge完了を待たずに論文執筆を開始

**2. 教員merge完了後の調整**

教員から「mergeしました」の連絡があったら、以下の手順で最新版を取り込みます：

1. GitHub Desktop で `Current Branch` を `main` に切り替え
   ```
   Current Branch
   main               ← ここを選択
   ```

2. `Fetch origin` ボタンをクリックして最新版を取得
   ```
   [Fetch origin] ← このボタンをクリック
   ```

3. `Current Branch` を執筆中の草稿ブランチ（例：2nd-draft）に戻す
   ```
   Current Branch
   2nd-draft          ← 執筆中の草稿ブランチを選択
   ```

4. `Branch` メニューから `Update from main` をクリック
   ```
   Branch → Update from main
   ```

5. **競合（Conflict）が発生した場合**
   - GitHub Desktop が自動的に競合解決画面を表示
   - 画面の指示に従って競合を手動で解決
   - 解決後、`Continue merge` をクリック

**3. 競合解決の例**

競合が発生すると、以下のような画面が表示されます：

```
Conflicted files:
📄 sotsuron.tex

Choose how you want to resolve this conflict:
⚪ Use changes from main
⚪ Use changes from 2nd-draft  
⚪ Create a merge commit
```

- 通常は `Create a merge commit` を選択
- ファイルを開いて手動で調整
- 調整完了後、GitHub Desktop で commit

#### 注意点

- **suggestionがある場合**: [2.7](#27-添削結果待ち)の手順4に従って適用してから調整
- **競合を避けるコツ**: 同じ箇所を大幅に変更しない
- **不安な場合**: 教員merge完了まで待機しても問題ありません

#### メリット

✅ 待機時間の短縮  
✅ 効率的な論文執筆  
✅ GitHub Desktop のみで完結  

### 2.9 操作例

擬似的に 2.1〜2.7 の操作を[サンプルリポジトリ](https://github.com/smkwlab/toshi-thesis-branch-test)で実施してみた。
ただし、aldc 導入以前に実施したので、aldc に関する履歴はない。
Github 上で、Insights → Network
と選択することで、[ブランチ分岐](https://github.com/smkwlab/toshi-thesis-branch-test/network)を確認できる。

目次案提出までは、main ブランチで執筆。
その後 1st-draft ブランチを作成し、その上で執筆。
1st-draft 提出時に pull request を作成し、toshi0806 に review をリクエスト。
その後 2nd-draft ブランチを作成し、その上で執筆。
添削終了後に pull request を main に merge。
2nd-draft 提出時も pull request を作成し、toshi0806 に review をリクエスト。
その後 3rd-draft ブランチで執筆中。

## 3. 卒業論文の書き方 (sotsuron.tex の更新)

### 3.1 卒業論文としての注意事項

- 提出締め切りを念頭に置いて執筆を進めること

### 3.2 日本語的な注意事項

- である体で書くこと
- 長い文を書かず、適切に文を分割すること
  - 「が」で続けるのは良くない
- 適切な内容で段落を分割すること
- 文の途中に箇条書きを入れないこと
- すべての図や表は本文中で参照すること
- まとめは感想ではない。
  - 今後の課題を除いて、それ以前の本文で記述されていないことを、まとめに書いてはいけない

### 3.3 LaTeX的な注意事項

- 図や表にはキャプションを入れる。入れ方は [example.tex](../example.tex) を参考にすること
- 原則として、1文1行で記述すること
  - 差分が見やすいし、編集指示も出しやすい
- `\\` による改行は `tabular` 環境以外では原則として使用不可

## 4. GitHub actions

このリポジトリには2つの GitHub action が設定されている。

## 4.1 Reviewer 割当

Pull Request を発行すると、[.github/auto_assign_myteams.yml](auto_assign_myteams.yml) に基づき Reviewers を自動で設定する。
デフォルトでは、下川(toshi0806)を指定している。
下川研の学生はこのままで問題ない。
他の研究室の学生が利用する場合には、ここの設定を変更すること。

この機能が不要な場合には auto_assign_myteams.yml を削除する。

## 4.2 PDF 生成

Pull Request を発行すると、sotsuron.tex と gaiyou.tex から PDF を自動生成し、
GitHub 上の [Release](../../../releases/) に配置する。

TeX 環境を持っていない人に PDF を見てもらうのに利用できる。
ただし、ここで作成された Release は一般公開されない。

この機能が不要な場合には [.github/workflows/latex-build.yml](workflows/latex-build.yml) を削除する。

## 5. その他

質問があれば、遠慮なく smkwlabML ML へ。
きっと、他の人も困っている。
疑問と回答はみんなで共有しよう。
