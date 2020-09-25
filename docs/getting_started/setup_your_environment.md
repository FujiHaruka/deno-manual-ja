---
title: 環境のセットアップ
sort: 20
---
<!-- L1..1
## Set up your environment
-->

## 環境のセットアップ

<!-- L3..5
To productively get going with Deno you should set up your environment. This
means setting up shell autocomplete, environmental variables and your editor or
IDE of choice.
-->

Deno で生産的に開発するには環境のセットアップをしておくとよいでしょう。シェルの自動補完、環境変数、エディタや IDE の設定などです。

<!-- L7..7
### Environmental variables
-->

### 環境変数

<!-- L9..9
There are several env vars that control how Deno behaves:
-->

Deno の挙動を制御する環境変数がいくつかあります。

<!-- L11..12
`DENO_DIR` defaults to `$HOME/.cache/deno` but can be set to any path to control
where generated and cached source code is written and read to.
-->

`DENO_DIR` はデフォルトで `$HOME/.cache/deno` ですが、生成されるソースコードやキャッシュされるソースコードの読み取り / 書き込みされる場所を好きなパスに設定できます。

<!-- L14..16
`NO_COLOR` will turn off color output if set. See https://no-color.org/. User
code can test if `NO_COLOR` was set without having `--allow-env` by using the
boolean constant `Deno.noColor`.
-->

