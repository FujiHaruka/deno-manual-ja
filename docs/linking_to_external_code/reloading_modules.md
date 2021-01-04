---
title: モジュールのリロード
sort: 1
---
<!-- L1..1
## Reloading modules
-->

## Reloading modules

<!-- L3..7
By default, a module in the cache will be reused without fetching or
re-compiling it. Sometimes this is not desirable and you can force deno to
refetch and recompile modules into the cache. You can invalidate your local
`DENO_DIR` cache using the `--reload` flag of the `deno cache` subcommand. It's
usage is described below:
-->

By default, a module in the cache will be reused without fetching or
re-compiling it. Sometimes this is not desirable and you can force deno to
refetch and recompile modules into the cache. You can invalidate your local
`DENO_DIR` cache using the `--reload` flag of the `deno cache` subcommand. It's
usage is described below:

<!-- L9..9
### To reload everything
-->

### To reload everything

<!-- L11..13
```ts
deno cache --reload my_module.ts
```
-->

```ts
deno cache --reload my_module.ts
```

<!-- L15..15
### To reload specific modules
-->

### To reload specific modules

<!-- L17..18
Sometimes we want to upgrade only some modules. You can control it by passing an
argument to a `--reload` flag.
-->

Sometimes we want to upgrade only some modules. You can control it by passing an
argument to a `--reload` flag.

<!-- L20..20
To reload all \$STD_VERSION standard modules
-->

To reload all \$STD_VERSION standard modules

<!-- L22..24
```ts
deno cache --reload=https://deno.land/std@$STD_VERSION my_module.ts
```
-->

```ts
deno cache --reload=https://deno.land/std@$STD_VERSION my_module.ts
```

<!-- L26..27
To reload specific modules (in this example - colors and file system copy) use a
comma to separate URLs
-->

To reload specific modules (in this example - colors and file system copy) use a
comma to separate URLs

<!-- L29..31
```ts
deno cache --reload=https://deno.land/std@$STD_VERSION/fs/copy.ts,https://deno.land/std@$STD_VERSION/fmt/colors.ts my_module.ts
```
-->

```ts
deno cache --reload=https://deno.land/std@$STD_VERSION/fs/copy.ts,https://deno.land/std@$STD_VERSION/fmt/colors.ts my_module.ts
```
