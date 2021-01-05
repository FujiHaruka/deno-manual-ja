<!-- L1..1
# Handle OS Signals
-->

# Handle OS Signals

<!-- L3..4
> This program makes use of an unstable Deno feature. Learn more about
> [unstable features](../runtime/stability.md).
-->

> This program makes use of an unstable Deno feature. Learn more about
> [unstable features](../runtime/stability.md).

<!-- L6..6
## Concepts
-->

## Concepts

<!-- L8..13
- Use the `--unstable` flag to access new or unstable features in Deno
- [Deno.signal](https://doc.deno.land/builtin/unstable#Deno.signal) can be used
  to capture and monitor OS signals
- Use the `dispose()` function of the Deno.signal
  [SignalStream](https://doc.deno.land/builtin/unstable#Deno.SignalStream) to
  stop watching the signal
-->

- Use the `--unstable` flag to access new or unstable features in Deno
- [Deno.signal](https://doc.deno.land/builtin/unstable#Deno.signal) can be used
  to capture and monitor OS signals
- Use the `dispose()` function of the Deno.signal
  [SignalStream](https://doc.deno.land/builtin/unstable#Deno.SignalStream) to
  stop watching the signal

<!-- L15..15
## Async iterator example
-->

## Async iterator example

<!-- L17..17
You can use `Deno.signal()` function for handling OS signals:
-->

You can use `Deno.signal()` function for handling OS signals:

<!-- L19..28
```ts
/**
 * async-iterator-signal.ts
 */
console.log("Press Ctrl-C to trigger a SIGINT signal");
for await (const _ of Deno.signal(Deno.Signal.SIGINT)) {
  console.log("interrupted!");
  Deno.exit();
}
```
-->

```ts
/**
 * async-iterator-signal.ts
 */
console.log("Press Ctrl-C to trigger a SIGINT signal");
for await (const _ of Deno.signal(Deno.Signal.SIGINT)) {
  console.log("interrupted!");
  Deno.exit();
}
```

<!-- L30..30
Run with:
-->

Run with:

<!-- L32..34
```shell
deno run --unstable async-iterator-signal.ts
```
-->

```shell
deno run --unstable async-iterator-signal.ts
```

<!-- L36..36
## Promise based example
-->

## Promise based example

<!-- L38..38
`Deno.signal()` also works as a promise:
-->

`Deno.signal()` also works as a promise:

<!-- L40..48
```ts
/**
 * promise-signal.ts
 */
console.log("Press Ctrl-C to trigger a SIGINT signal");
await Deno.signal(Deno.Signal.SIGINT);
console.log("interrupted!");
Deno.exit();
```
-->

```ts
/**
 * promise-signal.ts
 */
console.log("Press Ctrl-C to trigger a SIGINT signal");
await Deno.signal(Deno.Signal.SIGINT);
console.log("interrupted!");
Deno.exit();
```

<!-- L50..50
Run with:
-->

Run with:

<!-- L52..54
```shell
deno run --unstable promise-signal.ts
```
-->

```shell
deno run --unstable promise-signal.ts
```

<!-- L56..56
## Stop watching signals
-->

## Stop watching signals

<!-- L58..59
If you want to stop watching the signal, you can use `dispose()` method of the
signal object:
-->

If you want to stop watching the signal, you can use `dispose()` method of the
signal object:

<!-- L61..75
```ts
/**
 * dispose-signal.ts
 */
const sig = Deno.signal(Deno.Signal.SIGINT);
setTimeout(() => {
  sig.dispose();
  console.log("No longer watching SIGINT signal");
}, 5000);

console.log("Watching SIGINT signals");
for await (const _ of sig) {
  console.log("interrupted");
}
```
-->

```ts
/**
 * dispose-signal.ts
 */
const sig = Deno.signal(Deno.Signal.SIGINT);
setTimeout(() => {
  sig.dispose();
  console.log("No longer watching SIGINT signal");
}, 5000);

console.log("Watching SIGINT signals");
for await (const _ of sig) {
  console.log("interrupted");
}
```

<!-- L77..77
Run with:
-->

Run with:

<!-- L79..81
```shell
deno run --unstable dispose-signal.ts
```
-->

```shell
deno run --unstable dispose-signal.ts
```

<!-- L83..83
The above for-await loop exits after 5 seconds when `sig.dispose()` is called.
-->

The above for-await loop exits after 5 seconds when `sig.dispose()` is called.
