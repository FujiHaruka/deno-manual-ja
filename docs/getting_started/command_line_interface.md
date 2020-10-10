<!-- L1..1
## Command line interface
-->

## Command line interface

<!-- L3..5
Deno is a command line program. You should be familiar with some simple commands
having followed the examples thus far and already understand the basics of shell
usage.
-->

Deno is a command line program. You should be familiar with some simple commands
having followed the examples thus far and already understand the basics of shell
usage.

<!-- L7..7
There are multiple ways of viewing the main help text:
-->

There are multiple ways of viewing the main help text:

<!-- L9..18
```shell
# Using the subcommand.
deno help

# Using the short flag -- outputs the same as above.
deno -h

# Using the long flag -- outputs more detailed help text where available.
deno --help
```
-->

```shell
# Using the subcommand.
deno help

# Using the short flag -- outputs the same as above.
deno -h

# Using the long flag -- outputs more detailed help text where available.
deno --help
```

<!-- L20..22
Deno's CLI is subcommand-based. The above commands should show you a list of
those supported, such as `deno bundle`. To see subcommand-specific help for
`bundle`, you can similarly run one of:
-->

Deno's CLI is subcommand-based. The above commands should show you a list of
those supported, such as `deno bundle`. To see subcommand-specific help for
`bundle`, you can similarly run one of:

<!-- L24..28
```shell
deno help bundle
deno bundle -h
deno bundle --help
```
-->

```shell
deno help bundle
deno bundle -h
deno bundle --help
```

<!-- L30..30
Detailed guides to each subcommand can be found [here](../tools.md).
-->

Detailed guides to each subcommand can be found [here](../tools.md).

<!-- L32..32
### Script source
-->

### Script source

<!-- L34..36
Deno can grab the scripts from multiple sources, a filename, a url, and '-' to
read the file from stdin. The last is useful for integration with other
applications.
-->

Deno can grab the scripts from multiple sources, a filename, a url, and '-' to
read the file from stdin. The last is useful for integration with other
applications.

<!-- L38..42
```shell
deno run main.ts
deno run https://mydomain.com/main.ts
cat main.ts | deno run -
```
-->

```shell
deno run main.ts
deno run https://mydomain.com/main.ts
cat main.ts | deno run -
```

<!-- L44..44
### Script arguments
-->

### Script arguments

<!-- L46..47
Separately from the Deno runtime flags, you can pass user-space arguments to the
script you are running by specifying them after the script name:
-->

Separately from the Deno runtime flags, you can pass user-space arguments to the
script you are running by specifying them after the script name:

<!-- L49..51
```shell
deno run main.ts a b -c --quiet
```
-->

```shell
deno run main.ts a b -c --quiet
```

<!-- L53..56
```ts
// main.ts
console.log(Deno.args); // [ "a", "b", "-c", "--quiet" ]
```
-->

```ts
// main.ts
console.log(Deno.args); // [ "a", "b", "-c", "--quiet" ]
```

<!-- L58..60
**Note that anything passed after the script name will be passed as a script
argument and not consumed as a Deno runtime flag.** This leads to the following
pitfall:
-->

**Note that anything passed after the script name will be passed as a script
argument and not consumed as a Deno runtime flag.** This leads to the following
pitfall:

<!-- L62..68
```shell
# Good. We grant net permission to net_client.ts.
deno run --allow-net net_client.ts

# Bad! --allow-net was passed to Deno.args, throws a net permission error.
deno run net_client.ts --allow-net
```
-->

```shell
# Good. We grant net permission to net_client.ts.
deno run --allow-net net_client.ts

# Bad! --allow-net was passed to Deno.args, throws a net permission error.
deno run net_client.ts --allow-net
```

<!-- L70..70
Some see it as unconventional that:
-->

Some see it as unconventional that:

<!-- L72..72
> a non-positional flag is parsed differently depending on its position.
-->

> a non-positional flag is parsed differently depending on its position.

<!-- L74..74
However:
-->

However:

<!-- L76..83
1. This is the most logical way of distinguishing between runtime flags and
   script arguments.
2. This is the most ergonomic way of distinguishing between runtime flags and
   script arguments.
3. This is, in fact, the same behaviour as that of any other popular runtime.
   - Try `node -c index.js` and `node index.js -c`. The first will only do a
     syntax check on `index.js` as per Node's `-c` flag. The second will
     _execute_ `index.js` with `-c` passed to `require("process").argv`.
