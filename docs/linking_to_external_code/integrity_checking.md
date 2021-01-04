---
title: 整合性チェック
sort: 2
---
<!-- L1..1
## Integrity checking & lock files
-->

## 整合性チェックとロックファイル

<!-- L3..3
### Introduction
-->

### 導入

<!-- L5..12
Let's say your module depends on remote module `https://some.url/a.ts`. When you
compile your module for the first time `a.ts` is retrieved, compiled and cached.
It will remain this way until you run your module on a new machine (say in
production) or reload the cache (through `deno cache --reload` for example). But
what happens if the content in the remote url `https://some.url/a.ts` is
changed? This could lead to your production module running with different
dependency code than your local module. Deno's solution to avoid this is to use
integrity checking and lock files.
-->

あなたのモジュールがリモートモジュール `https://some.url/a.ts` に依存しているとしましょう。
初めてモジュールをコンパイルするとき `a.ts` が取得され、コンパイルされ、キャッシュされます。
そのモジュールを新たなマシーン（本番環境など）で実行するかキャッシュをリロードする（たとえば `deno cache --reload` で）ときまでキャッシュは残ります。
しかし、もしリモート URL `https://some.url/a.ts` の中身が変更されるとしたら何が起きるでしょうか？　これが起きると本番環境のモジュールがローカルのモジュールと異なるコードで実行される可能性があります。
Deno はこれを回避する解決策として整合性チェックとロックファイルを用意しています。

<!-- L14..14
### Caching and lock files
-->

### キャッシュとロックファイル

<!-- L16..21
Deno can store and check subresource integrity for modules using a small JSON
file. Use the `--lock=lock.json` to enable and specify lock file checking. To
update or create a lock use `--lock=lock.json --lock-write`. The
`--lock=lock.json` tells Deno what the lock file to use is, while the
`--lock-write` is used to output dependency hashes to the lock file
(`--lock-write` must be used in conjunction with `--lock`).
-->

Deno は小さな JSON ファイルを使ってモジュールのサブリソースの整合性を保存し、チェックできます。
`--lock=lock.json` を指定するとロックファイルによるチェックを有効化できます。
ロックファイルを更新または新規作成するには `--lock=lock.json --lock-write` を指定します。
`--lock=lock.json` は Deno にどのロックファイルを使うかを教え、`--lock-write` は依存関係のハッシュをロックファイルに出力するために使います
（`--lock-write` は `--lock` と一緒に使う必要があります）。

<!-- L23..24
A `lock.json` might look like this, storing a hash of the file against the
dependency:
-->

`lock.json` は次のように依存関係に対してファイルのハッシュ値を保存するものです。

<!-- L26..33
```json
{
  "https://deno.land/std@$STD_VERSION/textproto/mod.ts": "3118d7a42c03c242c5a49c2ad91c8396110e14acca1324e7aaefd31a999b71a4",
  "https://deno.land/std@$STD_VERSION/io/util.ts": "ae133d310a0fdcf298cea7bc09a599c49acb616d34e148e263bcb02976f80dee",
  "https://deno.land/std@$STD_VERSION/async/delay.ts": "35957d585a6e3dd87706858fb1d6b551cb278271b03f52c5a2cb70e65e00c26a",
   ...
}
```
-->

```json
{
  "https://deno.land/std@$STD_VERSION/textproto/mod.ts": "3118d7a42c03c242c5a49c2ad91c8396110e14acca1324e7aaefd31a999b71a4",
  "https://deno.land/std@$STD_VERSION/io/util.ts": "ae133d310a0fdcf298cea7bc09a599c49acb616d34e148e263bcb02976f80dee",
  "https://deno.land/std@$STD_VERSION/async/delay.ts": "35957d585a6e3dd87706858fb1d6b551cb278271b03f52c5a2cb70e65e00c26a",
   ...
}
```

<!-- L35..35
A typical workflow will look like this:
-->

典型的なワークフローは次のようになります。

<!-- L37..37
**src/deps.ts**
-->

**src/deps.ts**

<!-- L39..42
```ts
// Add a new dependency to "src/deps.ts", used somewhere else.
export { xyz } from "https://unpkg.com/xyz-lib@v0.9.0/lib.ts";
```
-->

```ts
// 新たな依存関係を "src/deps.ts" に追加し、別の場所で使用します
export { xyz } from "https://unpkg.com/xyz-lib@v0.9.0/lib.ts";
```

<!-- L44..44
Then:
-->

次。

<!-- L46..54
```shell
# Create/update the lock file "lock.json".
deno cache --lock=lock.json --lock-write src/deps.ts

# Include it when committing to source control.
git add -u lock.json
git commit -m "feat: Add support for xyz using xyz-lib"
git push
```
-->

```shell
# ロックファイル "lock.json" を作成／更新します
deno cache --lock=lock.json --lock-write src/deps.ts

# コミットしてソース管理下に置きます
git add -u lock.json
git commit -m "feat: Add support for xyz using xyz-lib"
git push
```

<!-- L56..56
Collaborator on another machine -- in a freshly cloned project tree:
-->

別の作業者が別のマシンで新たにプロジェクトをクローンします。

<!-- L58..65
```shell
# Download the project's dependencies into the machine's cache, integrity
# checking each resource.
deno cache --reload --lock=lock.json src/deps.ts

# Done! You can proceed safely.
deno test --allow-read src
```
-->

```shell
# プロジェクトの依存関係をマシンのキャッシュにダウンロードし、
# 各リソースについて整合性をチェックします
deno cache --reload --lock=lock.json src/deps.ts

# 完了です！　安全に作業を続けられます
deno test --allow-read src
```

<!-- L67..67
### Runtime verification
-->

### 実行時の検証

<!-- L69..73
Like caching above, you can also use the `--lock=lock.json` option during use of
the `deno run` sub command, validating the integrity of any locked modules
during the run. Remember that this only validates against dependencies
previously added to the `lock.json` file. New dependencies will be cached but
not validated.
-->

上記のキャッシュと同じように `deno run` サブコマンドの使用時にも、`--lock=lock.json` オプションを使って、実行中のモジュールの整合性を検証できます。
ここで行われる検証は、以前に `lock.json` ファイルに追加された依存関係だけである点を頭に留めてください。
新たな依存関係はキャッシュされますが検証はされません。

<!-- L75..76
You can take this a step further as well by using the `--cached-only` flag to
require that remote dependencies are already cached.
-->

リモートの依存関係がキャッシュ済みであることを `--cached-only` フラグを使えばこれを一ステップで行えます。

<!-- L78..80
```shell
deno run --lock=lock.json --cached-only mod.ts
```
-->

```shell
deno run --lock=lock.json --cached-only mod.ts
```

<!-- L82..83
This will fail if there are any dependencies in the dependency tree for mod.ts
which are not yet cached.
-->

mod.ts の依存関係のツリーに一つでもキャッシュされていないものがあればこのコマンドは失敗します。
