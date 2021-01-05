---
title: Hello world
sort: 1
---
<!-- L1..1
# Hello world
-->

# Hello world

<!-- L3..3
## Concepts
-->

## この節で学ぶこと

<!-- L5..6
- Deno can run JavaScript or TypeScript out of the box with no additional tools
  or config required
-->

- Deno は組み込みで JavaScript と TypeScript を実行できます。他の余計なツールや設定は必要ありません

<!-- L8..8
## Overview
-->

## 概要

<!-- L10..12
Deno is a secure runtime for both JavaScript and TypeScript. As the hello world
examples below highlight the same functionality can be created in JavaScript or
TypeScript, and Deno will execute both.
-->

Deno は JavaScript と TypeScript のためのセキュアなランタイムです。
以下の hello world の例は、JavaScript でも TypeScript でも同じ機能性を有していて Deno が両方を実行できることに焦点を当てています。

<!-- L14..14
## JavaScript
-->

## JavaScript

<!-- L16..17
In this JavaScript example the message `Hello [name]` is printed to the console
and the code ensures the name provided is capitalized.
-->

次の JavaScript の例は `Hello [name]` というメッセージをコンソールに表示します。また、名前が与えられると大文字に変換されるようになっています。

<!-- L19..19
**Command:** `deno run hello-world.js`
-->

**Command:** `deno run hello-world.js`

<!-- L21..44
```js
/**
 * hello-world.js
 */
function capitalize(word) {
  return word.charAt(0).toUpperCase() + word.slice(1);
}

function hello(name) {
  return "Hello " + capitalize(name);
}

console.log(hello("john"));
console.log(hello("Sarah"));
console.log(hello("kai"));

/**
 * Output:
 *
 * Hello John
 * Hello Sarah
 * Hello Kai
**/
```
-->

```js
/**
 * hello-world.js
 */
function capitalize(word) {
  return word.charAt(0).toUpperCase() + word.slice(1);
}

function hello(name) {
  return "Hello " + capitalize(name);
}

console.log(hello("john"));
console.log(hello("Sarah"));
console.log(hello("kai"));

/**
 * Output:
 *
 * Hello John
 * Hello Sarah
 * Hello Kai
**/
```

<!-- L46..46
## TypeScript
-->

## TypeScript

<!-- L48..49
This TypeScript example is exactly the same as the JavaScript example above, the
code just has the additional type information which TypeScript supports.
-->

次の TypeScript の例は上記の JavaScript の例と全く同じです。
TypeScript がサポートしている型情報をコードに追加しただけです。

<!-- L51..52
The `deno run` command is exactly the same, it just references a `*.ts` file
rather than a `*.js` file.
-->

`deno run` コマンドは全く同じです。 `*.js` ファイルでなく `*.ts` ファイルを参照している点だけが違います。

<!-- L54..54
**Command:** `deno run hello-world.ts`
-->

**Command:** `deno run hello-world.ts`

<!-- L56..79
```ts
/**
 * hello-world.ts
 */
function capitalize(word: string): string {
  return word.charAt(0).toUpperCase() + word.slice(1);
}

function hello(name: string): string {
  return "Hello " + capitalize(name);
}

console.log(hello("john"));
console.log(hello("Sarah"));
console.log(hello("kai"));

/**
 * Output:
 *
 * Hello John
 * Hello Sarah
 * Hello Kai
**/
```
-->

```ts
/**
 * hello-world.ts
 */
function capitalize(word: string): string {
  return word.charAt(0).toUpperCase() + word.slice(1);
}

function hello(name: string): string {
  return "Hello " + capitalize(name);
}

console.log(hello("john"));
console.log(hello("Sarah"));
console.log(hello("kai"));

/**
 * Output:
 *
 * Hello John
 * Hello Sarah
 * Hello Kai
**/
```
