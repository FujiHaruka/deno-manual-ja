---
title: パーミッション API
sort: 3
---
<!-- L1..1
## Permission APIs
-->

## パーミッション API

<!-- L3..4
> This API is unstable. Learn more about
> [unstable features](../runtime/stability.md).
-->

> この API は unstable です。詳細は以下。
> [unstable な機能](../runtime/stability.md)

<!-- L6..8
Permissions are granted from the CLI when running the `deno` command. User code
will often assume its own set of required permissions, but there is no guarantee
during execution that the set of _granted_ permissions will align with this.
-->

パーミッションは `deno` コマンドの実行時に CLI から権限を与えられます。
ユーザーコードはそれを実行するために必要なひと揃いのパーミッションを仮定することがよくありますが、
コードの実行中に**許可された**パーミッションがそれに合致していることは保証されません。

<!-- L10..11
In some cases, ensuring a fault-tolerant program requires a way to interact with
the permission system at runtime.
-->

あるケースではフォールトトレラントなプログラムが実行時にパーミッションシステムと相互作用する仕組みを必要とすることがあります。

<!-- L13..13
### Permission descriptors
-->

### パーミッションディスクリプタ

<!-- L15..16
On the CLI, read permission for `/foo/bar` is represented as
`--allow-read=/foo/bar`. In runtime JS, it is represented as the following:
-->

`/foo/bar` に対する読み取りのパーミッションは、CLI において  `--allow-read=/foo/bar` と表されます。
JS ランタイムにおいてこれは以下のように表されます。

<!-- L18..20
```ts
const desc = { name: "read", path: "/foo/bar" };
```
-->

```ts
const desc = { name: "read", path: "/foo/bar" };
```

<!-- L22..22
Other examples:
-->

以下は他の例です。

<!-- L24..39
```ts
// Global write permission.
const desc1 = { name: "write" };

// Write permission to `$PWD/foo/bar`.
const desc2 = { name: "write", path: "foo/bar" };

// Global net permission.
const desc3 = { name: "net" };

// Net permission to 127.0.0.1:8000.
const desc4 = { name: "net", url: "127.0.0.1:8000" };

// High-resolution time permission.
const desc5 = { name: "hrtime" };
```
-->

```ts
// グローバルな書き込みパーミッション
const desc1 = { name: "write" };

// `$PWD/foo/bar` に対する書き込みパーミッション
const desc2 = { name: "write", path: "foo/bar" };

// グローバルなネット接続パーミッション
const desc3 = { name: "net" };

// 127.0.0.1:8000 に対するネット接続パーミッション
const desc4 = { name: "net", url: "127.0.0.1:8000" };

// 高分解能時間に対するパーミッション
const desc5 = { name: "hrtime" };
```

<!-- L41..41
### Query permissions
-->

### パーミッションのクエリ

<!-- L43..43
Check, by descriptor, if a permission is granted or not.
-->

ディスクリプタを使うと、あるパーミッションが許可されているかどうかを確認できます。

<!-- L45..59
```ts
// deno run --unstable --allow-read=/foo main.ts

const desc1 = { name: "read", path: "/foo" };
console.log(await Deno.permissions.query(desc1));
// PermissionStatus { state: "granted" }

const desc2 = { name: "read", path: "/foo/bar" };
console.log(await Deno.permissions.query(desc2));
// PermissionStatus { state: "granted" }

const desc3 = { name: "read", path: "/bar" };
console.log(await Deno.permissions.query(desc3));
// PermissionStatus { state: "prompt" }
```
-->

```ts
// deno run --unstable --allow-read=/foo main.ts

const desc1 = { name: "read", path: "/foo" };
console.log(await Deno.permissions.query(desc1));
// PermissionStatus { state: "granted" }

const desc2 = { name: "read", path: "/foo/bar" };
console.log(await Deno.permissions.query(desc2));
// PermissionStatus { state: "granted" }

const desc3 = { name: "read", path: "/bar" };
console.log(await Deno.permissions.query(desc3));
// PermissionStatus { state: "prompt" }
```

<!-- L61..61
### Permission states
-->

### パーミッションの状態

