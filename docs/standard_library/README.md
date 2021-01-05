---
title: 標準ライブラリ
sort: 50
---
<!-- L1..1
# Standard library
-->

# Standard library

<!-- L3..4
Deno provides a set of standard modules that are audited by the core team and
are guaranteed to work with Deno.
-->

Deno provides a set of standard modules that are audited by the core team and
are guaranteed to work with Deno.

<!-- L6..6
Standard library is available at: https://deno.land/std/
-->

Standard library is available at: https://deno.land/std/

<!-- L8..8
## Versioning and stability
-->

## Versioning and stability

<!-- L10..13
Standard library is not yet stable and therefore it is versioned differently
than Deno. For latest release consult https://deno.land/std/ or
https://deno.land/std/version.ts. The standard library is released each time
Deno is released.
-->

Standard library is not yet stable and therefore it is versioned differently
than Deno. For latest release consult https://deno.land/std/ or
https://deno.land/std/version.ts. The standard library is released each time
Deno is released.

<!-- L15..18
We strongly suggest to always use imports with pinned version of standard
library to avoid unintended changes. For example, rather than linking to the
master branch of code, which may change at any time, potentially causing
compilation errors or unexpected behavior:
-->

We strongly suggest to always use imports with pinned version of standard
library to avoid unintended changes. For example, rather than linking to the
master branch of code, which may change at any time, potentially causing
compilation errors or unexpected behavior:

<!-- L20..23
```typescript
// imports from master, this should be avoided
import { copy } from "https://deno.land/std/fs/copy.ts";
```
-->

```typescript
// imports from master, this should be avoided
import { copy } from "https://deno.land/std/fs/copy.ts";
```

<!-- L25..26
instead, used a version of the std library which is immutable and will not
change:
-->

instead, used a version of the std library which is immutable and will not
change:

<!-- L28..31
```typescript
// imports from v0.50.0 of std, never changes
import { copy } from "https://deno.land/std@$STD_VERSION/fs/copy.ts";
```
-->

```typescript
// imports from v0.50.0 of std, never changes
import { copy } from "https://deno.land/std@$STD_VERSION/fs/copy.ts";
```

<!-- L33..33
## Troubleshooting
-->

## Troubleshooting

<!-- L35..35
Some of the modules provided in standard library use unstable Deno APIs.
-->

Some of the modules provided in standard library use unstable Deno APIs.

<!-- L37..39
Trying to run such modules without `--unstable` CLI flag ends up with a lot of
TypeScript errors suggesting that some APIs in the `Deno` namespace do not
exist:
-->

Trying to run such modules without `--unstable` CLI flag ends up with a lot of
TypeScript errors suggesting that some APIs in the `Deno` namespace do not
exist:

<!-- L41..46
```typescript
// main.ts
import { copy } from "https://deno.land/std@$STD_VERSION/fs/copy.ts";

copy("log.txt", "log-old.txt");
```
-->

```typescript
// main.ts
import { copy } from "https://deno.land/std@$STD_VERSION/fs/copy.ts";

copy("log.txt", "log-old.txt");
```

<!-- L48..63
```shell
$ deno run --allow-read --allow-write main.ts
Compile file:///dev/deno/main.ts
Download https://deno.land/std@$STD_VERSION/fs/copy.ts
Download https://deno.land/std@$STD_VERSION/fs/ensure_dir.ts
Download https://deno.land/std@$STD_VERSION/fs/_util.ts
error: TS2339 [ERROR]: Property 'utime' does not exist on type 'typeof Deno'.
    await Deno.utime(dest, statInfo.atime, statInfo.mtime);
               ~~~~~
    at https://deno.land/std@$STD_VERSION/fs/copy.ts:90:16

TS2339 [ERROR]: Property 'utimeSync' does not exist on type 'typeof Deno'.
    Deno.utimeSync(dest, statInfo.atime, statInfo.mtime);
         ~~~~~~~~~
    at https://deno.land/std@$STD_VERSION/fs/copy.ts:101:10
```
-->

```shell
$ deno run --allow-read --allow-write main.ts
Compile file:///dev/deno/main.ts
Download https://deno.land/std@$STD_VERSION/fs/copy.ts
Download https://deno.land/std@$STD_VERSION/fs/ensure_dir.ts
Download https://deno.land/std@$STD_VERSION/fs/_util.ts
error: TS2339 [ERROR]: Property 'utime' does not exist on type 'typeof Deno'.
    await Deno.utime(dest, statInfo.atime, statInfo.mtime);
               ~~~~~
    at https://deno.land/std@$STD_VERSION/fs/copy.ts:90:16

TS2339 [ERROR]: Property 'utimeSync' does not exist on type 'typeof Deno'.
    Deno.utimeSync(dest, statInfo.atime, statInfo.mtime);
         ~~~~~~~~~
    at https://deno.land/std@$STD_VERSION/fs/copy.ts:101:10
```

<!-- L65..65
Solution to that problem requires adding `--unstable` flag:
-->

Solution to that problem requires adding `--unstable` flag:

<!-- L67..69
```shell
deno run --allow-read --allow-write --unstable main.ts
```
-->

```shell
deno run --allow-read --allow-write --unstable main.ts
```

<!-- L71..73
To make sure that API producing error is unstable check
[`lib.deno.unstable.d.ts`](https://github.com/denoland/deno/blob/master/cli/dts/lib.deno.unstable.d.ts)
declaration.
-->

To make sure that API producing error is unstable check
[`lib.deno.unstable.d.ts`](https://github.com/denoland/deno/blob/master/cli/dts/lib.deno.unstable.d.ts)
declaration.

<!-- L75..76
This problem should be fixed in the near future. Feel free to omit the flag if
the particular modules you depend on compile successfully without it.
-->

This problem should be fixed in the near future. Feel free to omit the flag if
the particular modules you depend on compile successfully without it.
