<!-- L1..1
# Hello world
-->

# Hello world

<!-- L3..3
## Concepts
-->

## Concepts

<!-- L5..6
- Deno can run JavaScript or TypeScript out of the box with no additional tools
  or config required
-->

- Deno can run JavaScript or TypeScript out of the box with no additional tools
  or config required

<!-- L8..8
## Overview
-->

## Overview

<!-- L10..12
Deno is a secure runtime for both JavaScript and TypeScript. As the hello world
examples below highlight the same functionality can be created in JavaScript or
TypeScript, and Deno will execute both.
-->

Deno is a secure runtime for both JavaScript and TypeScript. As the hello world
examples below highlight the same functionality can be created in JavaScript or
TypeScript, and Deno will execute both.

<!-- L14..14
## JavaScript
-->

## JavaScript

<!-- L16..17
In this JavaScript example the message `Hello [name]` is printed to the console
and the code ensures the name provided is capitalized.
-->

In this JavaScript example the message `Hello [name]` is printed to the console
and the code ensures the name provided is capitalized.

<!-- L19..19
**Command:** `deno run hello-world.js`
-->

**Command:** `deno run hello-world.js`

<!-- L21..44
```js
/**
 * hello-world.js
 */
function capitalize(word) {
  return word.charAt(0).toUpperCase() + word.slice(1);
}

function hello(name) {
  return "Hello " + capitalize(name);
}

console.log(hello("john"));
console.log(hello("Sarah"));
console.log(hello("kai"));

/**
 * Output:
 *
 * Hello John
 * Hello Sarah
 * Hello Kai
**/
```
-->

```js
/**
 * hello-world.js
 */
function capitalize(word) {
  return word.charAt(0).toUpperCase() + word.slice(1);
}

function hello(name) {
  return "Hello " + capitalize(name);
}

console.log(hello("john"));
console.log(hello("Sarah"));
console.log(hello("kai"));

/**
 * Output:
 *
 * Hello John
 * Hello Sarah
 * Hello Kai
**/
```

<!-- L46..46
## TypeScript
-->

## TypeScript

<!-- L48..49
This TypeScript example is exactly the same as the JavaScript example above, the
code just has the additional type information which TypeScript supports.
-->

This TypeScript example is exactly the same as the JavaScript example above, the
code just has the additional type information which TypeScript supports.

<!-- L51..52
The `deno run` command is exactly the same, it just references a `*.ts` file
rather than a `*.js` file.
-->

The `deno run` command is exactly the same, it just references a `*.ts` file
rather than a `*.js` file.

<!-- L54..54
**Command:** `deno run hello-world.ts`
-->

**Command:** `deno run hello-world.ts`

<!-- L56..79
```ts
/**
 * hello-world.ts
 */
function capitalize(word: string): string {
  return word.charAt(0).toUpperCase() + word.slice(1);
}

function hello(name: string): string {
  return "Hello " + capitalize(name);
}

console.log(hello("john"));
console.log(hello("Sarah"));
console.log(hello("kai"));

/**
 * Output:
 *
 * Hello John
 * Hello Sarah
 * Hello Kai
**/
```
-->

```ts
/**
 * hello-world.ts
 */
function capitalize(word: string): string {
  return word.charAt(0).toUpperCase() + word.slice(1);
}

function hello(name: string): string {
  return "Hello " + capitalize(name);
}

console.log(hello("john"));
console.log(hello("Sarah"));
console.log(hello("kai"));

/**
 * Output:
 *
 * Hello John
 * Hello Sarah
 * Hello Kai
**/
```
