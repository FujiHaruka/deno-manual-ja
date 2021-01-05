<!-- L1..1
## Import maps
-->

## Import maps

<!-- L3..4
> This is an unstable feature. Learn more about
> [unstable features](../runtime/stability.md).
-->

> This is an unstable feature. Learn more about
> [unstable features](../runtime/stability.md).

<!-- L6..6
Deno supports [import maps](https://github.com/WICG/import-maps).
-->

Deno supports [import maps](https://github.com/WICG/import-maps).

<!-- L8..8
You can use import maps with the `--importmap=<FILE>` CLI flag.
-->

You can use import maps with the `--importmap=<FILE>` CLI flag.

<!-- L10..10
Current limitations:
-->

Current limitations:

<!-- L12..15
- single import map
- no fallback URLs
- Deno does not support `std:` namespace
- supports only `file:`, `http:` and `https:` schemes
-->

- single import map
- no fallback URLs
- Deno does not support `std:` namespace
- supports only `file:`, `http:` and `https:` schemes

<!-- L17..17
Example:
-->

Example:

<!-- L19..19
**import_map.json**
-->

**import_map.json**

<!-- L21..27
```js
{
   "imports": {
      "fmt/": "https://deno.land/std@$STD_VERSION/fmt/"
   }
}
```
-->

```js
{
   "imports": {
      "fmt/": "https://deno.land/std@$STD_VERSION/fmt/"
   }
}
```

<!-- L29..29
**color.ts**
-->

**color.ts**

<!-- L31..35
```ts
import { red } from "fmt/colors.ts";

console.log(red("hello world"));
```
-->

```ts
import { red } from "fmt/colors.ts";

console.log(red("hello world"));
```

<!-- L37..37
Then:
-->

Then:

<!-- L39..41
```shell
$ deno run --importmap=import_map.json --unstable color.ts
```
-->

```shell
$ deno run --importmap=import_map.json --unstable color.ts
```

<!-- L43..43
To use starting directory for absolute imports:
-->

To use starting directory for absolute imports:

<!-- L45..53
```json
// import_map.json

{
  "imports": {
    "/": "./"
  }
}
```
-->

```json
// import_map.json

{
  "imports": {
    "/": "./"
  }
}
```

<!-- L55..59
```ts
// main.ts

import { MyUtil } from "/util.ts";
```
-->

```ts
// main.ts

import { MyUtil } from "/util.ts";
```

<!-- L61..61
You may map a different directory: (eg. src)
-->

You may map a different directory: (eg. src)

<!-- L63..71
```json
// import_map.json

{
  "imports": {
    "/": "./src"
  }
}
```
-->

```json
// import_map.json

{
  "imports": {
    "/": "./src"
  }
}
```
