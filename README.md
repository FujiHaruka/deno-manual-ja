# deno-manual-ja

[Deno Manual](https://deno.land/manual) の日本語翻訳プロジェクト。

## Contribution

Requirement

- Deno
- 翻訳支援ツールに Deno 製の [TransM](https://github.com/FujiHaruka/TransM) を使っています

プロジェクトの初期化:

```
$ git clone https://github.com/FujiHaruka/deno-manual-ja.git
$ cd deno-manual-ja
$ ./scripts/prepare
```

新たなファイルの翻訳を始めるには:

```
$ transm new deno/docs/path/to/doc.md docs/path/to/doc.md
```
