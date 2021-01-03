---
title: TypeScript を使う
sort: 6
---
<!-- L1..1
## Using TypeScript
-->

## TypeScript を使う

<!-- L5..10
Deno supports both JavaScript and TypeScript as first class languages at
runtime. This means it requires fully qualified module names, including the
extension (or a server providing the correct media type). In addition, Deno has
no "magical" module resolution. Instead, imported modules are specified as files
(including extensions) or fully qualified URL imports. Typescript modules can be
directly imported. E.g.
-->

Deno は JavaScript と TypeScript の両方をランタイムの第一級の言語としてサポートしています。
この意味するところは、モジュール名に拡張子（または正確なメディアタイプを与えるサーバー）を含む完全修飾名を必要とするということです。
加えて、Deno は「魔法のような」モジュール解決を行いません。インポートされるモジュールは（拡張子を含む）ファイルとして指定するか、完全修飾 URL を指定します。
TypeScript モジュールをたとえば以下のように直接インポートできます。

<!-- L12..15
```
import { Response } from "https://deno.land/std@$STD_VERSION/http/server.ts";
import { queue } from "./collections.ts";
```
-->

```ts
import { Response } from "https://deno.land/std@$STD_VERSION/http/server.ts";
import { queue } from "./collections.ts";
```

<!-- L17..17
### `--no-check` option
-->

### `--no-check` オプション

<!-- L19..24
When using `deno run`, `deno test`, `deno cache`, or `deno bundle` you can
specify the `--no-check` flag to disable TypeScript type checking. This can
significantly reduce the time that program startup takes. This can be very
useful when type checking is provided by your editor and you want startup time
to be as fast as possible (for example when restarting the program automatically
with a file watcher).
-->

`deno run`、`deno test`、`deno cache`、`deno bundle` を使うとき、TypeScript の型チェックを無効にする `--no-check` フラグを指定できます。
このオプションを使うとプログラムが起動する時間を大幅に削減できます。
型チェックをエディタが行ってくれて起動時間をできるだけ高速にしたい（たとえばファイル監視を使ってプログラムを自動的に再起動するなどの）場面で大きく役立ちます。

