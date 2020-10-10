---
title: コマンドラインインターフェイス
sort: 4
---
<!-- L1..1
## Command line interface
-->

## コマンドラインインターフェイス

<!-- L3..5
Deno is a command line program. You should be familiar with some simple commands
having followed the examples thus far and already understand the basics of shell
usage.
-->

Deno はコマンドラインプログラムです。ここまでの例で、簡単なコマンドをいくつか知っているはずですし、シェルの基本的な使い方も理解しているはずです。

<!-- L7..7
There are multiple ways of viewing the main help text:
-->

主なヘルプテキストを表示する方法は複数あります。

<!-- L9..18
```shell
# Using the subcommand.
deno help

# Using the short flag -- outputs the same as above.
deno -h

# Using the long flag -- outputs more detailed help text where available.
deno --help
```
-->

```shell
# サブコマンドを使う
deno help

# ショートフラグを使う -- 上と同じ出力になる
deno -h

# ロングフラグを使う -- 利用可能ならより詳細なヘルプテキストが表示される
deno --help
```

<!-- L20..22
Deno's CLI is subcommand-based. The above commands should show you a list of
those supported, such as `deno bundle`. To see subcommand-specific help for
`bundle`, you can similarly run one of:
-->

Deno の CLI はサブコマンドが基本です。上のコマンドは、`deno bundle` のようにサポートされているサブコマンドの一覧を表示します。
特定のサブコマンドのヘルプを確認するやり方も同様で、たとえば `bundle` なら次のどれかを実行します。

<!-- L24..28
```shell
deno help bundle
deno bundle -h
deno bundle --help
```
-->

```shell
deno help bundle
deno bundle -h
deno bundle --help
```

<!-- L30..30
Detailed guides to each subcommand can be found [here](../tools.md).
-->

各サブコマンドの詳細なガイドは[ここ](../tools.md)にあります。

<!-- L32..32
### Script source
-->

### スクリプトのソース

<!-- L34..36
Deno can grab the scripts from multiple sources, a filename, a url, and '-' to
read the file from stdin. The last is useful for integration with other
applications.
-->

Deno は複数のソースからスクリプトを取得できます。ファイル名、URL、そして標準入力からファイルを読む場合は `-` が使えます。
これは他のアプリケーションと統合するときに役立ちます。

<!-- L38..42
```shell
deno run main.ts
deno run https://mydomain.com/main.ts
cat main.ts | deno run -
```
-->

```shell
deno run main.ts
deno run https://mydomain.com/main.ts
cat main.ts | deno run -
```

<!-- L44..44
### Script arguments
-->

### スクリプトの引数

<!-- L46..47
Separately from the Deno runtime flags, you can pass user-space arguments to the
script you are running by specifying them after the script name:
-->

Deno のランタイムフラグとは別に、ユーザー空間の引数をスクリプトに渡すことができます。そのためにはスクリプトの実行時にスクリプト名の後ろに引数を書きます。

<!-- L49..51
```shell
deno run main.ts a b -c --quiet
```
-->

```shell
deno run main.ts a b -c --quiet
```

<!-- L53..56
```ts
// main.ts
console.log(Deno.args); // [ "a", "b", "-c", "--quiet" ]
```
-->

```ts
// main.ts
console.log(Deno.args); // [ "a", "b", "-c", "--quiet" ]
```

<!-- L58..60
**Note that anything passed after the script name will be passed as a script
argument and not consumed as a Deno runtime flag.** This leads to the following
pitfall:
-->

**Note that anything passed after the script name will be passed as a script
argument and not consumed as a Deno runtime flag.** This leads to the following
pitfall:
**注意: スクリプト名の後に渡される文字列は何でもスクリプトの引数として解釈され、Deno ランタイムのフラグとして解釈されません。**
そのため、以下のような落とし穴があります。

<!-- L62..68
```shell
# Good. We grant net permission to net_client.ts.
deno run --allow-net net_client.ts

# Bad! --allow-net was passed to Deno.args, throws a net permission error.
deno run net_client.ts --allow-net
```
-->

```shell
# 正しい。net_client.ts にネットワークの許可を与えます。
deno run --allow-net net_client.ts

# 間違い！ --allow-net は Deno.args に渡されます。ネットワークのパーミッションエラーが投げられます。
deno run net_client.ts --allow-net
```

<!-- L70..70
Some see it as unconventional that:
-->

これは次の慣例に従っていないと思う人もいるでしょう。

<!-- L72..72
> a non-positional flag is parsed differently depending on its position.
-->

> 位置に関係ないはずのフラグが位置によって異なる解釈になる。

<!-- L74..74
However:
-->

けれども、

<!-- L76..83
1. This is the most logical way of distinguishing between runtime flags and
   script arguments.
2. This is the most ergonomic way of distinguishing between runtime flags and
   script arguments.
3. This is, in fact, the same behaviour as that of any other popular runtime.
   - Try `node -c index.js` and `node index.js -c`. The first will only do a
     syntax check on `index.js` as per Node's `-c` flag. The second will
     _execute_ `index.js` with `-c` passed to `require("process").argv`.
-->