<!-- L63..67
A permission state can be either "granted", "prompt" or "denied". Permissions
which have been granted from the CLI will query to `{ state: "granted" }`. Those
which have not been granted query to `{ state: "prompt" }` by default, while
`{ state: "denied" }` reserved for those which have been explicitly refused.
This will come up in [Request permissions](#request-permissions).
-->

パーミッションの状態は "granted"、"prompt"、"denied" のいずれかになります。
CLI から許可されたパーミッションのクエリ結果は `{ state: "granted" }` となります。
許可されていないパーミッションのクエリ結果はデフォルトで `{ state: "prompt" }` となります。
`{ state: "denied" }` は明示的に拒否されたパーミッションのために予約されています。
これは[パーミッションのリクエスト](#request-permissions)で詳述します。

<!-- L69..69
### Permission strength
-->

### パーミッションの強さ

<!-- L71..73
The intuitive understanding behind the result of the second query in
[Query permissions](#query-permissions) is that read access was granted to
`/foo` and `/foo/bar` is within `/foo` so `/foo/bar` is allowed to be read.
-->

[パーミッションのクエリ](#query-permissions)の二番目のクエリ結果がどうしてこのようになるのかを直感的に説明すると、
`/foo` に対する読み取りアクセスが許可されていて`foo/bar` が `foo` の中にあるため、`foo/bar` の読み取りが許可されているということになります。

<!-- L75..77
We can also say that `desc1` is
_[stronger than](https://www.w3.org/TR/permissions/#ref-for-permissiondescriptor-stronger-than)_
`desc2`. This means that for any set of CLI-granted permissions:
-->

`desc1` は `desc2`
_[より強い](https://www.w3.org/TR/permissions/#ref-for-permissiondescriptor-stronger-than)_
とも言えます。これは CLI で許可される他のパーミッションについても同様です。

<!-- L79..80
1. If `desc1` queries to `{ state: "granted" }` then so must `desc2`.
2. If `desc2` queries to `{ state: "denied" }` then so must `desc1`.
-->

1. `desc1` のクエリ結果が `{ state: "granted" }` ならば `desc2` でも同じ結果になる
2. `desc2` のクエリ結果が `{ state: "denied" }` ならば `desc1` でも同じ結果になる

<!-- L82..82
More examples:
-->

他の例。

<!-- L84..92
```ts
const desc1 = { name: "write" };
// is stronger than
const desc2 = { name: "write", path: "/foo" };

const desc3 = { name: "net" };
// is stronger than
const desc4 = { name: "net", url: "127.0.0.1:8000" };
```
-->

```ts
const desc1 = { name: "write" };
// is stronger than
const desc2 = { name: "write", path: "/foo" };

const desc3 = { name: "net" };
// is stronger than
const desc4 = { name: "net", url: "127.0.0.1:8000" };
```

<!-- L94..94
### Request permissions
-->

### パーミッションのリクエスト

<!-- L96..96
Request an ungranted permission from the user via CLI prompt.
-->

ユーザーがまだ許可していないパーミッションは CLI プロンプトを通じてリクエストできます。

<!-- L98..112
```ts
// deno run --unstable main.ts

const desc1 = { name: "read", path: "/foo" };
const status1 = await Deno.permissions.request(desc1);
// ⚠️ Deno requests read access to "/foo". Grant? [g/d (g = grant, d = deny)] g
console.log(status1);
// PermissionStatus { state: "granted" }

const desc2 = { name: "read", path: "/bar" };
const status2 = await Deno.permissions.request(desc2);
// ⚠️ Deno requests read access to "/bar". Grant? [g/d (g = grant, d = deny)] d
console.log(status2);
// PermissionStatus { state: "denied" }
```
-->

```ts
// deno run --unstable main.ts

const desc1 = { name: "read", path: "/foo" };
const status1 = await Deno.permissions.request(desc1);
// ⚠️ Deno requests read access to "/foo". Grant? [g/d (g = grant, d = deny)] g
console.log(status1);
// PermissionStatus { state: "granted" }

const desc2 = { name: "read", path: "/bar" };
const status2 = await Deno.permissions.request(desc2);
// ⚠️ Deno requests read access to "/bar". Grant? [g/d (g = grant, d = deny)] d
console.log(status2);
// PermissionStatus { state: "denied" }
```

<!-- L114..118
If the current permission state is "prompt", a prompt will appear on the user's
terminal asking them if they would like to grant the request. The request for
`desc1` was granted so its new status is returned and execution will continue as
if `--allow-read=/foo` was specified on the CLI. The request for `desc2` was
denied so its permission state is downgraded from "prompt" to "denied".
-->

現在のパーミッション状態が "prompt" のとき、リクエストを許可してよいかどうかを尋ねるプロンプトがユーザーのターミナルに表示されます。
`desc1` のリクエストは許可されたため新しいステータスが返却され、CLI で `--allow-read=/foo` が指定されたのと同じ状態で実行が継続します。
`desc2` のリクエストは拒否されたためパーミッション状態は "prompt" から "denied" にダウングレードされます。

<!-- L120..123
If the current permission state is already either "granted" or "denied", the
request will behave like a query and just return the current status. This
prevents prompts both for already granted permissions and previously denied
requests.
-->

現在のパーミッション状態がすでに "granted" か "denied" になっていれば、リクエストはクエリと同じような振る舞いをして単に現在のステータスを返します。
これにより、すでに許可されたパーミッションと以前に拒否されたリクエストはプロンプトを表示せずに続行できます。

<!-- L125..125
### Revoke permissions
-->

### パーミッションの取り消し

<!-- L127..127
Downgrade a permission from "granted" to "prompt".
-->

パーミッションを "granted" から "prompt" にダウングレードできます。

<!-- L129..135
```ts
// deno run --unstable --allow-read=/foo main.ts

const desc = { name: "read", path: "/foo" };
console.log(await Deno.permissions.revoke(desc));
// PermissionStatus { state: "prompt" }
```
-->

```ts
// deno run --unstable --allow-read=/foo main.ts

const desc = { name: "read", path: "/foo" };
console.log(await Deno.permissions.revoke(desc));
// PermissionStatus { state: "prompt" }
```

<!-- L137..138
However, what happens when you try to revoke a permission which is _partial_ to
one granted on the CLI?
-->

けれども、CLI で許可されたパーミッションの _一部_ を取り消そうとする場合には何が起きるでしょうか。

<!-- L140..146
```ts
// deno run --unstable --allow-read=/foo main.ts

const desc = { name: "read", path: "/foo/bar" };
console.log(await Deno.permissions.revoke(desc));
// PermissionStatus { state: "granted" }
```
-->

```ts
// deno run --unstable --allow-read=/foo main.ts

const desc = { name: "read", path: "/foo/bar" };
console.log(await Deno.permissions.revoke(desc));
// PermissionStatus { state: "granted" }
```

<!-- L148..148
It was not revoked.
-->

取り消されませんでした。

<!-- L150..152
To understand this behaviour, imagine that Deno stores an internal set of
_explicitly granted permission descriptors_. Specifying `--allow-read=/foo,/bar`
on the CLI initializes this set to:
-->

この振る舞いを理解するには、Deno が _明示的に許可されたパーミッションディスクリプタ_ の集合を内部で保持していると想像してみてください。
CLI で `--allow-read=/foo,/bar` を指定するとこの集合が以下のように初期化されます。

<!-- L154..159
```ts
[
  { name: "read", path: "/foo" },
  { name: "read", path: "/bar" },
];
```
-->

```ts
[
  { name: "read", path: "/foo" },
  { name: "read", path: "/bar" },
];
```

<!-- L161..162
Granting a runtime request for `{ name: "write", path: "/foo" }` updates the set
to:
-->

実行時に `{ name: "write", path: "/foo" }` のリクエストを許可すると、この集合は次のように更新されます。

<!-- L164..170
```ts
[
  { name: "read", path: "/foo" },
  { name: "read", path: "/bar" },
  { name: "write", path: "/foo" },
];
```
-->

```ts
[
  { name: "read", path: "/foo" },
  { name: "read", path: "/bar" },
  { name: "write", path: "/foo" },
];
```

<!-- L172..175
Deno's permission revocation algorithm works by removing every element from this
set which the argument permission descriptor is _stronger than_. So to ensure
`desc` is not longer granted, pass an argument descriptor _stronger than_
whichever _explicitly granted permission descriptor_ is _stronger than_ `desc`.
-->

Deno のパーミッション取り消しアルゴリズムは、この集合の各要素を見て、引数で与えるパーミッションディスクリプタがその要素よりも強い場合にそれを取り除くという仕組みになっています。そのため `desc` をもう許可しないことを保証するには、 _より強い_ ディスクリプタを引数に与える必要があります。
_明示的に許可されたパーミッションディスクリプタ_ で `desc` _より強い_ ものであれば何でも構いません。

<!-- L177..189
```ts
// deno run --unstable --allow-read=/foo main.ts

const desc = { name: "read", path: "/foo/bar" };
console.log(await Deno.permissions.revoke(desc)); // Insufficient.
// PermissionStatus { state: "granted" }

const strongDesc = { name: "read", path: "/foo" };
await Deno.permissions.revoke(strongDesc); // Good.

console.log(await Deno.permissions.query(desc));
// PermissionStatus { state: "prompt" }
```
-->

```ts
// deno run --unstable --allow-read=/foo main.ts

const desc = { name: "read", path: "/foo/bar" };
console.log(await Deno.permissions.revoke(desc)); // Insufficient.
// PermissionStatus { state: "granted" }

const strongDesc = { name: "read", path: "/foo" };
await Deno.permissions.revoke(strongDesc); // Good.

console.log(await Deno.permissions.query(desc));
// PermissionStatus { state: "prompt" }
```
