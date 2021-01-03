---
title: パーミッション
sort: 5
---
<!-- L1..1
## Permissions
-->

## パーミッション

<!-- L3..6
Deno is secure by default. Therefore, unless you specifically enable it, a deno
module has no file, network, or environment access for example. Access to
security-sensitive areas or functions requires the use of permissions to be
granted to a deno process on the command line.
-->

Deno はデフォルトで安全です。そのため、明示的に許可しない限り Deno モジュールはたとえばファイル、ネットワーク、環境変数にアクセスできません。セキュリティ上重要な領域や機能にアクセスするにはコマンドラインで Deno プロセスに権限を与えるパーミッションを使う必要があります。

<!-- L8..10
For the following example, `mod.ts` has been granted read-only access to the
file system. It cannot write to it, or perform any other security-sensitive
functions.
-->

次の例では、`mod.ts` がファイルシステムに読み取り専用のアクセス権限を持ちます。書き込みはできませんし、他のセキュリティ上重要な機能は実行できません。

<!-- L12..14
```shell
deno run --allow-read mod.ts
```
-->

```shell
deno run --allow-read mod.ts
```

<!-- L16..16
### Permissions list
-->

### パーミッション一覧

<!-- L18..18
The following permissions are available:
-->

以下のパーミッションが利用できます。

<!-- L20..38
- **-A, --allow-all** Allow all permissions. This disables all security.
- **--allow-env** Allow environment access for things like getting and setting
  of environment variables.
- **--allow-hrtime** Allow high-resolution time measurement. High-resolution
  time can be used in timing attacks and fingerprinting.
- **--allow-net=\<allow-net\>** Allow network access. You can specify an
  optional, comma-separated list of domains to provide an allow-list of allowed
  domains.
- **--allow-plugin** Allow loading plugins. Please note that --allow-plugin is
  an unstable feature.
- **--allow-read=\<allow-read\>** Allow file system read access. You can specify
  an optional, comma-separated list of directories or files to provide a
  allow-list of allowed file system access.
- **--allow-run** Allow running subprocesses. Be aware that subprocesses are not
  run in a sandbox and therefore do not have the same security restrictions as
  the deno process. Therefore, use with caution.
- **--allow-write=\<allow-write\>** Allow file system write access. You can
  specify an optional, comma-separated list of directories or files to provide a
  allow-list of allowed file system access.
-->

- **-A, --allow-all** すべてのパーミッションを許可します。セキュリティをすべて解除します
- **--allow-env** 環境変数の取得や上書きなど、環境へのアクセスを許可します
- **--allow-hrtime** 高分解能の時間計測を許可します。高分解能の時間はタイミングアタックやフィンガープリンティングに使うことができます
- **--allow-net=\<allow-net\>** ネットワークアクセスを許可します。オプションで、許可するドメインのリストを与えるためにコンマ区切りのドメインリストを指定することができます
- **--allow-plugin** プラグインのロードを許可します。--allow-plugin は不安定な機能なので注意してください
- **--allow-read=\<allow-read\>** ファイルシステムの読み取りアクセスを許可します。
  オプションとして、コンマ区切りのディレクトリやファイル名のリストをファイルシステムへのアクセス許可リストとして指定できます
- **--allow-run** サブプロセスの実行を許可します。サブプロセスの実行はサンドボックス内で行われないため deno のプロセスと同じセキュリティ制約を受けません。そのため、使用時に警告が表示されます
- **--allow-write=\<allow-write\>** ファイルシステムの書き込みアクセスを許可します。オプションとして、コンマ区切りのディレクトリやファイル名のリストをファイルシステムへのアクセス許可リストとして指定できます

<!-- L40..40
### Permissions allow-list
-->

### 許可リストのパーミッション

<!-- L42..43
Deno also allows you to control the granularity of some permissions with
allow-lists.
-->

Deno ではいくつかのパーミッションに関して許可リストを使ってパーミッションの粒度を制御できます。

<!-- L45..47
This example restricts file system access by allow-listing only the `/usr`
directory, however the execution fails as the process was attempting to access a
file in the `/etc` directory:
-->

以下の例ではファイルシステムへのアクセスを制限するために `/usr` ディレクトリのみを許可リストに追加していますが、
プロセスが `/etc` ディレクトリのファイルにアクセスしようとして実行時に失敗しています。

<!-- L49..55
```shell
$ deno run --allow-read=/usr https://deno.land/std@$STD_VERSION/examples/cat.ts /etc/passwd
error: Uncaught PermissionDenied: read access to "/etc/passwd", run again with the --allow-read flag
► $deno$/dispatch_json.ts:40:11
    at DenoError ($deno$/errors.ts:20:5)
    ...
```
-->

```shell
$ deno run --allow-read=/usr https://deno.land/std@$STD_VERSION/examples/cat.ts /etc/passwd
error: Uncaught PermissionDenied: read access to "/etc/passwd", run again with the --allow-read flag
► $deno$/dispatch_json.ts:40:11
    at DenoError ($deno$/errors.ts:20:5)
    ...
```

<!-- L57..57
Try it out again with the correct permissions by allow-listing `/etc` instead:
-->

今度は許可リストに `/etc` を追加して正しいパーミッションで実行し直してみます。

<!-- L59..61
```shell
deno run --allow-read=/etc https://deno.land/std@$STD_VERSION/examples/cat.ts /etc/passwd
```
-->

```shell
deno run --allow-read=/etc https://deno.land/std@$STD_VERSION/examples/cat.ts /etc/passwd
```

<!-- L63..63
`--allow-write` works the same as `--allow-read`.
-->

`--allow-write` の動作は `--allow-read` と同様です。

<!-- L65..65
### Network access:
-->

### ネットワークアクセス

<!-- L67..67
_fetch.ts_:
-->

_fetch.ts_:

<!-- L69..71
```ts
const result = await fetch("https://deno.land/");
```
-->

```ts
const result = await fetch("https://deno.land/");
```

<!-- L73..73
This is an example of how to allow-list hosts/urls:
-->

以下はホストや URL を許可リストに指定する例です。

<!-- L75..77
```shell
deno run --allow-net=github.com,deno.land fetch.ts
```
-->

```shell
deno run --allow-net=github.com,deno.land fetch.ts
```

<!-- L79..80
If `fetch.ts` tries to establish network connections to any other domain, the
process will fail.
-->

If `fetch.ts` tries to establish network connections to any other domain, the
process will fail.
`fetch.ts` が他のドメインにネットワーク接続を試みるとプロセスは失敗します。

<!-- L82..82
Allow net calls to any host/url:
-->

任意のホストや URL とのネットワーク接続を許可することもできます。

<!-- L84..86
```shell
deno run --allow-net fetch.ts
```
-->

```shell
deno run --allow-net fetch.ts
```
