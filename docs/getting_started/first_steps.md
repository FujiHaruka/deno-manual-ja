---
title: 初めの一歩
sort: 3
---
<!-- L1..1
## First steps
-->

## 初めの一歩

<!-- L3..3
This page contains some examples to teach you about the fundamentals of Deno.
-->

このページでは Deno の基本を理解するためにいくつかの例を扱います。

<!-- L5..9
This document assumes that you have some prior knowledge of JavaScript,
especially about `async`/`await`. If you have no prior knowledge of JavaScript,
you might want to follow a guide
[on the basics of JavaScript](https://developer.mozilla.org/en-US/docs/Learn/JavaScript)
before attempting to start with Deno.
-->

このドキュメントでは JavaScript の前提知識、特に `async`/`await` を知っていることを仮定します。
JavaScript の前提知識がない場合は、Deno を始める前に [JavaScript の基本](https://developer.mozilla.org/ja/docs/Learn/JavaScript)を学ぶとよいでしょう。

<!-- L11..11
### Hello World
-->

### Hello World

<!-- L13..14
Deno is a runtime for JavaScript/TypeScript which tries to be web compatible and
use modern features wherever possible.
-->

Deno は JavaScript/TypeScript ランタイムとして、Web と互換性を持たせようとし、また可能ならいつでもモダンな機能を使うようにするよう試みています。

<!-- L16..17
Browser compatibility means a `Hello World` program in Deno is the same as the
one you can run in the browser:
-->

ブラウザとの互換性とはつまり、Deno の `Hello World` プログラムがブラウザで実行できるそれと同じだということです。

<!-- L19..21
```ts
console.log("Welcome to Deno 🦕");
```
-->

```ts
console.log("Welcome to Deno 🦕");
```

<!-- L23..23
Try the program:
-->

以下のプログラムを実行してみてください。

<!-- L25..27
```shell
deno run https://deno.land/std@$STD_VERSION/examples/welcome.ts
```
-->

```shell
deno run https://deno.land/std@$STD_VERSION/examples/welcome.ts
```

<!-- L29..29
### Making an HTTP request
-->

### HTTP リクエストを作る

<!-- L31..32
Many programs use HTTP requests to fetch data from a webserver. Let's write a
small program that fetches a file and prints its contents out to the terminal.
-->

多くのプログラムが Web サーバーからデータを取得するために HTTP リクエストを使います。
ファイルを取得してターミナルに出力する小さなプログラムを書いてみましょう。

<!-- L34..36
Just like in the browser you can use the web standard
[`fetch`](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API) API to
make HTTP calls:
-->

Just like in the browser you can use the web standard
[`fetch`](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API) API to
make HTTP calls:
HTTP リクエストを送るにはブラウザと同様に Web 標準の
[`fetch`](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API) API
が使えます。

<!-- L38..44
```ts
const url = Deno.args[0];
const res = await fetch(url);

const body = new Uint8Array(await res.arrayBuffer());
await Deno.stdout.write(body);
```
-->

```ts
const url = Deno.args[0];
const res = await fetch(url);

const body = new Uint8Array(await res.arrayBuffer());
await Deno.stdout.write(body);
```

<!-- L46..46
Let's walk through what this application does:
-->

このアプリケーションがしていることを一つひとつ確認しましょう。

<!-- L48..57
1. We get the first argument passed to the application, and store it in the
   `url` constant.
2. We make a request to the url specified, await the response, and store it in
   the `res` constant.
3. We parse the response body as an
   [`ArrayBuffer`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/ArrayBuffer),
   await the response, and convert it into a
   [`Uint8Array`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Uint8Array)
   to store in the `body` constant.
4. We write the contents of the `body` constant to `stdout`.
-->

1. アプリケーションに第一引数を渡し、定数 `url` に保存する
2. URL を指定してリクエストを作成し、レスポンスを待ち、その結果を定数 `res` に保存する
3. レスポンスの body を
   [`ArrayBuffer`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/ArrayBuffer),
   としてパースして結果を待ち、それを
   [`Uint8Array`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Uint8Array)
   に変換して定数 `body` に保存する
4. `body` の中身を `stdout` に書き込む

<!-- L59..59
Try it out:
-->

次のプログラムを実行してみてください。

<!-- L61..63
```shell
deno run https://deno.land/std@$STD_VERSION/examples/curl.ts https://example.com
```
-->

```shell
deno run https://deno.land/std@$STD_VERSION/examples/curl.ts https://example.com
```

<!-- L65..68
You will see this program returns an error regarding network access, so what did
we do wrong? You might remember from the introduction that Deno is a runtime
which is secure by default. This means you need to explicitly give programs the
permission to do certain 'privileged' actions, such as access the network.
-->

実行するとわかりますが、このプログラムはネットワークアクセスがあってもなくてもエラーを返します。何か間違えたのでしょうか？
初めに Deno がデフォルトで安全なランタイムだと紹介したのを覚えているかもしれません。これはつまり、
ネットワークアクセスのようなある「特権的な」操作を行うために明示的な許可を与える必要があるということです。

<!-- L70..70
Try it out again with the correct permission flag:
-->

正しい許可フラグを与えてもう一度実行してみましょう。

<!-- L72..74
```shell
deno run --allow-net=example.com https://deno.land/std@$STD_VERSION/examples/curl.ts https://example.com
```
-->

```shell
deno run --allow-net=example.com https://deno.land/std@$STD_VERSION/examples/curl.ts https://example.com
```

<!-- L76..76
### Reading a file
-->

### ファイルを読み込む

<!-- L78..80
Deno also provides APIs which do not come from the web. These are all contained
in the `Deno` global. You can find documentation for these APIs on
[doc.deno.land](https://doc.deno.land/https/github.com/denoland/deno/releases/latest/download/lib.deno.d.ts).
-->

Deno は Web に由来しない API も提供しています。それらはすべて `Deno` というグローバル変数に含まれています。
この API ドキュメントは
[doc.deno.land](https://doc.deno.land/https/github.com/denoland/deno/releases/latest/download/lib.deno.d.ts)
にあります。

<!-- L82..83
Filesystem APIs for example do not have a web standard form, so Deno provides
its own API.
-->

たとえばファイルシステム API は Web 標準の仕様がないため、Deno が独自で API を提供しています。

<!-- L85..86
In this program each command-line argument is assumed to be a filename, the file
is opened, and printed to stdout.
-->

以下のプログラムは、コマンドライン引数をファイル名として、ファイルを開いて標準出力に表示します。

<!-- L88..95
```ts
const filenames = Deno.args;
for (const filename of filenames) {
  const file = await Deno.open(filename);
  await Deno.copy(file, Deno.stdout);
  file.close();
}
```
-->

```ts
const filenames = Deno.args;
for (const filename of filenames) {
  const file = await Deno.open(filename);
  await Deno.copy(file, Deno.stdout);
  file.close();
}
```

<!-- L97..100
The `copy()` function here actually makes no more than the necessary
kernel→userspace→kernel copies. That is, the same memory from which data is read
from the file, is written to stdout. This illustrates a general design goal for
I/O streams in Deno.
-->

ここで `copy()` 関数はカーネル→ユーザースペース→カーネルのコピーに必要なこと以外はしていません。
言い換えると、ファイルから読んだデータを保持しているメモリからそのまま標準出力に書き込まれます。
これは Deno の I/O ストリームに関する一般的な設計目標を表しています。


<!-- L102..102
Try the program:
-->

以下のプログラムを実行してみてください。

<!-- L104..106
```shell
deno run --allow-read https://deno.land/std@$STD_VERSION/examples/cat.ts /etc/passwd
```
-->

```shell
deno run --allow-read https://deno.land/std@$STD_VERSION/examples/cat.ts /etc/passwd
```

<!-- L108..108
### TCP server
-->

### TCP サーバー

<!-- L110..111
This is an example of a server which accepts connections on port 8080, and
returns to the client anything it sends.
-->

以下は 8080 番ポートで接続を待ち受けるサーバーの例です。クライアントが送ってきたデータをそのまま返します。

<!-- L113..121
```ts
const hostname = "0.0.0.0";
const port = 8080;
const listener = Deno.listen({ hostname, port });
console.log(`Listening on ${hostname}:${port}`);
for await (const conn of listener) {
  Deno.copy(conn, conn);
}
```
-->

```ts
const hostname = "0.0.0.0";
const port = 8080;
const listener = Deno.listen({ hostname, port });
console.log(`Listening on ${hostname}:${port}`);
for await (const conn of listener) {
  Deno.copy(conn, conn);
}
```

<!-- L123..124
For security reasons, Deno does not allow programs to access the network without
explicit permission. To allow accessing the network, use a command-line flag:
-->

セキュリティ面の理由から、Deno のプログラムは明示的な許可なしでネットワークにアクセスできません。
ネットワークアクセスを許可するにはコマンドラインでフラグを与えます。

<!-- L126..128
```shell
deno run --allow-net https://deno.land/std@$STD_VERSION/examples/echo_server.ts
```
-->

```shell
deno run --allow-net https://deno.land/std@$STD_VERSION/examples/echo_server.ts
```

<!-- L130..130
To test it, try sending data to it with netcat:
-->

サーバーをテストするために、netcat を使ってデータを送ってみてください。

<!-- L132..136
```shell
$ nc localhost 8080
hello world
hello world
```
-->

```shell
$ nc localhost 8080
hello world
hello world
```

<!-- L138..140
Like the `cat.ts` example, the `copy()` function here also does not make
unnecessary memory copies. It receives a packet from the kernel and sends it
back, without further complexity.
-->

`cat.ts` の例のように、ここでも `copy()` 関数は不必要なメモリのコピーを作りません。
カーネルから受け取ったパケットを送り返すだけです。

<!-- L142..142
### More examples
-->

### 他の例

<!-- L144..144
You can find more examples, like an HTTP file server, in the `Examples` chapter.
-->

HTTP ファイルサーバーのような他の例は `Examples` の章で扱います。
