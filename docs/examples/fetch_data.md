<!-- L1..1
# Fetch data
-->

# Fetch data

<!-- L3..3
## Concepts
-->

## Concepts

<!-- L5..9
- Like browsers, Deno implements web standard APIs such as
  [fetch](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API).
- Deno is secure by default, meaning explicit permission must be granted to
  access the network
- See also: Deno's [permissions](../getting_started/permissions.md) model
-->

- Like browsers, Deno implements web standard APIs such as
  [fetch](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API).
- Deno is secure by default, meaning explicit permission must be granted to
  access the network
- See also: Deno's [permissions](../getting_started/permissions.md) model

<!-- L11..11
## Overview
-->

## Overview

<!-- L13..17
When building any sort of web application developers will usually need to
retrieve data from somewhere else on the web. This works no differently in Deno
than in any other JavaScript application, just call the the `fetch()` method.
For more information on fetch read the
[MDN documentation](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API).
-->

When building any sort of web application developers will usually need to
retrieve data from somewhere else on the web. This works no differently in Deno
than in any other JavaScript application, just call the the `fetch()` method.
For more information on fetch read the
[MDN documentation](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API).

<!-- L19..23
The exception with Deno occurs when running a script which makes a call over the
web. Deno is secure by default which means access to IO (Input / Output) is
prohibited. To make a call over the web Deno must be explicitly told it is ok to
do so. This is achieved by adding the `--allow-net` flag to the `deno run`
command.
-->

The exception with Deno occurs when running a script which makes a call over the
web. Deno is secure by default which means access to IO (Input / Output) is
prohibited. To make a call over the web Deno must be explicitly told it is ok to
do so. This is achieved by adding the `--allow-net` flag to the `deno run`
command.

<!-- L25..25
## Example
-->

## Example

<!-- L27..27
**Command:** `deno run --allow-net fetch.ts`
-->

**Command:** `deno run --allow-net fetch.ts`

<!-- L29..58
```js
/**
 * Output: JSON Data
 */
const json = fetch("https://api.github.com/users/denoland");

json.then((response) => {
  return response.json();
}).then((jsonData) => {
  console.log(jsonData);
});

/**
 * Output: HTML Data
 */
const text = fetch("https://deno.land/");

text.then((response) => {
  return response.text();
}).then((textData) => {
  console.log(textData);
});

/**
 * Output: Error Message
 */
const error = fetch("https://does.not.exist/");

error.catch((error) => console.log(error.message));
```
-->

```js
/**
 * Output: JSON Data
 */
const json = fetch("https://api.github.com/users/denoland");

json.then((response) => {
  return response.json();
}).then((jsonData) => {
  console.log(jsonData);
});

/**
 * Output: HTML Data
 */
const text = fetch("https://deno.land/");

text.then((response) => {
  return response.text();
}).then((textData) => {
  console.log(textData);
});

/**
 * Output: Error Message
 */
const error = fetch("https://does.not.exist/");

error.catch((error) => console.log(error.message));
```
