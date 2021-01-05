---
title: 標準ライブラリ
sort: 50
---
<!-- L1..1
# Standard library
-->

# 標準ライブラリ

<!-- L3..4
Deno provides a set of standard modules that are audited by the core team and
are guaranteed to work with Deno.
-->

Deno は標準モジュールを提供しています。標準モジュールはコアチームに審査され、Deno で動作することが保証されています。

<!-- L6..6
Standard library is available at: https://deno.land/std/
-->

標準ライブラリは https://deno.land/std/ で利用可能です。

<!-- L8..8
## Versioning and stability
-->

## バージョニングと安定性

<!-- L10..13
Standard library is not yet stable and therefore it is versioned differently
than Deno. For latest release consult https://deno.land/std/ or
https://deno.land/std/version.ts. The standard library is released each time
Deno is released.
-->

標準ライブラリはまだ stable ではありません。そのため Deno とは異なるバージョニングが行われています。
最新リリースは https://deno.land/std/ か https://deno.land/std/version.ts で確認できます。
標準ライブラリは Deno のリリースに合わせてリリースされます。

<!-- L15..18
We strongly suggest to always use imports with pinned version of standard
library to avoid unintended changes. For example, rather than linking to the
master branch of code, which may change at any time, potentially causing
compilation errors or unexpected behavior:
-->

意図せぬ変更を避けるために標準ライブラリのバージョンを常に固定してインポートすることを強く推奨します。
たとえば、コードの master ブランチにリンクするのは避けてください。master ブランチはいつでも変更される可能性があり、コンパイルエラーや予期せぬ挙動を潜在的に引き起こします。

<!-- L20..23
```typescript
// imports from master, this should be avoided
import { copy } from "https://deno.land/std/fs/copy.ts";
```
-->

```typescript
// master からのインポート。これは避けてください
import { copy } from "https://deno.land/std/fs/copy.ts";
```

<!-- L25..26
instead, used a version of the std library which is immutable and will not
change:
-->

それよりは、std ライブラリの特定のバージョンを使えば、コードが固定されていて変更されません。

<!-- L28..31
```typescript
// imports from v0.50.0 of std, never changes
import { copy } from "https://deno.land/std@$STD_VERSION/fs/copy.ts";
```
-->

```typescript
// imports from v0.50.0 of std, never changes
import { copy } from "https://deno.land/std@$STD_VERSION/fs/copy.ts";
```

<!-- L33..33
## Troubleshooting
-->

## トラブルシューティング

<!-- L35..35
Some of the modules provided in standard library use unstable Deno APIs.
-->

標準ライブラリの提供するいつくかのモジュールは Deno の unstable な API を使用しています。

<!-- L37..39
Trying to run such modules without `--unstable` CLI flag ends up with a lot of
TypeScript errors suggesting that some APIs in the `Deno` namespace do not
exist:
-->

そういったモジュールを CLI の `--unstable` フラグ抜きで実行すると、`Deno` 名前空間に API が存在しないことを知らせる TypeScript エラーがいくつも発生して終了します。

<!-- L41..46
```typescript
// main.ts
import { copy } from "https://deno.land/std@$STD_VERSION/fs/copy.ts";

copy("log.txt", "log-old.txt");
```
-->

```typescript
// main.ts
import { copy } from "https://deno.land/std@$STD_VERSION/fs/copy.ts";

copy("log.txt", "log-old.txt");
```

<!-- L48..63
```shell
$ deno run --allow-read --allow-write main.ts
Compile file:///dev/deno/main.ts
Download https://deno.land/std@$STD_VERSION/fs/copy.ts
Download https://deno.land/std@$STD_VERSION/fs/ensure_dir.ts
Download https://deno.land/std@$STD_VERSION/fs/_util.ts
error: TS2339 [ERROR]: Property 'utime' does not exist on type 'typeof Deno'.
    await Deno.utime(dest, statInfo.atime, statInfo.mtime);
               ~~~~~
    at https://deno.land/std@$STD_VERSION/fs/copy.ts:90:16

TS2339 [ERROR]: Property 'utimeSync' does not exist on type 'typeof Deno'.
    Deno.utimeSync(dest, statInfo.atime, statInfo.mtime);
         ~~~~~~~~~
    at https://deno.land/std@$STD_VERSION/fs/copy.ts:101:10
```
-->

```shell
$ deno run --allow-read --allow-write main.ts
Compile file:///dev/deno/main.ts
Download https://deno.land/std@$STD_VERSION/fs/copy.ts
Download https://deno.land/std@$STD_VERSION/fs/ensure_dir.ts
Download https://deno.land/std@$STD_VERSION/fs/_util.ts
error: TS2339 [ERROR]: Property 'utime' does not exist on type 'typeof Deno'.
    await Deno.utime(dest, statInfo.atime, statInfo.mtime);
               ~~~~~
    at https://deno.land/std@$STD_VERSION/fs/copy.ts:90:16

TS2339 [ERROR]: Property 'utimeSync' does not exist on type 'typeof Deno'.
    Deno.utimeSync(dest, statInfo.atime, statInfo.mtime);
         ~~~~~~~~~
    at https://deno.land/std@$STD_VERSION/fs/copy.ts:101:10
```

<!-- L65..65
Solution to that problem requires adding `--unstable` flag:
-->

この問題を解決するには `--unstable` フラグを付与する必要があります。

<!-- L67..69
```shell
deno run --allow-read --allow-write --unstable main.ts
```
-->

```shell
deno run --allow-read --allow-write --unstable main.ts
```

<!-- L71..73
To make sure that API producing error is unstable check
[`lib.deno.unstable.d.ts`](https://github.com/denoland/deno/blob/master/cli/dts/lib.deno.unstable.d.ts)
declaration.
-->

API から生じるエラーの原因が unstable であるかどうかを確かめるには、
[`lib.deno.unstable.d.ts`](https://github.com/denoland/deno/blob/master/cli/dts/lib.deno.unstable.d.ts)
宣言ファイルを確認してください。

<!-- L75..76
This problem should be fixed in the near future. Feel free to omit the flag if
the particular modules you depend on compile successfully without it.
-->

この問題は近い将来に修正されるはずです。依存している特定のモジュールがこのフラグなしでコンパイルできるなら、遠慮なくフラグを省略して構いません。
