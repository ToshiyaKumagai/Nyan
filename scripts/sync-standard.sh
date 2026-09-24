#!/usr/bin/env bash
# donyu-standard の写しを skills/flow-donyu/references/ に取り込む。
# 使い方: scripts/sync-standard.sh /path/to/donyu-standard
set -euo pipefail
SRC="${1:?donyu-standard のパスを渡す}"
DST="$(cd "$(dirname "$0")/.." && pwd)/skills/flow-donyu/references"

rm -rf "$DST/cards"
mkdir -p "$DST/cards"
cp "$SRC"/02_milestones/cards/*.md "$DST/cards/"
cp "$SRC"/02_milestones/10_map.md "$DST/map.md"

# 判定の向き：00_format.md 3章「保守的に書く」＋ 19_dependencies.md 1〜3章
{
  echo "# 判定の読み方（donyu-standard からの写し。手で直さない）"
  echo
  awk '/^## 3\. 保守的に書く/,/^## 4\./' "$SRC/02_milestones/00_format.md" | sed '$d'
  echo
  awk '/^## 1\. 判定の向き/,/^## 4\./' "$SRC/02_milestones/19_dependencies.md" | sed '$d'
} > "$DST/judgment.md"

# 節目の指し方：00_format.md 2章「他の節目の指し方」
{
  echo "# 節目の指し方（donyu-standard からの写し。手で直さない）"
  echo
  awk '/^### 他の節目の指し方/,/^### 対象外・未定/' "$SRC/02_milestones/00_format.md" | sed '$d'
} > "$DST/naming.md"

# 受け皿：03_catalog/00_format.md 3章「意思決定主体と決定の場」
{
  echo "# 意思決定主体と決定の場（donyu-standard からの写し。手で直さない）"
  echo
  awk '/^## 3\. 意思決定主体と決定の場/,/^## 4\./' "$SRC/03_catalog/00_format.md" | sed '$d'
} > "$DST/forums.md"

HASH="$(git -C "$SRC" rev-parse --short HEAD)"
DATE="$(git -C "$SRC" log -1 --format=%cs)"
printf 'source: ToshiyaKumagai/donyu-standard\ncommit: %s\ncommitted: %s\nsynced: %s\n' "$HASH" "$DATE" "$(date +%F)" > "$DST/VERSION"
echo "synced donyu-standard@$HASH -> $DST"
