---
title: プロキシ
sort: 3
---
<!-- L1..1
## Proxies
-->

## プロキシ

<!-- L3..3
Deno supports proxies for module downloads and the Web standard `fetch` API.
-->

Deno はモジュールのダウンロードと Web 標準の `fetch` API のためにプロキシをサポートしています。

<!-- L5..6
Proxy configuration is read from environmental variables: `HTTP_PROXY` and
`HTTPS_PROXY`.
-->

プロキシの設定は環境変数 `HTTP_PROXY` と `HTTPS_PROXY` から読み込まれます。

<!-- L8..9
In case of Windows, if environment variables are not found Deno falls back to
reading proxies from registry.
-->

Windows の場合は環境変数が見つからなければ Deno はレジストリからプロキシを読み込むようにフォールバックします。
