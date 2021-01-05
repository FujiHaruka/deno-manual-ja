<!-- L1..1
# File system events
-->

# File system events

<!-- L3..3
## Concepts
-->

## Concepts

<!-- L5..7
- Use [Deno.watchFs](https://doc.deno.land/builtin/stable#Deno.watchFs) to watch
  for file system events
- Results may vary between operating systems
-->

- Use [Deno.watchFs](https://doc.deno.land/builtin/stable#Deno.watchFs) to watch
  for file system events
- Results may vary between operating systems

<!-- L9..9
## Example
-->

## Example

<!-- L11..11
To poll for file system events in the current directory:
-->

To poll for file system events in the current directory:

<!-- L13..22
```ts
/**
 * watcher.ts
 */
const watcher = Deno.watchFs(".");
for await (const event of watcher) {
  console.log(">>>> event", event);
  // Example event: { kind: "create", paths: [ "/home/alice/deno/foo.txt" ] }
}
```
-->

```ts
/**
 * watcher.ts
 */
const watcher = Deno.watchFs(".");
for await (const event of watcher) {
  console.log(">>>> event", event);
  // Example event: { kind: "create", paths: [ "/home/alice/deno/foo.txt" ] }
}
```

<!-- L24..24
Run with:
-->

Run with:

<!-- L26..28
```shell
deno run --allow-read watcher.ts
```
-->

```shell
deno run --allow-read watcher.ts
```

<!-- L30..31
Now try adding, removing and modifying files in the same directory as
`watcher.ts`.
-->

Now try adding, removing and modifying files in the same directory as
`watcher.ts`.

<!-- L33..34
Note that the exact ordering of the events can vary between operating systems.
This feature uses different syscalls depending on the platform:
-->

Note that the exact ordering of the events can vary between operating systems.
This feature uses different syscalls depending on the platform:

<!-- L36..40
- Linux: [inotify](https://man7.org/linux/man-pages/man7/inotify.7.html)
- macOS:
  [FSEvents](https://developer.apple.com/library/archive/documentation/Darwin/Conceptual/FSEvents_ProgGuide/Introduction/Introduction.html)
- Windows:
  [ReadDirectoryChangesW](https://docs.microsoft.com/en-us/windows/win32/api/winbase/nf-winbase-readdirectorychangesw)
-->

- Linux: [inotify](https://man7.org/linux/man-pages/man7/inotify.7.html)
- macOS:
  [FSEvents](https://developer.apple.com/library/archive/documentation/Darwin/Conceptual/FSEvents_ProgGuide/Introduction/Introduction.html)
- Windows:
  [ReadDirectoryChangesW](https://docs.microsoft.com/en-us/windows/win32/api/winbase/nf-winbase-readdirectorychangesw)
