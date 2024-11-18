HOST=$(hostname)
if [ "$HOST" = "Tautvydass-MacBook-Pro.local" ] || [ "$HOST" = "Tautvydass-MBP.lan" ]; then 
  source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
else
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git 
  gcloud
  gh 
  history 
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias lvim="/Users/ts/.local/bin/lvim"
alias neovide="/Applications/Neovide.app/Contents/MacOS/neovide --frame None --multigrid -- -S"
alias vim=nvim
alias lg=lazygit
alias mc="mc --nosubshell"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Ruby environment
eval "$(rbenv init - zsh)"

export PATH=/Users/ts/fvm/default/bin:$PATH
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH="$PATH":"$HOME/Library/Android/sdk/platform-tools"

# To be able to paste  in neovim I need to provide locale
export LC_ALL=lt_LT.UTF-8
export LC_CTYPE=lt_LT.UTF-8

export EDITOR='nvim'

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

firebaseTokenDev() {
  curl "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$(gcloud secrets --project indusenz-dev versions access --secret=firebaseWebApiKey 1)" \
  -H 'Content-Type: application/json' \
  --data-binary '{"email":"test@indusenz.com","password":"'$(gcloud secrets versions access --project indusenz-dev --secret=invenioWebTest latest)'","returnSecureToken":true}' \
  | jq -r '.idToken'
}

firebaseTokenAdminDev() {
  curl "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$(gcloud secrets --project indusenz-dev versions access --secret=firebaseWebApiKey 1)" \
  -H 'Content-Type: application/json' \
  --data-binary '{"email":"admin@indusenz.com","password":"'$(gcloud secrets versions access --project indusenz-dev --secret=invenioWebAdmin latest)'","returnSecureToken":true}' \
  | jq -r '.idToken'
}

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Amount of open files
ulimit -n 4096

if [ -f ~/.env ]
then
  export $(cat ~/.env | xargs)
fi

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /Users/ts/.dart-cli-completion/zsh-config.zsh ]] && . /Users/ts/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]
export PATH="/Users/ts/.vscode-dotnet-sdk/.dotnet:$PATH"
export PATH="/Users/ts/Developer/sqlite:$PATH"

# . "$HOME/.atuin/bin/env"

eval "$(atuin init zsh --disable-up-arrow)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ts/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/ts/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ts/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/ts/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}
eval "$(zoxide init zsh)"
