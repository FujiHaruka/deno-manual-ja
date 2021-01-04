---
title: ランタイム
sort: 30
---
<!-- L1..1
# Runtime
-->

# ランタイム

<!-- L3..5
Documentation for all runtime functions (Web APIs + `Deno` global) can be found
on
[`doc.deno.land`](https://doc.deno.land/https/github.com/denoland/deno/releases/latest/download/lib.deno.d.ts).
-->

ランタイムの全関数（Web API + `Deno` グローバル変数）に関するドキュメントは [`doc.deno.land`](https://doc.deno.land/https/github.com/denoland/deno/releases/latest/download/lib.deno.d.ts) にあります。

<!-- L7..7
## Web APIs
-->

## Web API

<!-- L9..10
For APIs where a web standard already exists, like `fetch` for HTTP requests,
Deno uses these rather than inventing a new proprietary API.
-->

HTTP リクエストを送る `fetch` のように既存の Web の標準がある API に関しては、
Deno はプロプライエタリな API を新しく発明するのではなく既存の標準を使用します。

<!-- L12..16
The detailed documentation for implemented Web APIs can be found on
[doc.deno.land](https://doc.deno.land/https/raw.githubusercontent.com/denoland/deno/master/cli/dts/lib.deno.shared_globals.d.ts).
Additionally, a full list of the Web APIs which Deno implements is also
available
[in the repository](https://github.com/denoland/deno/blob/master/cli/rt/README.md).
-->

実装済みの Web API に関する詳しいドキュメントは [doc.deno.land](https://doc.deno.land/https/raw.githubusercontent.com/denoland/deno/master/cli/dts/lib.deno.shared_globals.d.ts) にあります。
また、Deno で実装されている Web API の完全な一覧は[このリポジトリ](https://github.com/denoland/deno/blob/master/cli/rt/README.md)にもあります。

<!-- L18..22
The TypeScript definitions for the implemented web APIs can be found in the
[`lib.deno.shared_globals.d.ts`](https://github.com/denoland/deno/blob/master/cli/dts/lib.deno.shared_globals.d.ts)
and
[`lib.deno.window.d.ts`](https://github.com/denoland/deno/blob/master/cli/dts/lib.deno.window.d.ts)
files.
-->

実装済みの Web API の TypeScript 型定義は
[`lib.deno.shared_globals.d.ts`](https://github.com/denoland/deno/blob/master/cli/dts/lib.deno.shared_globals.d.ts)
と
[`lib.deno.window.d.ts`](https://github.com/denoland/deno/blob/master/cli/dts/lib.deno.window.d.ts)
ファイルで確認できます。

<!-- L24..26
Definitions that are specific to workers can be found in the
[`lib.deno.worker.d.ts`](https://github.com/denoland/deno/blob/master/cli/dts/lib.deno.worker.d.ts)
file.
-->

worker に関する型定義は
[`lib.deno.worker.d.ts`](https://github.com/denoland/deno/blob/master/cli/dts/lib.deno.worker.d.ts)
ファイルにあります。

<!-- L28..28
## `Deno` global
-->

## `Deno` グローバル変数

<!-- L30..32
All APIs that are not web standard are contained in the global `Deno` namespace.
It has the APIs for reading from files, opening TCP sockets, and executing
subprocesses, etc.
-->

Web 標準にない API はすべて、グローバルな `Deno` 名前空間に含まれています。
ファイルの読み書き、TCP ソケットの開閉、サブプロセスの実行などのための API がそろっています。

<!-- L34..36
The TypeScript definitions for the Deno namespaces can be found in the
[`lib.deno.ns.d.ts`](https://github.com/denoland/deno/blob/master/cli/dts/lib.deno.ns.d.ts)
file.
-->

Deno 名前空間の TypeScript 型定義は
[`lib.deno.ns.d.ts`](https://github.com/denoland/deno/blob/master/cli/dts/lib.deno.ns.d.ts)
ファイルにて確認できます。

<!-- L38..39
The documentation for all of the Deno specific APIs can be found on
[doc.deno.land](https://doc.deno.land/https/raw.githubusercontent.com/denoland/deno/master/cli/dts/lib.deno.ns.d.ts).
-->

Deno 特有の API に関するドキュメントは
[doc.deno.land](https://doc.deno.land/https/raw.githubusercontent.com/denoland/deno/master/cli/dts/lib.deno.ns.d.ts)
にあります。
