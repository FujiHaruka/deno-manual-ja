---
title: 安定性
sort: 1
---
<!-- L1..1
## Stability
-->

## 安定性

<!-- L3..4
As of Deno 1.0.0, the `Deno` namespace APIs are stable. That means we will
strive to make code working under 1.0.0 continue to work in future versions.
-->

Deno 1.0.0 から `Deno` 名前空間の API は stable になりました。その意味するところは、
1.0.0 で動作するコードが将来のバージョンでも動き続けるように私たちは努力するということです。

<!-- L6..8
However, not all of Deno's features are ready for production yet. Features which
are not ready, because they are still in draft phase, are locked behind the
`--unstable` command line flag.
-->

けれども、Deno のすべての機能について本番環境で使う準備が整っているわけではありません。準備が整っていない機能はまだドラフト段階にあるため
`--unstable` コマンドラインフラグでロックされています。

<!-- L10..12
```shell
deno run --unstable mod_which_uses_unstable_stuff.ts
```
-->

```shell
deno run --unstable mod_which_uses_unstable_stuff.ts
```

<!-- L14..14
Passing this flag does a few things:
-->

このフラグを渡すといくつかのことが行われます。

<!-- L16..20
- It enables the use of unstable APIs during runtime.
- It adds the
  [`lib.deno.unstable.d.ts`](https://doc.deno.land/https/raw.githubusercontent.com/denoland/deno/master/cli/dts/lib.deno.unstable.d.ts)
  file to the list of TypeScript definitions that are used for type checking.
  This includes the output of `deno types`.
-->

- 実行時に unstable な API を使えるようにします
- [`lib.deno.unstable.d.ts`](https://doc.deno.land/https/raw.githubusercontent.com/denoland/deno/master/cli/dts/lib.deno.unstable.d.ts)
  ファイルを TypeScript 定義のリストに追加し、型定義に使用します。
  これは `deno types` の出力を含みます。

<!-- L22..24
You should be aware that many unstable APIs have **not undergone a security
review**, are likely to have **breaking API changes** in the future, and are
**not ready for production**.
-->

unstable な API に関する留意点ですが、その多くは**セキュリティレビューを通過していません**し、
**API の破壊的変更**が将来行われるかもしれませんし、**本番環境で使用する準備が整っていません**。

<!-- L26..26
### Standard modules
-->

### 標準モジュール

<!-- L28..32
Deno's standard modules (https://deno.land/std/) are not yet stable. We
currently version the standard modules differently from the CLI to reflect this.
Note that unlike the `Deno` namespace, the use of the standard modules do not
require the `--unstable` flag (unless the standard module itself makes use of an
unstable Deno feature).
-->

Deno の標準モジュール (https://deno.land/std/) はまだ stable ではありません。
そのことを反映するために標準モジュールは CLI と別にバージョン付けしています。
`Deno` 名前空間と違って標準モジュールの使用に `--unstable` フラグは不要であることに留意してください（標準モジュール自体が unstable な Deno の機能を使用している場合は必要です）。
