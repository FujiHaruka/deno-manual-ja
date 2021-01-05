<!-- L1..1
# Simple HTTP web server
-->

# Simple HTTP web server

<!-- L3..3
## Concepts
-->

## Concepts

<!-- L5..6
- Use the std library [http module](https://deno.land/std@$STD_VERSION/http) to
  run your own web server
-->

- Use the std library [http module](https://deno.land/std@$STD_VERSION/http) to
  run your own web server

<!-- L8..8
## Overview
-->

## Overview

<!-- L10..11
With just a few lines of code you can run your own http web server with control
over the response status, request headers and more.
-->

With just a few lines of code you can run your own http web server with control
over the response status, request headers and more.

<!-- L13..13
## Sample web server
-->

## Sample web server

<!-- L15..15
In this example, the user-agent of the client is returned to the client
-->

In this example, the user-agent of the client is returned to the client

<!-- L17..32
```typescript
/** 
 * webserver.ts 
 */
import { serve } from "https://deno.land/std@$STD_VERSION/http/server.ts";

const server = serve({ hostname: "0.0.0.0", port: 8080 });
console.log(`HTTP webserver running.  Access it at:  http://localhost:8080/`);

for await (const request of server) {
  let bodyContent = "Your user-agent is:\n\n";
  bodyContent += request.headers.get("user-agent") || "Unknown";

  request.respond({ status: 200, body: bodyContent });
}
```
-->

```typescript
/** 
 * webserver.ts 
 */
import { serve } from "https://deno.land/std@$STD_VERSION/http/server.ts";

const server = serve({ hostname: "0.0.0.0", port: 8080 });
console.log(`HTTP webserver running.  Access it at:  http://localhost:8080/`);

for await (const request of server) {
  let bodyContent = "Your user-agent is:\n\n";
  bodyContent += request.headers.get("user-agent") || "Unknown";

  request.respond({ status: 200, body: bodyContent });
}
```

<!-- L34..34
Run this with:
-->

Run this with:

<!-- L36..38
```shell
deno run --allow-net webserver.ts
```
-->

```shell
deno run --allow-net webserver.ts
```
