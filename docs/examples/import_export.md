---
title: モジュールのインポートとエクスポート
sort: 2
---
<!-- L1..1
# Import and export modules
-->

# モジュールのインポートとエクスポート

<!-- L3..3
## Concepts
-->

## この節で学ぶこと

<!-- L5..11
- [import](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/import)
  allows you to include and use modules held elsewhere, on your local file
  system or remotely.
- Imports are URLs or file system paths
- [export](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/export)
  allows you to specify which parts of your module are accessible to users who
  import your module
-->

- [import](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/import)
  を使うとモジュールを導入し使用できます。ローカルファイルシステムにあってもリモートにあってもどこにあるモジュールでもインポートできます。
- インポートは URL かファイルシステムのパスで指定します
- [export](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/export)
  を使うとモジュールの一部を指定して、そのモジュールをインポートしたいユーザーがアクセスできるようになります

<!-- L13..13
## Overview
-->

## 概要

<!-- L15..16
Deno by default standardizes the way modules are imported in both JavaScript and
TypeScript using the ECMAScript 6 `import/export` standard.
-->

Deno はデフォルトでモジュールのインポート方法を標準化しています。JavaScript でも TypeScript でも ECMAScript 6 の `import/export` 標準仕様に従ってインポートできます。

<!-- L18..20
It adopts browser-like module resolution, meaning that file names must be
specified in full. You may not omit the file extension and there is no special
handling of `index.js`.
-->

モジュール解決にはブラウザに似た方法を採用しています。とはつまり、ファイル名は完全な形で指定する必要があるということです。ファイル拡張子は省略できませんし、`index.js` の例外的な挙動もありません。

<!-- L22..27
```js
import {
  add,
  multiply,
} from "./arithmetic.ts";
```
-->

```js
import {
  add,
  multiply,
} from "./arithmetic.ts";
```

<!-- L29..32
Dependencies are also imported directly, there is no package management
overhead. Local modules are imported in exactly the same way as remote modules.
As the examples show below, the same functionality can be produced in the same
way with local or remote modules.
-->

依存関係も直接インポートできます。パッケージ管理が間に入ることはありません。
ローカルモジュールとリモートモジュールは全く同じやり方でインポートできます。
以下の例でお見せするとおり、ローカルでもリモートでもモジュールのインポートに全く同じ機能性が提供されています。

<!-- L34..34
## Local Import
-->

## ローカルのインポート

<!-- L36..37
In this example the `add` and `multiply` functions are imported from a local
`arithmetic.ts` module.
-->

次の例では `add` 関数と `multiply` 関数がローカルの `arithmetic.ts` モジュールからインポートされています。

<!-- L39..39
**Command:** `deno run local.ts`
-->

**Command:** `deno run local.ts`

<!-- L41..60
```ts
/**
 * local.ts
 */
import { add, multiply } from "./arithmetic.ts";

function totalCost(outbound: number, inbound: number, tax: number): number {
  return multiply(add(outbound, inbound), tax);
}

console.log(totalCost(19, 31, 1.2));
console.log(totalCost(45, 27, 1.15));

/**
 * Output
 *
 * 60
 * 82.8
 */
```
-->

```ts
/**
 * local.ts
 */
import { add, multiply } from "./arithmetic.ts";

function totalCost(outbound: number, inbound: number, tax: number): number {
  return multiply(add(outbound, inbound), tax);
}

console.log(totalCost(19, 31, 1.2));
console.log(totalCost(45, 27, 1.15));

/**
 * Output
 *
 * 60
 * 82.8
 */
```

<!-- L62..62
## Remote Import
-->

## リモートのインポート

<!-- L64..66
In the local import example above an `add` and `multiply` method are imported
from a locally stored arithmetic module. The same functionality can be created
by importing `add` and `multiply` methods from a remote module too.
-->

上のローカルインポートの例では `add` メソッドと `multiply` メソッドがローカルに保存された arithmetic モジュールからインポートされていました。同じ機能性がリモートモジュールから `add` メソッドと `multiply` メソッドをインポートするときにも提供されます。

<!-- L68..70
In this case the Ramda module is referenced, including the version number. Also
note a JavaScript module is imported directly into a TypeSript module, Deno has
no problem handling this.
-->

この例では Rambda モジュールがバージョン番号付きで参照されています。
JavaScript モジュールが TypeScript モジュールに直接インポートされている点にも留意してください。
Deno ではこういったことが問題なく行なえます。

<!-- L72..72
**Command:** `deno run ./remote.ts`
-->

**Command:** `deno run ./remote.ts`

<!-- L74..96
```ts
/**
 * remote.ts
 */
import {
  add,
  multiply,
} from "https://x.nest.land/ramda@0.27.0/source/index.js";

function totalCost(outbound: number, inbound: number, tax: number): number {
  return multiply(add(outbound, inbound), tax);
}

console.log(totalCost(19, 31, 1.2));
console.log(totalCost(45, 27, 1.15));

/**
 * Output
 *
 * 60
 * 82.8
 */
```
-->

```ts
/**
 * remote.ts
 */
import {
  add,
  multiply,
} from "https://x.nest.land/ramda@0.27.0/source/index.js";

function totalCost(outbound: number, inbound: number, tax: number): number {
  return multiply(add(outbound, inbound), tax);
}

console.log(totalCost(19, 31, 1.2));
console.log(totalCost(45, 27, 1.15));

/**
 * Output
 *
 * 60
 * 82.8
 */
```

<!-- L98..98
## Export
-->

## エクスポート

<!-- L100..102
In the local import example above the `add` and `multiply` functions are
imported from a locally stored arithmetic module. To make this possible the
functions stored in the arithmetic module must be exported.
-->

上のローカルインポートの例では `add` 関数と `multiply` 関数がローカルに保存された arithmetic モジュールからインポートされていました。これを可能にするためには、arithmetic モジュールに保存された関数がエクスポートされている必要があります。

<!-- L104..105
To do this just add the keyword `export` to the beginning of the function
signature as is shown below.
-->

そのためには、以下でお見せするように `export` キーワードを関数シグニチャの前に付けるだけです。

<!-- L107..118
```ts
/**
 * arithmetic.ts
 */
export function add(a: number, b: number): number {
  return a + b;
}

export function multiply(a: number, b: number): number {
  return a * b;
}
```
-->

```ts
/**
 * arithmetic.ts
 */
export function add(a: number, b: number): number {
  return a + b;
}

export function multiply(a: number, b: number): number {
  return a * b;
}
```

<!-- L120..123
All functions, classes, constants and variables which need to be accessible
inside external modules must be exported. Either by prepending them with the
`export` keyword or including them in an export statement at the bottom of the
file.
-->

どんな関数、クラス、定数、変数も、外部モジュールからアクセスできるようにするにはエクスポートする必要があります。`export` キーワードを宣言に前に付けるか、あるいはファイルの下部に export 文を書くことによりエクスポートできます。