`NO_COLOR` を設定すると出力に色が付かなくなります。[https://no-color.org/](https://no-color.org/) を見てください。
ユーザーのコードをテストしたいときには、`--allow-env` 付きで `NO_COLOR` を設定しなくても boolean 値の定数 `Deno.noColor` を使っても同じことができます。

<!-- L18..18
### Shell autocomplete
-->

### シェルの自動補完

<!-- L20..22
You can generate completion script for your shell using the
`deno completions <shell>` command. The command outputs to stdout so you should
redirect it to an appropriate file.
-->

シェルの自動補完用スクリプトを生成するには `deno completions <shell>` を実行します。このコマンドは標準出力にスクリプトを流すので、適切なファイルに出力をリダイレクトしてください。

<!-- L24..24
The supported shells are:
-->

サポートしているシェルは以下です。

<!-- L26..30
- zsh
- bash
- fish
- powershell
- elvish
-->

- zsh
- bash
- fish
- powershell
- elvish

<!-- L32..32
Example (bash):
-->

例 (bash):

<!-- L34..37
```shell
deno completions bash > /usr/local/etc/bash_completion.d/deno.bash
source /usr/local/etc/bash_completion.d/deno.bash
```
-->

```shell
deno completions bash > /usr/local/etc/bash_completion.d/deno.bash
source /usr/local/etc/bash_completion.d/deno.bash
```

<!-- L39..39
Example (zsh without framework):
-->

例 (フレームワークなしの zsh):

<!-- L41..44
```shell
mkdir ~/.zsh # create a folder to save your completions. it can be anywhere
deno completions zsh > ~/.zsh/_deno
```
-->

```shell
mkdir ~/.zsh # create a folder to save your completions. it can be anywhere
deno completions zsh > ~/.zsh/_deno
```

<!-- L46..46
then add this to your `.zshrc`
-->

次に以下を `.zshrc` に追記してください。

<!-- L48..52
```shell
fpath=(~/.zsh $fpath)
autoload -Uz compinit
compinit -u
```
-->

```shell
fpath=(~/.zsh $fpath)
autoload -Uz compinit
compinit -u
```

<!-- L54..56
and restart your terminal. note that if completions are still not loading, you
may need to run `rm ~/.zcompdump/` to remove previously generated completions
and then `compinit` to generate them again.
-->

その後、ターミナルを再起動します。補完がまだ読み込まれない場合には、以前に生成された補完を削除するために `rm ~/.zcompdump/` を実行してみてください。それから再度 `compinit` で生成してください。

<!-- L58..58
Example (zsh + oh-my-zsh) [recommended for zsh users] :
-->

例 (zsh + oh-my-zsh) [zsh ユーザーの推奨] :

<!-- L60..63
```shell
mkdir ~/.oh-my-zsh/custom/plugins/deno
deno completions zsh > ~/.oh-my-zsh/custom/plugins/deno/_deno
```
-->

```shell
mkdir ~/.oh-my-zsh/custom/plugins/deno
deno completions zsh > ~/.oh-my-zsh/custom/plugins/deno/_deno
```

<!-- L65..67
After this add deno plugin under plugins tag in `~/.zshrc` file. for tools like
`antigen` path will be `~/.antigen/bundles/robbyrussell/oh-my-zsh/plugins` and
command will be `antigen bundle deno` and so on.
-->

この後、`~/.zshrc` ファイルのプラグインタグに deno プラグインを加えてください。`antigen` のようなツールなら、パスは `~/.antigen/bundles/robbyrussell/oh-my-zsh/plugins`
でコマンドは `antigen bundle deno` のようになります。

<!-- L69..69
Example (Powershell):
-->

例 (Powershell):

<!-- L71..74
```shel
deno completions powershell > $profile
.$profile
```
-->

```shel
deno completions powershell > $profile
.$profile
```

<!-- L76..78
This will be create a Powershell profile at
`$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1` by default,
and it will be run whenever you launch the PowerShell.
-->

これで Powershell profile がデフォルトで `$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1` に作成され、
PowerShell を起動するたびに実行されます。

<!-- L80..80
### Editors and IDEs
-->

### エディタと IDE

<!-- L82..85
Because Deno requires the use of file extensions for module imports and allows
http imports, and most editors and language servers do not natively support this
at the moment, many editors will throw errors about being unable to find files
or imports having unnecessary file extensions.
-->

Deno ではモジュールのインポートにファイル拡張子を付ける必要があり、それに加えて HTTP インポートが許可されていますが、
ほとんどのエディタと言語サーバーは今のところそれを組み込みでサポートしていません。
そのため、多くのエディタではファイルを見つけられないとかファイル拡張が不要であるといったエラーが出ます。

<!-- L87..87
The community has developed extensions for some editors to solve these issues:
-->

いくつかのエディタに関してはこの問題を解決するためコミュニティが拡張機能を開発しています。

<!-- L89..89
#### VS Code
-->

#### VS Code

<!-- L91..94
The beta version of [vscode_deno](https://github.com/denoland/vscode_deno) is
published on the
[Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=denoland.vscode-deno).
Please report any issues.
-->

The beta version of [vscode_deno](https://github.com/denoland/vscode_deno) is
published on the
[Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=denoland.vscode-deno).
Please report any issues.

<!-- L96..96
#### JetBrains IDEs
-->

#### JetBrains IDEs

<!-- L98..99
Support for JetBrains IDEs is available through
[the Deno plugin](https://plugins.jetbrains.com/plugin/14382-deno).
-->

Support for JetBrains IDEs is available through
[the Deno plugin](https://plugins.jetbrains.com/plugin/14382-deno).

<!-- L101..103
For more information on how to set-up your JetBrains IDE for Deno, read
[this comment](https://youtrack.jetbrains.com/issue/WEB-41607#focus=streamItem-27-4160152.0-0)
on YouTrack.
-->

For more information on how to set-up your JetBrains IDE for Deno, read
[this comment](https://youtrack.jetbrains.com/issue/WEB-41607#focus=streamItem-27-4160152.0-0)
on YouTrack.

<!-- L105..105
#### Vim and NeoVim
-->

#### Vim and NeoVim

<!-- L107..109
Vim works fairly well for Deno/TypeScript if you install
[CoC](https://github.com/neoclide/coc.nvim) (intellisense engine and language
server protocol).
-->

Vim works fairly well for Deno/TypeScript if you install
[CoC](https://github.com/neoclide/coc.nvim) (intellisense engine and language
server protocol).

<!-- L111..115
After CoC is installed, from inside Vim, run`:CocInstall coc-tsserver` and
`:CocInstall coc-deno`. To get autocompletion working for Deno type definitions
run `:CocCommand deno.types`. Optionally restart the CoC server `:CocRestart`.
From now on, things like `gd` (go to definition) and `gr` (goto/find references)
should work.
-->

After CoC is installed, from inside Vim, run`:CocInstall coc-tsserver` and
`:CocInstall coc-deno`. To get autocompletion working for Deno type definitions
run `:CocCommand deno.types`. Optionally restart the CoC server `:CocRestart`.
From now on, things like `gd` (go to definition) and `gr` (goto/find references)
should work.

<!-- L117..117
#### Emacs
-->

#### Emacs

<!-- L119..124
Emacs works pretty well for a TypeScript project targeted to Deno by using a
combination of [tide](https://github.com/ananthakumaran/tide) which is the
canonical way of using TypeScript within Emacs and
[typescript-deno-plugin](https://github.com/justjavac/typescript-deno-plugin)
which is what is used by the
[official VSCode extension for Deno](https://github.com/denoland/vscode_deno).
-->

Emacs works pretty well for a TypeScript project targeted to Deno by using a
combination of [tide](https://github.com/ananthakumaran/tide) which is the
canonical way of using TypeScript within Emacs and
[typescript-deno-plugin](https://github.com/justjavac/typescript-deno-plugin)
which is what is used by the
[official VSCode extension for Deno](https://github.com/denoland/vscode_deno).

<!-- L126..131
To use it, first make sure that `tide` is setup for your instance of Emacs.
Next, as instructed on the
[typescript-deno-plugin](https://github.com/justjavac/typescript-deno-plugin)
page, first `npm install --save-dev typescript-deno-plugin typescript` in your
project (`npm init -y` as necessary), then add the following block to your
`tsconfig.json` and you are off to the races!
-->

To use it, first make sure that `tide` is setup for your instance of Emacs.
Next, as instructed on the
[typescript-deno-plugin](https://github.com/justjavac/typescript-deno-plugin)
page, first `npm install --save-dev typescript-deno-plugin typescript` in your
project (`npm init -y` as necessary), then add the following block to your
`tsconfig.json` and you are off to the races!

<!-- L133..145
```json
{
  "compilerOptions": {
    "plugins": [
      {
        "name": "typescript-deno-plugin",
        "enable": true, // default is `true`
        "importmap": "import_map.json"
      }
    ]
  }
}
```
-->

```json
{
  "compilerOptions": {
    "plugins": [
      {
        "name": "typescript-deno-plugin",
        "enable": true, // default is `true`
        "importmap": "import_map.json"
      }
    ]
  }
}
```

<!-- L147..149
If you don't see your favorite IDE on this list, maybe you can develop an
extension. Our [community Discord group](https://discord.gg/deno) can give you
some pointers on where to get started.
-->

If you don't see your favorite IDE on this list, maybe you can develop an
extension. Our [community Discord group](https://discord.gg/deno) can give you
some pointers on where to get started.
