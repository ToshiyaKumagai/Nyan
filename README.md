# nyan

Henry の病院導入プロセスを支える Claude プラグイン。名前は Jean にちなむ。

- 標準の正本は [donyu-standard](https://github.com/ToshiyaKumagai/donyu-standard)。nyan はその**写し**を `skills/flow-donyu/references/` に持つ（`scripts/sync-standard.sh` で更新。手で直さない）
- 案件データ（議事録・マイルストーンの進捗）は Notion。nyan は読んで、追記して、Slack に知らせる**手**

## 使い方

```
/nyan:progress <案件のプロジェクトページの URL> [--since YYYY-MM-DD] [--dry-run] [--review]
/nyan:notify   [#channel]
```

## 入れ方

```
claude plugin marketplace add ToshiyaKumagai/nyan
claude plugin install nyan@henry-donyu
```

Notion と Slack は claude.ai のコネクタを使う（プラグインに MCP は同梱しない）。

## スキルの3層

| 層 | スキル | 役割 |
| --- | --- | --- |
| フロー | `flow-donyu` | 標準を知る。ツールを呼ばない |
| プロセス | `progress`・`notify` | 業務の手順。利用者が呼ぶのはここだけ |
| ツール | `tool-notion-minutes`・`tool-notion-milestone-db`・`tool-project-sources`・`tool-slack-post` | 外部システムの読み書きの作法。判断をしない |

依存は プロセス → フロー・ツール の一方向だけ。設計の経緯は `docs/design.md`。
