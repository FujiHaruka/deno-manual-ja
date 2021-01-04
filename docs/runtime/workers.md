---
title: Worker
sort: 6
---
<!-- L1..1
## Workers
-->

## Worker

<!-- L3..4
Deno supports
[`Web Worker API`](https://developer.mozilla.org/en-US/docs/Web/API/Worker/Worker).
-->

Deno は
[`Web Worker API`](https://developer.mozilla.org/en-US/docs/Web/API/Worker/Worker)
をサポートしています。

<!-- L6..7
Workers can be used to run code on multiple threads. Each instance of `Worker`
is run on a separate thread, dedicated only to that worker.
-->

Worker はマルチスレッドでコードを実行するために使用します。
`Worker` の各インスタンスは別々のスレッドで実行され、各スレッドは一つの worker に専念します。

<!-- L9..10
Currently Deno supports only `module` type workers; thus it's essential to pass
the `type: "module"` option when creating a new worker.
-->

現時点では、Deno は `module` 型の worker のみをサポートしています。
そのため新しい worker を作成するときに `type: "module"` オプションを渡すことが必須です。

<!-- L12..15
Relative module specifiers are
[not supported](https://github.com/denoland/deno/issues/5216) at the moment. You
can instead use the `URL` contructor and `import.meta.url` to easily create a
specifier for some nearby script.
-->

相対パスによるモジュールの指定子は現時点で[サポートされていません](https://github.com/denoland/deno/issues/5216)。
かわりに、近くのスクリプトの指定子を簡単に作成するには `URL` コンストラクタと `import.meta.url` を使うことができます。

<!-- L17..25
```ts
// Good
new Worker(new URL("worker.js", import.meta.url).href, { type: "module" });

// Bad
new Worker(new URL("worker.js", import.meta.url).href);
new Worker(new URL("worker.js", import.meta.url).href, { type: "classic" });
new Worker("./worker.js", { type: "module" });
```
-->

```ts
// Good
new Worker(new URL("worker.js", import.meta.url).href, { type: "module" });

// Bad
new Worker(new URL("worker.js", import.meta.url).href);
new Worker(new URL("worker.js", import.meta.url).href, { type: "classic" });
new Worker("./worker.js", { type: "module" });
```

<!-- L27..27
### Permissions
-->

### Permissions

<!-- L29..30
Creating a new `Worker` instance is similar to a dynamic import; therefore Deno
requires appropriate permission for this action.
-->

Creating a new `Worker` instance is similar to a dynamic import; therefore Deno
requires appropriate permission for this action.

<!-- L32..32
For workers using local modules; `--allow-read` permission is required:
-->

For workers using local modules; `--allow-read` permission is required:

<!-- L34..34
**main.ts**
-->

**main.ts**

<!-- L36..38
```ts
new Worker(new URL("worker.ts", import.meta.url).href, { type: "module" });
```
-->

```ts
new Worker(new URL("worker.ts", import.meta.url).href, { type: "module" });
```

<!-- L40..40
**worker.ts**
-->

**worker.ts**

<!-- L42..45
```ts
console.log("hello world");
self.close();
```
-->

```ts
console.log("hello world");
self.close();
```

<!-- L47..53
```shell
$ deno run main.ts
error: Uncaught PermissionDenied: read access to "./worker.ts", run again with the --allow-read flag

$ deno run --allow-read main.ts
hello world
```
-->

```shell
$ deno run main.ts
error: Uncaught PermissionDenied: read access to "./worker.ts", run again with the --allow-read flag

$ deno run --allow-read main.ts
hello world
```

<!-- L55..55
For workers using remote modules; `--allow-net` permission is required:
-->

For workers using remote modules; `--allow-net` permission is required:

<!-- L57..57
**main.ts**
-->

**main.ts**

<!-- L59..61
```ts
new Worker("https://example.com/worker.ts", { type: "module" });
```
-->

```ts
new Worker("https://example.com/worker.ts", { type: "module" });
```

<!-- L63..63
**worker.ts** (at https[]()://example.com/worker.ts)
-->

**worker.ts** (at https[]()://example.com/worker.ts)

<!-- L65..68
```ts
console.log("hello world");
self.close();
```
-->

```ts
console.log("hello world");
self.close();
```

<!-- L70..76
```shell
$ deno run main.ts
error: Uncaught PermissionDenied: net access to "https://example.com/worker.ts", run again with the --allow-net flag

$ deno run --allow-net main.ts
hello world
```
-->

```shell
$ deno run main.ts
error: Uncaught PermissionDenied: net access to "https://example.com/worker.ts", run again with the --allow-net flag

$ deno run --allow-net main.ts
hello world
```

<!-- L78..78
### Using Deno in worker
-->

### Using Deno in worker

<!-- L80..81
> This is an unstable Deno feature. Learn more about
> [unstable features](./stability.md).
-->

> This is an unstable Deno feature. Learn more about
> [unstable features](./stability.md).

<!-- L83..83
By default the `Deno` namespace is not available in worker scope.
-->

By default the `Deno` namespace is not available in worker scope.

<!-- L85..85
To add the `Deno` namespace pass `deno: true` option when creating new worker:
-->

To add the `Deno` namespace pass `deno: true` option when creating new worker:

<!-- L87..87
**main.js**
-->

**main.js**

<!-- L89..95
```ts
const worker = new Worker(new URL("worker.js", import.meta.url).href, {
  type: "module",
  deno: true,
});
worker.postMessage({ filename: "./log.txt" });
```
-->

```ts
const worker = new Worker(new URL("worker.js", import.meta.url).href, {
  type: "module",
  deno: true,
});
worker.postMessage({ filename: "./log.txt" });
```

<!-- L97..97
**worker.js**
-->

**worker.js**

<!-- L99..106
```ts
self.onmessage = async (e) => {
  const { filename } = e.data;
  const text = await Deno.readTextFile(filename);
  console.log(text);
  self.close();
};
```
-->

```ts
self.onmessage = async (e) => {
  const { filename } = e.data;
  const text = await Deno.readTextFile(filename);
  console.log(text);
  self.close();
};
```

<!-- L108..108
**log.txt**
-->

**log.txt**

<!-- L110..112
```
hello world
```
-->

```
hello world
```

<!-- L114..117
```shell
$ deno run --allow-read --unstable main.js
hello world
```
-->

```shell
$ deno run --allow-read --unstable main.js
hello world
```

<!-- L119..120
When the `Deno` namespace is available in worker scope, the worker inherits its
parent process' permissions (the ones specified using `--allow-*` flags).
-->

When the `Deno` namespace is available in worker scope, the worker inherits its
parent process' permissions (the ones specified using `--allow-*` flags).

<!-- L122..122
We intend to make permissions configurable for workers.
-->

We intend to make permissions configurable for workers.
