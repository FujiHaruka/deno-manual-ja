<!-- L1..1
## Proxies
-->

## Proxies

<!-- L3..3
Deno supports proxies for module downloads and the Web standard `fetch` API.
-->

Deno supports proxies for module downloads and the Web standard `fetch` API.

<!-- L5..6
Proxy configuration is read from environmental variables: `HTTP_PROXY` and
`HTTPS_PROXY`.
-->

Proxy configuration is read from environmental variables: `HTTP_PROXY` and
`HTTPS_PROXY`.

<!-- L8..9
In case of Windows, if environment variables are not found Deno falls back to
reading proxies from registry.
-->

In case of Windows, if environment variables are not found Deno falls back to
reading proxies from registry.
