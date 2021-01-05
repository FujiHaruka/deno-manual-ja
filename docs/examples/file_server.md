<!-- L1..1
# File server
-->

# File server

<!-- L3..3
## Concepts
-->

## Concepts

<!-- L5..9
- Use the Deno standard library
  [file_server.ts](https://deno.land/std@$STD_VERSION/http/file_server.ts) to
  run your own file server and access your files from your web browser
- Run [Deno install](../tools/script_installer.md) to install the file server
  locally
-->

- Use the Deno standard library
  [file_server.ts](https://deno.land/std@$STD_VERSION/http/file_server.ts) to
  run your own file server and access your files from your web browser
- Run [Deno install](../tools/script_installer.md) to install the file server
  locally

<!-- L11..11
## Example
-->

## Example

<!-- L13..15
Serve a local directory via HTTP. First install the remote script to your local
file system. This will install the script to the Deno installation root's bin
directory, e.g. `/home/alice/.deno/bin/file_server`.
-->

Serve a local directory via HTTP. First install the remote script to your local
file system. This will install the script to the Deno installation root's bin
directory, e.g. `/home/alice/.deno/bin/file_server`.

<!-- L17..19
```shell
deno install --allow-net --allow-read https://deno.land/std@$STD_VERSION/http/file_server.ts
```
-->

```shell
deno install --allow-net --allow-read https://deno.land/std@$STD_VERSION/http/file_server.ts
```

<!-- L21..21
You can now run the script with the simplified script name. Run it:
-->

You can now run the script with the simplified script name. Run it:

<!-- L23..28
```shell
$ file_server .
Downloading https://deno.land/std@$STD_VERSION/http/file_server.ts...
[...]
HTTP server listening on http://0.0.0.0:4507/
```
-->

```shell
$ file_server .
Downloading https://deno.land/std@$STD_VERSION/http/file_server.ts...
[...]
HTTP server listening on http://0.0.0.0:4507/
```

<!-- L30..31
Now go to [http://0.0.0.0:4507/](http://0.0.0.0:4507/) in your web browser to
see your local directory contents.
-->

Now go to [http://0.0.0.0:4507/](http://0.0.0.0:4507/) in your web browser to
see your local directory contents.

<!-- L33..33
## Help
-->

## Help

<!-- L35..35
Help and a complete list of options are available via:
-->

Help and a complete list of options are available via:

<!-- L37..39
```shell
file_server --help
```
-->

```shell
file_server --help
```

<!-- L41..41
Example output:
-->

Example output:

<!-- L43..63
```
Deno File Server
    Serves a local directory in HTTP.

  INSTALL:
    deno install --allow-net --allow-read https://deno.land/std/http/file_server.ts

  USAGE:
    file_server [path] [options]

  OPTIONS:
    -h, --help          Prints help information
    -p, --port <PORT>   Set port
    --cors              Enable CORS via the "Access-Control-Allow-Origin" header
    --host     <HOST>   Hostname (default is 0.0.0.0)
    -c, --cert <FILE>   TLS certificate file (enables TLS)
    -k, --key  <FILE>   TLS key file (enables TLS)
    --no-dir-listing    Disable directory listing

    All TLS options are required when one is provided.
```
-->

```
Deno File Server
    Serves a local directory in HTTP.

  INSTALL:
    deno install --allow-net --allow-read https://deno.land/std/http/file_server.ts

  USAGE:
    file_server [path] [options]

  OPTIONS:
    -h, --help          Prints help information
    -p, --port <PORT>   Set port
    --cors              Enable CORS via the "Access-Control-Allow-Origin" header
    --host     <HOST>   Hostname (default is 0.0.0.0)
    -c, --cert <FILE>   TLS certificate file (enables TLS)
    -k, --key  <FILE>   TLS key file (enables TLS)
    --no-dir-listing    Disable directory listing

    All TLS options are required when one is provided.
```
