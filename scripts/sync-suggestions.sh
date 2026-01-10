#!/bin/bash
# scripts/sync-suggestions.sh
#
# 前のドラフトブランチから教員の Suggest を取り込むスクリプト
#
# Usage:
#   ./scripts/sync-suggestions.sh              # 現在のブランチに対して自動判定
#   ./scripts/sync-suggestions.sh 2nd-draft    # 指定ブランチに対して実行

set -e

# 引数があればそれを使用、なければ現在のブランチ
if [ -n "$1" ]; then
    CURRENT_BRANCH="$1"
    git checkout "$CURRENT_BRANCH"
else
    CURRENT_BRANCH=$(git branch --show-current)
fi

echo "現在のブランチ: $CURRENT_BRANCH"

# 現在のブランチから前のドラフトを自動判定
if [[ "$CURRENT_BRANCH" =~ ^([0-9]+)(st|nd|rd|th)-draft$ ]]; then
    # 論文本体 (例: 2nd-draft → 1st-draft)
    CURRENT_NUM="${BASH_REMATCH[1]}"

    if [ "$CURRENT_NUM" -eq 1 ]; then
        # 1st-draft の場合は main から
        PREV_BRANCH="main"
    else
        PREV_NUM=$((CURRENT_NUM - 1))
        case $PREV_NUM in
            1) SUFFIX="st" ;;
            2) SUFFIX="nd" ;;
            3) SUFFIX="rd" ;;
            *) SUFFIX="th" ;;
        esac
        PREV_BRANCH="${PREV_NUM}${SUFFIX}-draft"
    fi

elif [[ "$CURRENT_BRANCH" =~ ^abstract-([0-9]+)(st|nd|rd|th)$ ]]; then
    # 概要 (例: abstract-2nd → abstract-1st)
    CURRENT_NUM="${BASH_REMATCH[1]}"

    if [ "$CURRENT_NUM" -eq 1 ]; then
        echo "Error: abstract-1st には前のブランチがありません"
        exit 1
    else
        PREV_NUM=$((CURRENT_NUM - 1))
        case $PREV_NUM in
            1) SUFFIX="st" ;;
            2) SUFFIX="nd" ;;
            3) SUFFIX="rd" ;;
            *) SUFFIX="th" ;;
        esac
        PREV_BRANCH="abstract-${PREV_NUM}${SUFFIX}"
    fi

else
    echo "Error: draft または abstract ブランチではありません: $CURRENT_BRANCH"
    exit 1
fi

echo "前のドラフト: $PREV_BRANCH"
echo ""

# リモートから最新を取得
echo "🔄 リモートから最新の変更を取得中..."
git fetch origin "$PREV_BRANCH"
git fetch origin "$CURRENT_BRANCH"

# マージ実行
echo "🔀 $PREV_BRANCH からの変更を $CURRENT_BRANCH にマージ中..."
git merge "origin/$PREV_BRANCH" --no-ff -m "Merge suggestions from $PREV_BRANCH"

echo ""
echo "✅ 完了: $PREV_BRANCH からの Suggest を $CURRENT_BRANCH に取り込みました"
echo ""
echo "次のステップ:"
echo "  git push origin $CURRENT_BRANCH"