-->

1. This is the most logical way of distinguishing between runtime flags and
   script arguments.
2. This is the most ergonomic way of distinguishing between runtime flags and
   script arguments.
3. This is, in fact, the same behaviour as that of any other popular runtime.
   - Try `node -c index.js` and `node index.js -c`. The first will only do a
     syntax check on `index.js` as per Node's `-c` flag. The second will
     _execute_ `index.js` with `-c` passed to `require("process").argv`.

<!-- L85..85
---
-->

---

<!-- L87..88
There exist logical groups of flags that are shared between related subcommands.
We discuss these below.
-->

There exist logical groups of flags that are shared between related subcommands.
We discuss these below.

<!-- L90..90
### Watch mode
-->

### Watch mode

<!-- L92..95
You can supply the `--watch` flag to `deno run` to enable the built in file
watcher. When Deno starts up with this flag it watches the entrypoint, and all
local files the entrypoint statically imports. Whenever one of these files is
changed on disk, the program will automatically be restarted.
-->

You can supply the `--watch` flag to `deno run` to enable the built in file
watcher. When Deno starts up with this flag it watches the entrypoint, and all
local files the entrypoint statically imports. Whenever one of these files is
changed on disk, the program will automatically be restarted.

<!-- L97..97
### Integrity flags
-->

### Integrity flags

<!-- L99..100
Affect commands which can download resources to the cache: `deno cache`,
`deno run` and `deno test`.
-->

Affect commands which can download resources to the cache: `deno cache`,
`deno run` and `deno test`.

<!-- L102..105
```
--lock <FILE>    Check the specified lock file
--lock-write     Write lock file. Use with --lock.
```
-->

```
--lock <FILE>    Check the specified lock file
--lock-write     Write lock file. Use with --lock.
```

<!-- L107..108
Find out more about these
[here](../linking_to_external_code/integrity_checking.md).
-->

Find out more about these
[here](../linking_to_external_code/integrity_checking.md).

<!-- L110..110
### Cache and compilation flags
-->

### Cache and compilation flags

<!-- L112..114
Affect commands which can populate the cache: `deno cache`, `deno run` and
`deno test`. As well as the flags above this includes those which affect module
resolution, compilation configuration etc.
-->

Affect commands which can populate the cache: `deno cache`, `deno run` and
`deno test`. As well as the flags above this includes those which affect module
resolution, compilation configuration etc.

<!-- L116..122
```
--config <FILE>               Load tsconfig.json configuration file
--importmap <FILE>            UNSTABLE: Load import map file
--no-remote                   Do not resolve remote modules
--reload=<CACHE_BLOCKLIST>    Reload source code cache (recompile TypeScript)
--unstable                    Enable unstable APIs
```
-->

```
--config <FILE>               Load tsconfig.json configuration file
--importmap <FILE>            UNSTABLE: Load import map file
--no-remote                   Do not resolve remote modules
--reload=<CACHE_BLOCKLIST>    Reload source code cache (recompile TypeScript)
--unstable                    Enable unstable APIs
```

<!-- L124..124
### Runtime flags
-->

### Runtime flags

<!-- L126..127
Affect commands which execute user code: `deno run` and `deno test`. These
include all of the above as well as the following.
-->

Affect commands which execute user code: `deno run` and `deno test`. These
include all of the above as well as the following.

<!-- L129..129
#### Permission flags
-->

#### Permission flags

<!-- L131..131
These are listed [here](./permissions.md#permissions-list).
-->

These are listed [here](./permissions.md#permissions-list).

<!-- L133..133
#### Other runtime flags
-->

#### Other runtime flags

<!-- L135..135
More flags which affect the execution environment.
-->

More flags which affect the execution environment.

<!-- L137..143
```
--cached-only                Require that remote dependencies are already cached
--inspect=<HOST:PORT>        activate inspector on host:port ...
--inspect-brk=<HOST:PORT>    activate inspector on host:port and break at ...
--seed <NUMBER>              Seed Math.random()
--v8-flags=<v8-flags>        Set V8 command line options. For help: ...
```
-->

```
--cached-only                Require that remote dependencies are already cached
--inspect=<HOST:PORT>        activate inspector on host:port ...
--inspect-brk=<HOST:PORT>    activate inspector on host:port and break at ...
--seed <NUMBER>              Seed Math.random()
--v8-flags=<v8-flags>        Set V8 command line options. For help: ...
```
