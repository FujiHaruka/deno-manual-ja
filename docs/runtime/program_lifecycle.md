---
title: プログラムのライフサイクル
sort: 2
---
<!-- L1..1
## Program lifecycle
-->

## プログラムのライフサイクル

<!-- L3..4
Deno supports browser compatible lifecycle events: `load` and `unload`. You can
use these events to provide setup and cleanup code in your program.
-->

Deno はブラウザと互換性のあるライフサイクルイベントをサポートしています。`load` と `unload` です。
これらのイベントはプログラム内でコードのセットアップとクリーンアップを提供するために使うことができます。

<!-- L6..7
Listeners for `load` events can be asynchronous and will be awaited. Listeners
for `unload` events need to be synchronous. Both events cannot be cancelled.
-->

`load` イベントのリスナーは非同期関数を与えることができ、await を使うことが可能です。
`unload` イベントのリスナーは同期関数を与える必要があります。両者ともイベントをキャンセルできません。

<!-- L9..9
Example:
-->

例:

<!-- L11..11
**main.ts**
-->

**main.ts**

<!-- L13..33
```ts
import "./imported.ts";

const handler = (e: Event): void => {
  console.log(`got ${e.type} event in event handler (main)`);
};

window.addEventListener("load", handler);

window.addEventListener("unload", handler);

window.onload = (e: Event): void => {
  console.log(`got ${e.type} event in onload function (main)`);
};

window.onunload = (e: Event): void => {
  console.log(`got ${e.type} event in onunload function (main)`);
};

console.log("log from main script");
```
-->

```ts
import "./imported.ts";

const handler = (e: Event): void => {
  console.log(`got ${e.type} event in event handler (main)`);
};

window.addEventListener("load", handler);

window.addEventListener("unload", handler);

window.onload = (e: Event): void => {
  console.log(`got ${e.type} event in onload function (main)`);
};

window.onunload = (e: Event): void => {
  console.log(`got ${e.type} event in onunload function (main)`);
};

console.log("log from main script");
```

<!-- L35..35
**imported.ts**
-->

**imported.ts**

<!-- L37..54
```ts
const handler = (e: Event): void => {
  console.log(`got ${e.type} event in event handler (imported)`);
};

window.addEventListener("load", handler);
window.addEventListener("unload", handler);

window.onload = (e: Event): void => {
  console.log(`got ${e.type} event in onload function (imported)`);
};

window.onunload = (e: Event): void => {
  console.log(`got ${e.type} event in onunload function (imported)`);
};

console.log("log from imported script");
```
-->

```ts
const handler = (e: Event): void => {
  console.log(`got ${e.type} event in event handler (imported)`);
};

window.addEventListener("load", handler);
window.addEventListener("unload", handler);

window.onload = (e: Event): void => {
  console.log(`got ${e.type} event in onload function (imported)`);
};

window.onunload = (e: Event): void => {
  console.log(`got ${e.type} event in onunload function (imported)`);
};

console.log("log from imported script");
```

<!-- L56..58
Note that you can use both `window.addEventListener` and
`window.onload`/`window.onunload` to define handlers for events. There is a
major difference between them, let's run the example:
-->

イベントハンドラーを定義するために `window.addEventListener`を使うことも `window.onload`/`window.onunload` を使うこともできる点に留意してください。
両者には違いがあります。例を実行してみましょう。

<!-- L60..70
```shell
$ deno run main.ts
log from imported script
log from main script
got load event in onload function (main)
got load event in event handler (imported)
got load event in event handler (main)
got unload event in onunload function (main)
got unload event in event handler (imported)
got unload event in event handler (main)
```
-->

```shell
$ deno run main.ts
log from imported script
log from main script
got load event in onload function (main)
got load event in event handler (imported)
got load event in event handler (main)
got unload event in onunload function (main)
got unload event in event handler (imported)
got unload event in event handler (main)
```

<!-- L72..74
All listeners added using `window.addEventListener` were run, but
`window.onload` and `window.onunload` defined in `main.ts` overrode handlers
defined in `imported.ts`.
-->

`window.addEventListener` を使って追加されたリスナーはすべて実行されましたが、
`window.onload` と `window.onunload` のほうは `main.ts` で定義されたハンドラーが `imported.ts` で定義されたハンドラーを上書きしました。

<!-- L76..78
In other words, you can register multiple `window.addEventListener` `"load"` or
`"unload"` events, but only the last loaded `window.onload` or `window.onunload`
events will be executed.
-->

言い換えると、`window.addEventListener` は複数の `"load"` と
`"unload"` イベントを登録できますが、`window.onload` と `window.onunload` は最後に登録されたイベントだけが実行されます。
