---
title: モジュールのリロード
sort: 1
---
<!-- L1..1
## Reloading modules
-->

## モジュールのリロード

<!-- L3..7
By default, a module in the cache will be reused without fetching or
re-compiling it. Sometimes this is not desirable and you can force deno to
refetch and recompile modules into the cache. You can invalidate your local
`DENO_DIR` cache using the `--reload` flag of the `deno cache` subcommand. It's
usage is described below:
-->

デフォルトでは、キャッシュされたモジュールは再取得・再コンパイルなしで再利用されます。
場合によってはこの振る舞いは望ましくなく、Deno に強制的にモジュールを再取得・再コンパイルさせたいことがあります。
ローカルの `DENO_DIR` にあるキャッシュは `deno cache` サブコマンドの `--reload` フラグを使うと無効化できます。
使い方は以下に述べる通りです。

<!-- L9..9
### To reload everything
-->

### 全部をリロードする

<!-- L11..13
```ts
deno cache --reload my_module.ts
```
-->

```
deno cache --reload my_module.ts
```

<!-- L15..15
### To reload specific modules
-->

### リロードするモジュールを指定する

<!-- L17..18
Sometimes we want to upgrade only some modules. You can control it by passing an
argument to a `--reload` flag.
-->

特定のモジュールだけを更新したい場合もあります。`--reload` フラグに引数を与えると更新対象を制限できます。

<!-- L20..20
To reload all \$STD_VERSION standard modules
-->

\$STD_VERSION の標準モジュールをすべてリロードするには、以下のコマンドを実行します。

<!-- L22..24
```ts
deno cache --reload=https://deno.land/std@$STD_VERSION my_module.ts
```
-->

```ts
deno cache --reload=https://deno.land/std@$STD_VERSION my_module.ts
```

<!-- L26..27
To reload specific modules (in this example - colors and file system copy) use a
comma to separate URLs
-->

リロードするモジュールを指定するには（以下の例では colors と copy）コンマで URL を区切ります。

<!-- L29..31
```ts
deno cache --reload=https://deno.land/std@$STD_VERSION/fs/copy.ts,https://deno.land/std@$STD_VERSION/fmt/colors.ts my_module.ts
```
-->

```ts
deno cache --reload=https://deno.land/std@$STD_VERSION/fs/copy.ts,https://deno.land/std@$STD_VERSION/fmt/colors.ts my_module.ts
```
