---
sort: 1
---
<!-- L1..1
# Introduction
-->

# 初めに

<!-- L3..4
Deno is a JavaScript/TypeScript runtime with secure defaults and a great
developer experience.
-->

Deno は安全なデフォルトと優れた開発体験を備えた JavaScript/TypeScript ランタイムです。

<!-- L6..6
It's built on V8, Rust, and Tokio.
-->

V8、Rust、Tokio で作られています。

<!-- L8..8
## Feature Highlights
-->

## 特長

<!-- L10..20
- Secure by default. No file, network, or environment access (unless explicitly
  enabled).
- Supports TypeScript out of the box.
- Ships a single executable (`deno`).
- Has built-in utilities like a dependency inspector (`deno info`) and a code
  formatter (`deno fmt`).
- Has
  [a set of reviewed (audited) standard
  modules](https://github.com/denoland/deno/tree/master/std) that are guaranteed
  to work with Deno.
- Scripts can be bundled into a single JavaScript file.
-->

- デフォルトで安全。明示的に有効にしない限り、ファイル、ネットワーク、環境変数にアクセスできない
- 設定不要で TypeScript を使える
- 単一の実行可能バイナリ (`deno`)
- 依存関係の検査 (`deno info`) やコードフォーマッタ (`deno fmt`) のようなユーティリティが組み込まれている
- Deno で動くことが保証された[レビュー済 (安全性を検査済み) の標準モジュール](https://github.com/denoland/deno/tree/master/std)がある
- スクリプトを単一の JavaScript ファイルにバンドルできる

<!-- L22..22
## Philosophy
-->

## 思想

<!-- L24..25
Deno aims to be a productive and secure scripting environment for the modern
programmer.
-->

Deno は現代のプログラマがプロダクト開発をできる安全なスクリプト環境となることを目指しています。

<!-- L27..31
Deno will always be distributed as a single executable. Given a URL to a Deno
program, it is runnable with nothing more than
[the ~15 megabyte zipped executable](https://github.com/denoland/deno/releases).
Deno explicitly takes on the role of both runtime and package manager. It uses a
standard browser-compatible protocol for loading modules: URLs.
-->

Deno は常に単一の実行可能ファイルとして配布されます。URL を Deno のプログラムに与えると、[zip 圧縮でわずか15メガバイト以下の実行可能ファイル](https://github.com/denoland/deno/releases)となって実行できます。
Deno が明確に担っている役割は、ランタイムとパッケージマネージャーの両方です。使っているのはブラウザと互換性のある標準プロトコル、URL です。

<!-- L33..34
Among other things, Deno is a great replacement for utility scripts that may
have been historically written with bash or python.
-->

Deno がとりわけ優れた代替となるのは、歴史的に bash や python で書かれてきた便利スクリプトです。

<!-- L36..36
## Goals
-->

## ゴール

<!-- L38..48
- Only ship a single executable (`deno`).
- Provide Secure Defaults
  - Unless specifically allowed, scripts can't access files, the environment, or
    the network.
- Browser compatible: The subset of Deno programs which are written completely
  in JavaScript and do not use the global `Deno` namespace (or feature test for
  it), ought to also be able to be run in a modern web browser without change.
- Provide built-in tooling like unit testing, code formatting, and linting to
  improve developer experience.
- Does not leak V8 concepts into user land.
- Be able to serve HTTP efficiently
-->

- 単一の実行可能バイナリだけを提供する (`deno`)。
- 安全なデフォルトを提供する
  - 特別に許可しない限り、スクリプトはファイル、環境変数、ネットワークにアクセスできない
- ブラウザとの互換性。完全に JavaScript で書かれていて、グローバルな `Deno` 名前空間 (またはそのための機能テスト) を使用しない Deno プログラムのサブセットは、モダンな Web ブラウザでも変更なしに実行できるようにする
- ユニットテスト、コードフォーマッタ、リンターなどの組み込みツールを提供し、開発体験を向上させる
- V8 の考え方をユーザーランドに漏らさない
- 効率的な HTTP サーバーを提供する

<!-- L50..50
## Comparison to Node.js
-->

## Node.js との比較

<!-- L52..64
- Deno does not use `npm`
  - It uses modules referenced as URLs or file paths
- Deno does not use `package.json` in its module resolution algorithm.
- All async actions in Deno return a promise. Thus Deno provides different APIs
  than Node.
- Deno requires explicit permissions for file, network, and environment access.
- Deno always dies on uncaught errors.
- Uses "ES Modules" and does not support `require()`. Third party modules are
  imported via URLs:

  ```javascript
  import * as log from "https://deno.land/std@$STD_VERSION/log/mod.ts";
  ```
-->

- Deno は `npm` を使用しない
  - URL とファイルパスで参照されるモジュールを使用する
- Deno はモジュール解決アルゴリズムに `package.json` を使用しない
- Deno の非同期操作はすべて Promise を返す。そのため Deno は Node と違った API を提供する
- Deno はファイル、ネットワーク、環境変数にアクセスするために明示的な許可を要求する
- Deno ではエラーが捕捉されなければ必ず死ぬ
- 「ES モジュール」を使用し、`require()` はサポートしない。サードパーティのモジュールは URL でインポートする

  ```javascript
  import * as log from "https://deno.land/std@$STD_VERSION/log/mod.ts";
  ```

<!-- L66..66
## Other key behaviors
-->

## 他の重要な挙動

<!-- L68..72
- Remote code is fetched and cached on first execution, and never updated until
  the code is run with the `--reload` flag. (So, this will still work on an
  airplane.)
- Modules/files loaded from remote URLs are intended to be immutable and
  cacheable.
-->

- リモートにあるコードは最初の実行時に取得され、キャッシュされる。`--reload` フラグでコードが実行されるまでは更新されない。(だから飛行機の中でも仕事を続けられます)
- リモートの URL から読み込まれたモジュールやファイルは、変更がなくキャッシュできるものと期待されている
