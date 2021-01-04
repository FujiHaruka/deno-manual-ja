---
title: 外部のコードにリンクする
sort: 30
---
<!-- L1..1
# Linking to third party code
-->

# サードパーティのコードにリンクする

<!-- L3..5
In the [Getting Started](./getting_started.md) section, we saw Deno could
execute scripts from URLs. Like browser JavaScript, Deno can import libraries
directly from URLs. This example uses a URL to import an assertion library:
-->

[Getting Started](./getting_started.md) セクションで Deno が URL からスクリプトを実行できることを見てきました。
ブラウザの JavaScript と同じく Deno も URL から直接ライブラリをインポートできます。
以下の例ではアサーションライブラリを URL でインポートしています。

<!-- L7..7
**test.ts**
-->

**test.ts**

<!-- L9..16
```ts
import { assertEquals } from "https://deno.land/std@$STD_VERSION/testing/asserts.ts";

assertEquals("hello", "hello");
assertEquals("world", "world");

console.log("Asserted! ✓");
```
-->

```ts
import { assertEquals } from "https://deno.land/std@$STD_VERSION/testing/asserts.ts";

assertEquals("hello", "hello");
assertEquals("world", "world");

console.log("Asserted! ✓");
```

<!-- L18..18
Try running this:
-->

以下を実行してみてください。

<!-- L20..27
```shell
$ deno run test.ts
Compile file:///mnt/f9/Projects/github.com/denoland/deno/docs/test.ts
Download https://deno.land/std@$STD_VERSION/testing/asserts.ts
Download https://deno.land/std@$STD_VERSION/fmt/colors.ts
Download https://deno.land/std@$STD_VERSION/testing/diff.ts
Asserted! ✓
```
-->

```shell
$ deno run test.ts
Compile file:///mnt/f9/Projects/github.com/denoland/deno/docs/test.ts
Download https://deno.land/std@$STD_VERSION/testing/asserts.ts
Download https://deno.land/std@$STD_VERSION/fmt/colors.ts
Download https://deno.land/std@$STD_VERSION/testing/diff.ts
Asserted! ✓
```

<!-- L29..31
Note that we did not have to provide the `--allow-net` flag for this program,
and yet it accessed the network. The runtime has special access to download
imports and cache them to disk.
-->

このプログラムに `--allow-net` フラグを与えくてもネットワークにアクセスできた点に留意してください。
ランタイムはインポートをダウンロードしてディスクにキャッシュする特別なアクセス権を持っているからです。

<!-- L33..37
Deno caches remote imports in a special directory specified by the `DENO_DIR`
environment variable. It defaults to the system's cache directory if `DENO_DIR`
is not specified. The next time you run the program, no downloads will be made.
If the program hasn't changed, it won't be recompiled either. The default
directory is:
-->

Deno は環境変数 `DENO_DIR` で指定された特別なディレクトリにリモートのインポートをキャッシュします。
`DENO_DIR` が指定されていなければデフォルトでシステムのキャッシュディレクトリにキャッシュします。
二回目以降の実行ではダウンロードは行われません。
プログラムが変更されていなければ再コンパイルも行われません。
デフォルトのディレクトリは以下のとおりです。

<!-- L39..42
- On Linux/Redox: `$XDG_CACHE_HOME/deno` or `$HOME/.cache/deno`
- On Windows: `%LOCALAPPDATA%/deno` (`%LOCALAPPDATA%` = `FOLDERID_LocalAppData`)
- On macOS: `$HOME/Library/Caches/deno`
- If something fails, it falls back to `$HOME/.deno`
-->

- Linux/Redox: `$XDG_CACHE_HOME/deno` または `$HOME/.cache/deno`
- Windows: `%LOCALAPPDATA%/deno` (`%LOCALAPPDATA%` = `FOLDERID_LocalAppData`)
- macOS: `$HOME/Library/Caches/deno`
- 何かがうまくいかなければ、`$HOME/.deno` にフォールバックします

<!-- L44..44
## FAQ
-->

## FAQ

<!-- L46..46
### How do I import a specific version of a module?
-->

### モジュールのバージョンを指定してインポートするにはどうすればよいでしょうか？

<!-- L48..49
Specify the version in the URL. For example, this URL fully specifies the code
being run: `https://unpkg.com/liltest@0.0.5/dist/liltest.js`.
-->

URL の中にバージョンを指定してください。たとえば、実行されるコードを完全に指定した URL は
`https://unpkg.com/liltest@0.0.5/dist/liltest.js`
のようになります。

<!-- L51..51
### It seems unwieldy to import URLs everywhere.
-->

