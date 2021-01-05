<!-- L1..1
# TCP echo server
-->

# TCP echo server

<!-- L3..3
## Concepts
-->

## Concepts

<!-- L5..8
- Listening for TCP port connections with
  [Deno.listen](https://doc.deno.land/builtin/stable#Deno.listen)
- Use [Deno.copy](https://doc.deno.land/builtin/stable#Deno.copy) to take
  inbound data and redirect it to be outbound data
-->

- Listening for TCP port connections with
  [Deno.listen](https://doc.deno.land/builtin/stable#Deno.listen)
- Use [Deno.copy](https://doc.deno.land/builtin/stable#Deno.copy) to take
  inbound data and redirect it to be outbound data

<!-- L10..10
## Example
-->

## Example

<!-- L12..13
This is an example of a server which accepts connections on port 8080, and
returns to the client anything it sends.
-->

This is an example of a server which accepts connections on port 8080, and
returns to the client anything it sends.

<!-- L15..24
```ts
/**
 * echo_server.ts
 */
const listener = Deno.listen({ port: 8080 });
console.log("listening on 0.0.0.0:8080");
for await (const conn of listener) {
  Deno.copy(conn, conn);
}
```
-->

```ts
/**
 * echo_server.ts
 */
const listener = Deno.listen({ port: 8080 });
console.log("listening on 0.0.0.0:8080");
for await (const conn of listener) {
  Deno.copy(conn, conn);
}
```

<!-- L26..26
Run with:
-->

Run with:

<!-- L28..30
```shell
deno run --allow-net echo_server.ts
```
-->

```shell
deno run --allow-net echo_server.ts
```

<!-- L32..35
To test it, try sending data to it with
[netcat](https://en.wikipedia.org/wiki/Netcat) (Linux/MacOS only). Below
`'hello world'` is sent over the connection, which is then echoed back to the
user:
-->

To test it, try sending data to it with
[netcat](https://en.wikipedia.org/wiki/Netcat) (Linux/MacOS only). Below
`'hello world'` is sent over the connection, which is then echoed back to the
user:

<!-- L37..41
```shell
$ nc localhost 8080
hello world
hello world
```
-->

```shell
$ nc localhost 8080
hello world
hello world
```

<!-- L43..45
Like the [cat.ts example](./unix_cat.md), the `copy()` function here also does
not make unnecessary memory copies. It receives a packet from the kernel and
sends back, without further complexity.
-->

Like the [cat.ts example](./unix_cat.md), the `copy()` function here also does
not make unnecessary memory copies. It receives a packet from the kernel and
sends back, without further complexity.
