---
title: インストール
sort: 1
---
<!-- L1..1
## Installation
-->

## インストール

<!-- L3..4
Deno works on macOS, Linux, and Windows. Deno is a single binary executable. It
has no external dependencies.
-->

Deno は macOS、Linux、Windows 上で動作します。Deno は単一の実行可能なバイナリです。外部の依存関係がありません。

<!-- L6..6
### Download and install
-->

### ダウンロードとインストール

<!-- L8..9
[deno_install](https://github.com/denoland/deno_install) provides convenience
scripts to download and install the binary.
-->

[deno_install](https://github.com/denoland/deno_install) がバイナリとダウンロードとインストールを行う便利なスクリプトを提供します。

<!-- L11..11
Using Shell (macOS and Linux):
-->

Shell を使う場合 (macOS と Linux):

<!-- L13..15
```shell
curl -fsSL https://deno.land/x/install/install.sh | sh
```
-->

```shell
curl -fsSL https://deno.land/x/install/install.sh | sh
```

<!-- L17..17
Using PowerShell (Windows):
-->

PowerShell を使う場合 (Windows):

<!-- L19..21
```shell
iwr https://deno.land/x/install/install.ps1 -useb | iex
```
-->

```shell
iwr https://deno.land/x/install/install.ps1 -useb | iex
```

<!-- L23..23
Using [Scoop](https://scoop.sh/) (Windows):
-->

[Scoop](https://scoop.sh/) を使う場合 (Windows):


<!-- L25..27
```shell
scoop install deno
```
-->

```shell
scoop install deno
```

<!-- L29..29
Using [Chocolatey](https://chocolatey.org/packages/deno) (Windows):
-->

[Chocolatey](https://chocolatey.org/packages/deno) を使う場合 (Windows):

<!-- L31..33
```shell
choco install deno
```
-->

```shell
choco install deno
```

<!-- L35..35
Using [Homebrew](https://formulae.brew.sh/formula/deno) (macOS):
-->

[Homebrew](https://formulae.brew.sh/formula/deno) を使う場合 (macOS):

<!-- L37..39
```shell
brew install deno
```
-->

```shell
brew install deno
```

<!-- L41..41
Using [Cargo](https://crates.io/crates/deno) (Windows, macOS, Linux):
-->

[Cargo](https://crates.io/crates/deno) を使う場合 (Windows, macOS, Linux):

<!-- L43..45
```shell
cargo install deno
```
-->

```shell
cargo install deno
```

<!-- L47..50
Deno binaries can also be installed manually, by downloading a zip file at
[github.com/denoland/deno/releases](https://github.com/denoland/deno/releases).
These packages contain just a single executable file. You will have to set the
executable bit on macOS and Linux.
-->

Deno のバイナリは zip ファイルを [github.com/denoland/deno/releases](https://github.com/denoland/deno/releases) からダウンロードして手動でインストールすることもできます。
これらのパッケージはただ一つの実行可能ファイルを含みます。macOS と Linux ではファイルを実行可能にする必要があります。

<!-- L52..52
### Testing your installation
-->

### インストールを確認する

<!-- L54..55
To test your installation, run `deno --version`. If this prints the Deno version
to the console the installation was successful.
-->

インストールされたことを確認するには `deno --version` を実行してください。Deno のバージョンがコンソールに表示されたらインストールが成功しています。

<!-- L57..58
Use `deno help` to see help text documenting Deno's flags and usage. Get a
detailed guide on the CLI [here](./command_line_interface.md).
-->

Deno のフラグと使い方を書いたヘルプを確認するには `deno help` を使ってください。CLI の使い方の詳細は[ここ](./command_line_interface.md)を見てください。

<!-- L60..60
### Updating
-->

### 更新

<!-- L62..62
To update a previously installed version of Deno, you can run:
-->

インストール済の Deno のバージョンを更新するには、以下を実行してください。

<!-- L64..66
```shell
deno upgrade
```
-->

```shell
deno upgrade
```

<!-- L68..70
This will fetch the latest release from
[github.com/denoland/deno/releases](https://github.com/denoland/deno/releases),
unzip it, and replace your current executable with it.
-->

このコマンドは [github.com/denoland/deno/releases](https://github.com/denoland/deno/releases) から最新のリリースを取得して、zip 解凍したのち、現在の実行可能ファイルを置き換えます。

<!-- L72..72
You can also use this utility to install a specific version of Deno:
-->

Deno の特定のバージョンをインストールするには以下のユーティリティを使うこともできます。

<!-- L74..76
```shell
deno upgrade --version 1.0.1
```
-->

```shell
deno upgrade --version 1.0.1
```

<!-- L78..78
### Building from source
-->

### ソースからビルドする

<!-- L80..81
Information about how to build from source can be found in the `Contributing`
chapter.
-->

ソースからビルドする方法はコントリビューションの章で説明しています。