### インポートする URL をあちこちに書くのは大変です

<!-- L53..53
> What if one of the URLs links to a subtly different version of a library?
-->

> いくつもある URL の一つが微妙に違うバージョンのライブラリにリンクしていたらどうなるでしょうか？

<!-- L55..55
> Isn't it error prone to maintain URLs everywhere in a large project?
-->

> 巨大なプロジェクトであちこちに散らばっている URL をメンテナンスするのはエラーのもとになりませんか？

<!-- L57..62
The solution is to import and re-export your external libraries in a central
`deps.ts` file (which serves the same purpose as Node's `package.json` file).
For example, let's say you were using the above assertion library across a large
project. Rather than importing
`"https://deno.land/std@$STD_VERSION/testing/asserts.ts"` everywhere, you could
create a `deps.ts` file that exports the third-party code:
-->

解決策としては、外部ライブラリを中央の `deps.ts` ファイルにインポートして再エクスポートすることです（Node の `package.json` ファイルと同じ目的で機能します）。
たとえば、上記のアサーションライブラリを巨大なプロジェクトで使いまわしたいとします。
ライブラリを使うたびに
`"https://deno.land/std@$STD_VERSION/testing/asserts.ts"`
と書くよりは、`deps.ts` ファイルを作ってサードパーティのコードをそこからエクスポートするようにできます。

<!-- L64..64
**deps.ts**
-->

**deps.ts**

<!-- L66..72
```ts
export {
  assert,
  assertEquals,
  assertStrContains,
} from "https://deno.land/std@$STD_VERSION/testing/asserts.ts";
```
-->

```ts
export {
  assert,
  assertEquals,
  assertStrContains,
} from "https://deno.land/std@$STD_VERSION/testing/asserts.ts";
```

<!-- L74..75
And throughout the same project, you can import from the `deps.ts` and avoid
having many references to the same URL:
-->

プロジェクト内で一貫して `deps.ts` からインポートすれば、同じ URL を何度も参照するのを避けられます。

<!-- L77..79
```ts
import { assertEquals, runTests, test } from "./deps.ts";
```
-->

```ts
import { assertEquals, runTests, test } from "./deps.ts";
```

<!-- L81..82
This design circumvents a plethora of complexity spawned by package management
software, centralized code repositories, and superfluous file formats.
-->

この設計は、パッケージ管理ソフトウェアや中央集権的なコードリポジトリや不必要なファイル形式によって生み出されるさまざまな複雑さを迂回できます。

<!-- L84..84
### How can I trust a URL that may change?
-->

### 変更しうる URL をどのように信頼できますか？

<!-- L86..89
By using a lock file (with the `--lock` command line flag), you can ensure that
the code pulled from a URL is the same as it was during initial development. You
can learn more about this
[here](./linking_to_external_code/integrity_checking.md).
-->

ロックファイルを使うことにより（コマンドラインの `--lock` フラグを指定します）、URL から取得するコードが最初の開発時から変わらないことを保証できます。
詳しくは[ここ](./linking_to_external_code/integrity_checking.md)を参照してください。

<!-- L91..91
### But what if the host of the URL goes down? The source won't be available.
-->

### でも、URL のホストが消えるとどうなりますか？ソースが利用できなくなります

<!-- L93..98
This, like the above, is a problem faced by _any_ remote dependency system.
Relying on external servers is convenient for development but brittle in
production. Production software should always vendor its dependencies. In Node
this is done by checking `node_modules` into source control. In Deno this is
done by pointing `$DENO_DIR` to some project-local directory at runtime, and
similarly checking that into source control:
-->

上記と同じように、これは _どんな_ リモート依存システムにおいても直面する問題です。
外部サーバーに依存すると開発時には便利ですが、本番環境では当てになりません。
製品版のソフトウェアは常に依存関係をベンダーすべきです。
Node では `node_modules` をソース管理に含めることでこの問題を解決します。
Deno では `$DENO_DIR` の向き先をプロジェクトのローカルディレクトリに指定しておき、同様にソース管理下に置くことで解決できます。

<!-- L100..110
```shell
# Download the dependencies.
DENO_DIR=./deno_dir deno cache src/deps.ts

# Make sure the variable is set for any command which invokes the cache.
DENO_DIR=./deno_dir deno test src

# Check the directory into source control.
git add -u deno_dir
git commit
```
-->

```shell
# Download the dependencies.
DENO_DIR=./deno_dir deno cache src/deps.ts

# Make sure the variable is set for any command which invokes the cache.
DENO_DIR=./deno_dir deno test src

# Check the directory into source control.
git add -u deno_dir
git commit
```