1. これがランタイムフラグとスクリプトの引数を区別する最も合理的な方法です
2. これがランタイムフラグとスクリプトの引数を区別する最も人間工学的な方法です
3. This is, in fact, the same behaviour as that of any other popular runtime.
   - Try `node -c index.js` and `node index.js -c`. The first will only do a
     syntax check on `index.js` as per Node's `-c` flag. The second will
     _execute_ `index.js` with `-c` passed to `require("process").argv`.
3. 実際にこれは他の有名なランタイムの挙動と同じです
   - `node -c index.js` と `node index.js -c` を実行してみてください。
      一番目のコマンドは Node の `-c` フラグと解釈されて `index.js` の構文チェックのみを行います。
      二番目のコマンドは `index.js` を*実行し*、`require("process").argv` に `-c` を渡します


<!-- L85..85
---
-->

---

<!-- L87..88
There exist logical groups of flags that are shared between related subcommands.
We discuss these below.
-->

フラグはいくつか論理的なグループに分けられ、関連するサブコマンドの間で共有されています。
次の項で説明します。

<!-- L90..90
### Watch mode
-->

### watch モード

<!-- L92..95
You can supply the `--watch` flag to `deno run` to enable the built in file
watcher. When Deno starts up with this flag it watches the entrypoint, and all
local files the entrypoint statically imports. Whenever one of these files is
changed on disk, the program will automatically be restarted.
-->

`--watch` フラグを `deno run` に与えると組み込みのファイルウォッチャーが有効になります。
このフラグ付きで Deno を起動すると、エントリーポイントとそこから静的にインポートされるすべてのローカルファイルをウォッチします。
ディスク上でこれらのファイルの一つでも変更されると、プログラムは自動的に再起動します。

<!-- L97..97
### Integrity flags
-->

### integrity フラグ

<!-- L99..100
Affect commands which can download resources to the cache: `deno cache`,
`deno run` and `deno test`.
-->

リソースをダウンロードしてキャッシュに保存できるコマンドに影響を与えます。
たとえば `deno cache`、`deno run`、`deno test` です。

<!-- L102..105
```
--lock <FILE>    Check the specified lock file
--lock-write     Write lock file. Use with --lock.
```
-->

```
--lock <FILE>    Check the specified lock file
--lock-write     Write lock file. Use with --lock.
```

<!-- L107..108
Find out more about these
[here](../linking_to_external_code/integrity_checking.md).
-->

詳細は[ここ](../linking_to_external_code/integrity_checking.md)を確認してください。

<!-- L110..110
### Cache and compilation flags
-->

### キャッシュとコンパイルに関するフラグ

<!-- L112..114
Affect commands which can populate the cache: `deno cache`, `deno run` and
`deno test`. As well as the flags above this includes those which affect module
resolution, compilation configuration etc.
-->

Affect commands which can populate the cache: `deno cache`, `deno run` and
`deno test`. As well as the flags above this includes those which affect module resolution, compilation configuration etc.
キャッシュを生成することのあるコマンドに影響を与えます。たとえば、
`deno cache`、`deno run`、`deno test` です。
上記のフラグと同様に、モジュール解決やコンパイル設定などに影響を与えるフラグも含みます。


<!-- L116..122
```
--config <FILE>               Load tsconfig.json configuration file
--importmap <FILE>            UNSTABLE: Load import map file
--no-remote                   Do not resolve remote modules
--reload=<CACHE_BLOCKLIST>    Reload source code cache (recompile TypeScript)
--unstable                    Enable unstable APIs
```
-->

```
--config <FILE>               Load tsconfig.json configuration file
--importmap <FILE>            UNSTABLE: Load import map file
--no-remote                   Do not resolve remote modules
--reload=<CACHE_BLOCKLIST>    Reload source code cache (recompile TypeScript)
--unstable                    Enable unstable APIs
```

<!-- L124..124
### Runtime flags
-->

### ランタイムフラグ

<!-- L126..127
Affect commands which execute user code: `deno run` and `deno test`. These
include all of the above as well as the following.
-->

ユーザーコードを実行するコマンドに影響を与えます。たとえば `deno run` と `deno test` です。
これらは上記のフラグに加えて以下のフラグを含みます。

<!-- L129..129
#### Permission flags
-->

#### パーミッションフラグ

<!-- L131..131
These are listed [here](./permissions.md#permissions-list).
-->

[ここ](./permissions.md#permissions-list)に一覧があります。

<!-- L133..133
#### Other runtime flags
-->

#### その他のランタイムフラグ

<!-- L135..135
More flags which affect the execution environment.
-->

他のフラグは実行環境に影響を与えます。

<!-- L137..143
```
--cached-only                Require that remote dependencies are already cached
--inspect=<HOST:PORT>        activate inspector on host:port ...
--inspect-brk=<HOST:PORT>    activate inspector on host:port and break at ...
--seed <NUMBER>              Seed Math.random()
--v8-flags=<v8-flags>        Set V8 command line options. For help: ...
```
-->

```
--cached-only                Require that remote dependencies are already cached
--inspect=<HOST:PORT>        activate inspector on host:port ...
--inspect-brk=<HOST:PORT>    activate inspector on host:port and break at ...
--seed <NUMBER>              Seed Math.random()
--v8-flags=<v8-flags>        Set V8 command line options. For help: ...
```
