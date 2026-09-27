# nyan

Henry の病院導入プロセスを支える Claude プラグイン。名前は Jean にちなむ。

- 標準の正本は [donyu-standard](https://github.com/ToshiyaKumagai/donyu-standard)。nyan はその**写し**を `skills/flow-donyu/references/` に持つ（`scripts/sync-standard.sh` で更新。手で直さない）
- 案件データは Notion の3本の横断DB（導入議事録DB・導入マイルストーンDB・導入週次レビューDB。置き場は「導入マスタ・テンプレート置き場」）。案件ページ（PTS Project の1ページ）の子ページにはリンクドビューがあるだけで、nyan は案件ページの ID で原本DBを絞って読み書きする。nyan は読んで、書いて、Slack に知らせる**手**

## 使い方

```
/nyan:progress <案件ページの URL> [--since YYYY-MM-DD] [--dry-run] [--review]
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
| ツール | `tool-notion-minutes`・`tool-notion-milestone-db`・`tool-notion-weekly-review`・`tool-project-sources`・`tool-slack-post` | 外部システムの読み書きの作法。判断をしない |

依存は プロセス → フロー・ツール の一方向だけ。設計は `docs/design.md`。
