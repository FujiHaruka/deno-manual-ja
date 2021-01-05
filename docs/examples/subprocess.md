<!-- L1..1
# Creating a subprocess
-->

# Creating a subprocess

<!-- L3..3
## Concepts
-->

## Concepts

<!-- L5..12
- Deno is capable of spawning a subprocess via
  [Deno.run](https://doc.deno.land/builtin/stable#Deno.run)
- `--allow-run` permission is required to spawn a subprocess
- Spawned subprocesses do not run in a security sandbox
- Communicate with the subprocess via the
  [stdin](https://doc.deno.land/builtin/stable#Deno.stdin),
  [stdout](https://doc.deno.land/builtin/stable#Deno.stdout) and
  [stderr](https://doc.deno.land/builtin/stable#Deno.stderr) streams
-->

- Deno is capable of spawning a subprocess via
  [Deno.run](https://doc.deno.land/builtin/stable#Deno.run)
- `--allow-run` permission is required to spawn a subprocess
- Spawned subprocesses do not run in a security sandbox
- Communicate with the subprocess via the
  [stdin](https://doc.deno.land/builtin/stable#Deno.stdin),
  [stdout](https://doc.deno.land/builtin/stable#Deno.stdout) and
  [stderr](https://doc.deno.land/builtin/stable#Deno.stderr) streams

<!-- L14..14
## Simple example
-->

## Simple example

<!-- L16..16
This example is the equivalent of running `'echo hello'` from the command line.
-->

This example is the equivalent of running `'echo hello'` from the command line.

<!-- L18..30
```ts
/**
 * subprocess_simple.ts
 */

// create subprocess
const p = Deno.run({
  cmd: ["echo", "hello"],
});

// await its completion
await p.status();
```
-->

```ts
/**
 * subprocess_simple.ts
 */

// create subprocess
const p = Deno.run({
  cmd: ["echo", "hello"],
});

// await its completion
await p.status();
```

<!-- L32..32
Run it:
-->

Run it:

<!-- L34..37
```shell
$ deno run --allow-run ./subprocess_simple.ts
hello
```
-->

```shell
$ deno run --allow-run ./subprocess_simple.ts
hello
```

<!-- L39..39
## Security
-->

## Security

<!-- L41..43
The `--allow-run` permission is required for creation of a subprocess. Be aware
that subprocesses are not run in a Deno sandbox and therefore have the same
permissions as if you were to run the command from the command line yourself.
-->

The `--allow-run` permission is required for creation of a subprocess. Be aware
that subprocesses are not run in a Deno sandbox and therefore have the same
permissions as if you were to run the command from the command line yourself.

<!-- L45..45
## Communicating with subprocesses
-->

## Communicating with subprocesses

<!-- L47..49
By default when you use `Deno.run()` the subprocess inherits `stdin`, `stdout`
and `stderr` of the parent process. If you want to communicate with started
subprocess you can use `"piped"` option.
-->

By default when you use `Deno.run()` the subprocess inherits `stdin`, `stdout`
and `stderr` of the parent process. If you want to communicate with started
subprocess you can use `"piped"` option.

<!-- L51..81
```ts
/**
 * subprocess.ts
 */
const fileNames = Deno.args;

const p = Deno.run({
  cmd: [
    "deno",
    "run",
    "--allow-read",
    "https://deno.land/std@$STD_VERSION/examples/cat.ts",
    ...fileNames,
  ],
  stdout: "piped",
  stderr: "piped",
});

const { code } = await p.status();

if (code === 0) {
  const rawOutput = await p.output();
  await Deno.stdout.write(rawOutput);
} else {
  const rawError = await p.stderrOutput();
  const errorString = new TextDecoder().decode(rawError);
  console.log(errorString);
}

Deno.exit(code);
```
-->

```ts
/**
 * subprocess.ts
 */
const fileNames = Deno.args;

const p = Deno.run({
  cmd: [
    "deno",
    "run",
    "--allow-read",
    "https://deno.land/std@$STD_VERSION/examples/cat.ts",
    ...fileNames,
  ],
  stdout: "piped",
  stderr: "piped",
});

const { code } = await p.status();

if (code === 0) {
  const rawOutput = await p.output();
  await Deno.stdout.write(rawOutput);
} else {
  const rawError = await p.stderrOutput();
  const errorString = new TextDecoder().decode(rawError);
  console.log(errorString);
}

Deno.exit(code);
```

<!-- L83..83
When you run it:
-->

When you run it:

<!-- L85..95
```shell
$ deno run --allow-run ./subprocess.ts <somefile>
[file content]

$ deno run --allow-run ./subprocess.ts non_existent_file.md

Uncaught NotFound: No such file or directory (os error 2)
    at DenoError (deno/js/errors.ts:22:5)
    at maybeError (deno/js/errors.ts:41:12)
    at handleAsyncMsgFromRust (deno/js/dispatch.ts:27:17)
```
-->

```shell
$ deno run --allow-run ./subprocess.ts <somefile>
[file content]

$ deno run --allow-run ./subprocess.ts non_existent_file.md

Uncaught NotFound: No such file or directory (os error 2)
    at DenoError (deno/js/errors.ts:22:5)
    at maybeError (deno/js/errors.ts:41:12)
    at handleAsyncMsgFromRust (deno/js/dispatch.ts:27:17)
```