<!-- L26..38
Because `--no-check` does not do TypeScript type checking we can not
automatically remove type only imports and exports as this would require type
information. For this purpose TypeScript provides the
[`import type` and `export type` syntax](https://www.typescriptlang.org/docs/handbook/release-notes/typescript-3-8.html#type-only-imports-and-exports).
To export a type in a different file use
`export type { AnInterface } from "./mod.ts";`. To import a type use
`import type { AnInterface } from "./mod.ts";`. You can check that you are using
`import type` and `export type` where necessary by setting the `isolatedModules`
TypeScript compiler option to `true`, and the `importsNotUsedAsValues` to
`error`. You can see an example `tsconfig.json` with this option
[in the standard library](https://github.com/denoland/deno/blob/master/std/tsconfig_test.json).
These settings will be enabled by default in the future. They are already the
default in Deno 1.4 or above when using `--unstable`.
-->

`--no-check` は TypeScript の型チェックを行わないため、型のみのインポート／エクスポートを自動的に除去することができません。それをするには型情報が必要だからです。
この目的のために TypeScript は [`import type` および `export type` の構文](https://www.typescriptlang.org/docs/handbook/release-notes/typescript-3-8.html#type-only-imports-and-exports)を提供しています。
別のファイルに型をエクスポートするには `export type { AnInterface } from "./mod.ts";` と書きます。
型をインポートするには `import type { AnInterface } from "./mod.ts";` と書きます。
`import type` と `export type` をどこかで使っていることを確認するには TypeScript のコンパイラオプション `isolatedModules` を `true` に設定し、`importsNotUsedAsValues` を `error` に設定します。
このオプションを設定した `tsconfig.json` の例は[標準ライブラリの設定](https://github.com/denoland/deno/blob/master/std/tsconfig_test.json)で見ることができます。
これらの設定は将来、デフォルトで有効化されます。すでに Deno 1.4 以上では `--unstable` にするとデフォルトで有効化されます。

<!-- L40..42
Because there is no type information when using `--no-check`, `const enum` is
not supported because it is type-directed. `--no-check` also does not support
the legacy `import =` and `export =` syntax.
-->

`--no-check` にすると型情報がないため 型指向の `const enum` はサポートされません。また、`--no-check` はレガシーな `import =` と `export =` の構文もサポートしません。

<!-- L44..44
### Using external type definitions
-->

### 外部の型定義を使う

<!-- L46..48
The out of the box TypeScript compiler though relies on both extension-less
modules and the Node.js module resolution logic to apply types to JavaScript
modules.
-->

組み込みの TypeScript コンパイラは JavaScript モジュールに型を適用するために拡張子なしのモジュールと Node.js モジュール解決ロジックに依存しています。

<!-- L50..51
In order to bridge this gap, Deno supports three ways of referencing type
definition files without having to resort to "magic" resolution.
-->

このギャップを埋めるため、Deno は「魔法のような」モジュール解決手段に訴えることなく型定義ファイルを参照する三つのやり方をサポートしています。

<!-- L53..53
#### Compiler hint
-->

#### コンパイラヒント

<!-- L55..62
If you are importing a JavaScript module, and you know where the type definition
for that module is located, you can specify the type definition at import. This
takes the form of a compiler hint. Compiler hints inform Deno the location of
`.d.ts` files and the JavaScript code that is imported that they relate to. The
hint is `@deno-types` and when specified the value will be used in the compiler
instead of the JavaScript module. For example, if you had `foo.js`, but you know
that alongside of it was `foo.d.ts` which was the types for the file, the code
would look like this:
-->

JavaScript モジュールをインポートしていてそのモジュールの型定義がどこにあるかを知っている場合には、型定義をインポート時に指定できます。
これはコンパイラヒントの形をとります。コンパイラヒントは Deno に `.d.ts` ファイルの場所とそれに紐付いてインポートされる JavaScript コードを教えます。
このヒントは `@deno-types` で、それが指定されると JavaScript モジュールのかわりにその値がコンパイラで使用されます。
たとえば、`foo.js` があってそのファイルの型が `foo.d.ts` だとわかっている場合、次のようなコードになります。

<!-- L64..67
```ts
// @deno-types="./foo.d.ts"
import * as foo from "./foo.js";
```
-->

```ts
// @deno-types="./foo.d.ts"
import * as foo from "./foo.js";
```

<!-- L69..71
The value follows the same resolution logic as importing a module, meaning the
file needs to have an extension and is relative to the current module. Remote
specifiers are also allowed.
-->

コンパイラヒントの値はモジュールのインポートと同じ解決ロジックが適用されます。つまりファイルに拡張子が必要で、現在のモジュールからの相対パスになります。リモートの指定も可能です。

<!-- L73..77
The hint affects the next `import` statement (or `export ... from` statement)
where the value of the `@deno-types` will be substituted at compile time instead
of the specified module. Like in the above example, the Deno compiler will load
`./foo.d.ts` instead of `./foo.js`. Deno will still load `./foo.js` when it runs
the program.
-->

コンパイラヒントが影響を与えるのは次に書かれた `inport` 文（または `export ... from` 文）で、指定されたモジュールをコンパイル時に `@deno-types` の値に置き換えます。上の例では Deno コンパイラは `./foo.js` でなく `./foo.d.ts` を読み込みます。プログラムの実行時には Deno は `./foo.js` を読み込みます。

<!-- L79..79
#### Triple-slash reference directive in JavaScript files
-->

#### JavaScript ファイル内のトリプルスラッシュ参照ディレクティブ

<!-- L81..86
If you are hosting modules which you want to be consumed by Deno, and you want
to inform Deno about the location of the type definitions, you can utilize a
triple-slash directive in the actual code. For example, if you have a JavaScript
module and you would like to provide Deno with the location of the type
definition which happens to be alongside that file, your JavaScript module named
`foo.js` might look like this:
-->

Deno で使いたいモジュールをホストしていて Deno に型定義の場所を教えたいとします。この場合、実際のコード内にトリプルスラッシュディレクティブを利用できます。たとえば JavaScript モジュールがあってそのファイルに付随する型定義ファイルの場所を Deno に教えたい場合、`foo.js` という名前の JavaScript モジュールを以下のように書くことができます。


<!-- L88..91
```js
/// <reference types="./foo.d.ts" />
export const foo = "foo";
```
-->

```js
/// <reference types="./foo.d.ts" />
export const foo = "foo";
```

<!-- L93..97
Deno will see this, and the compiler will use `foo.d.ts` when type checking the
file, though `foo.js` will be loaded at runtime. The resolution of the value of
the directive follows the same resolution logic as importing a module, meaning
the file needs to have an extension and is relative to the current file. Remote
specifiers are also allowed.
-->

Deno はこれを見て、コンパイラが `foo.d.ts` をそのファイルの型チェックに使います。とはいえ `foo.js` は実行時に読み込まれます。
ディレクティブの値はモジュールのインポートを解決するのと同じロジックで解決されます。つまりファイル名には拡張子が必要で、現在のファイルからの相対パスになります。リモートの指定も可能です。

<!-- L99..99
#### X-TypeScript-Types custom header
-->

#### X-TypeScript-Types カスタムヘッダー

<!-- L101..103
If you are hosting modules which you want to be consumed by Deno, and you want
to inform Deno the location of the type definitions, you can use a custom HTTP
header of `X-TypeScript-Types` to inform Deno of the location of that file.
-->

Deno で使いたいモジュールをホストしていて Deno に型定義の場所を教えたい場合、カスタム HTTP ヘッダーを使うことができます。
`X-TypeScript-Types` というヘッダーが Deno にそのファイルの場所を教えてくれます。

<!-- L105..108
The header works in the same way as the triple-slash reference mentioned above,
it just means that the content of the JavaScript file itself does not need to be
modified, and the location of the type definitions can be determined by the
server itself.
-->

ヘッダーは上で説明したトリプルスラッシュ参照と同じように動作します。JavaScript ファイルの中身自体を書き換える必要はなく、サーバーのレスポンスで型定義の場所を決定できます。

<!-- L110..110
**Not all type definitions are supported.**
-->

**すべての型定義がサポートされているわけではありません。**

<!-- L112..118
Deno will use the compiler hint to load the indicated `.d.ts` files, but some
`.d.ts` files contain unsupported features. Specifically, some `.d.ts` files
expect to be able to load or reference type definitions from other packages
using the module resolution logic. For example a type reference directive to
include `node`, expecting to resolve to some path like
`./node_modules/@types/node/index.d.ts`. Since this depends on non-relative
"magical" resolution, Deno cannot resolve this.
-->

Deno はコンパイラヒントによって指示された `.d.ts` ファイルを読み込みますが、なかにはサポートされていない機能を含む `.d.ts` ファイルもあります。
具体的には、ある `.d.ts` ファイルはモジュール解決ロジックを使って他のパッケージから型定義を読み込み、参照することが可能であることを期待しています。
たとえば、ある型参照ディレクティブは `node` を含み、`./node_modules/@types/node/index.d.ts` のようなパスに解決されることを期待しています。
これは相対パスでない「魔法のような」モジュール解決に依存しているため、Deno は解決できません。

<!-- L120..120
**Why not use the triple-slash type reference in TypeScript files?**
-->

**どうして TypeScript ファイル内のトリプルスラッシュ型参照を使わないのでしょうか？**

<!-- L122..125
The TypeScript compiler supports triple-slash directives, including a type
reference directive. If Deno used this, it would interfere with the behavior of
the TypeScript compiler. Deno only looks for the directive in JavaScript (and
JSX) files.
-->

TypeScript コンパイラは、型参照ディレクティブを含むトリプルスラッシュディレクティブをサポートしています。
Deno がこれを使用すると、TypeScript コンパイラの振る舞いを妨害してしまいます。
Deno は JavaScript （と JSX）ファイルのディレクティブだけを探すようにしています。

<!-- L127..127
### Custom TypeScript Compiler Options
-->

### TypeScript のコンパイラオプションをカスタマイズする

<!-- L129..132
In the Deno ecosystem, all strict flags are enabled in order to comply with
TypeScript's ideal of being `strict` by default. However, in order to provide a
way to support customization a configuration file such as `tsconfig.json` might
be provided to Deno on program execution.
-->

Deno のエコシステムでは、デフォルトでで `strict` であるべきという TypeScript の理想に従うためにすべての strict フラグが有効化されています。
けれども、カスタマイズをサポートする方法を提供するために `tsconfig.json` のような設定ファイルをプログラムの実行時に Deno に与えることができます。

<!-- L134..135
You need to explicitly tell Deno where to look for this configuration by setting
the `-c` (or `--config`) argument when executing your application.
-->

この設定ファイルの場所は Deno に明示的に教える必要があります。アプリケーションの実行時に `-c` （または `--config`）オプションを渡します。

<!-- L137..139
```shell
deno run -c tsconfig.json mod.ts
```
-->

```shell
deno run -c tsconfig.json mod.ts
```

<!-- L141..141
Following are the currently allowed settings and their default values in Deno:
-->

以下は Deno が現在許可している設定とそのデフォルト値です。

<!-- L143..179
```json
{
  "compilerOptions": {
    "allowJs": false,
    "allowUmdGlobalAccess": false,
    "allowUnreachableCode": false,
    "allowUnusedLabels": false,
    "alwaysStrict": true,
    "assumeChangesOnlyAffectDirectDependencies": false,
    "checkJs": false,
    "disableSizeLimit": false,
    "generateCpuProfile": "profile.cpuprofile",
    "jsx": "react",
    "jsxFactory": "React.createElement",
    "lib": [],
    "noFallthroughCasesInSwitch": false,
    "noImplicitAny": true,
    "noImplicitReturns": true,
    "noImplicitThis": true,
    "noImplicitUseStrict": false,
    "noStrictGenericChecks": false,
    "noUnusedLocals": false,
    "noUnusedParameters": false,
    "preserveConstEnums": false,
    "removeComments": false,
    "resolveJsonModule": true,
    "strict": true,
    "strictBindCallApply": true,
    "strictFunctionTypes": true,
    "strictNullChecks": true,
    "strictPropertyInitialization": true,
    "suppressExcessPropertyErrors": false,
    "suppressImplicitAnyIndexErrors": false,
    "useDefineForClassFields": false
  }
}
```
-->

```json
{
  "compilerOptions": {
    "allowJs": false,
    "allowUmdGlobalAccess": false,
    "allowUnreachableCode": false,
    "allowUnusedLabels": false,
    "alwaysStrict": true,
    "assumeChangesOnlyAffectDirectDependencies": false,
    "checkJs": false,
    "disableSizeLimit": false,
    "generateCpuProfile": "profile.cpuprofile",
    "jsx": "react",
    "jsxFactory": "React.createElement",
    "lib": [],
    "noFallthroughCasesInSwitch": false,
    "noImplicitAny": true,
    "noImplicitReturns": true,
    "noImplicitThis": true,
    "noImplicitUseStrict": false,
    "noStrictGenericChecks": false,
    "noUnusedLocals": false,
    "noUnusedParameters": false,
    "preserveConstEnums": false,
    "removeComments": false,
    "resolveJsonModule": true,
    "strict": true,
    "strictBindCallApply": true,
    "strictFunctionTypes": true,
    "strictNullChecks": true,
    "strictPropertyInitialization": true,
    "suppressExcessPropertyErrors": false,
    "suppressImplicitAnyIndexErrors": false,
    "useDefineForClassFields": false
  }
}
```

<!-- L181..182
For documentation on allowed values and use cases please visit the
[typescript docs](https://www.typescriptlang.org/docs/handbook/compiler-options.html).
-->

指定可能な値とユースケースに関するドキュメントは [TypeScript ドキュメント](https://www.typescriptlang.org/docs/handbook/compiler-options.html)を確認してください。

<!-- L184..185
**Note**: Any options not listed above are either not supported by Deno or are
listed as deprecated/experimental in the TypeScript documentation.
-->

**注意**: 上で列挙されていないオプションは Deno がサポートしていないか、あるいは TypeScript ドキュメントの中で非推奨／実験的なものです。
