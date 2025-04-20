## Install apps via `brew`

```sh
brew bundle install
```
## Stow

To install the dotfiles, run the following command in the root of the repo:
```sh
./install.sh
```

### Adding New Files to Stow

To add a new file, such as `.aider.conf.yml`, to be managed by `stow`, follow these steps:

1. Place the file in the appropriate directory within your dotfiles structure. For example, if you have a directory for configuration files, place `.aider.conf.yml` there.

2. Ensure the directory structure mirrors where the file should be located in your home directory. For example, if `.aider.conf.yml` should be in the home directory, place it directly under the relevant directory in your dotfiles repo.

3. Run the `stow` command to create the symlink in your home directory:
   ```sh
   stow <directory_name>
   ```
   Replace `<directory_name>` with the name of the directory containing `.aider.conf.yml`.

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
