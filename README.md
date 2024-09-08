## Install apps via `brew`

```sh
brew bundle install
```
## Stow

To install the dotfiles, run the following command in the root of the repo:
```sh
./install.sh
```
## Passwords

`pass` is used to manage passwords. Example: 
```sh
pass show api/tokens/openai`

## LSP debug

Add the following to your `init.lua` to enable LSP debug logs:

```lua
vim.lsp.set_log_level "debug"
```

and then run `LspLog` command to see the logs.
