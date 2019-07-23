#zmodload zsh/zprof
export DOTFILES="$HOME/dotfiles"
ZSH_BASE=$DOTFILES/zsh
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export ZPLUG_HOME="$ZSH_BASE/zplug"
export LANG=en_US.UTF-8
[[ -n $SSH_CONNECTION ]] && \
    export EDITOR='vim' || export EDITOR='nvim'
ZSH_CUSTOM="$ZSH_BASE/custom"
type fd &> /dev/null && \
    export FZF_DEFAULT_COMMAND="fd --type file --color=always" && \
    export FZF_DEFAULT_OPTS="--ansi"

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias -g ......='../../../../../..'
alias l='ls -lh'
alias ll='ls -lah'
ls -G . &> /dev/null && alias ls='ls -G'
type gls &> /dev/null && alias ls='gls --color=auto'

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

KEYTIMEOUT=1 # 10 ms
HISTFILE=$ZSH_BASE/zsh_history
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

source $ZPLUG_HOME/init.zsh

zplug "plugins/cp", from:oh-my-zsh
zplug "plugins/fzf", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh
zplug "plugins/cargo", from:oh-my-zsh
zplug "plugins/pyenv", from:oh-my-zsh
zplug "plugins/extract", from:oh-my-zsh
zplug "plugins/autojump", from:oh-my-zsh
zplug "plugins/web-search", from:oh-my-zsh

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search", defer:3

zplug "valentinocossar/sublime"
zplug "pkulev/zsh-rustup-completion"
zplug "zdharma/fast-syntax-highlighting", defer:2
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, as:theme

zplug "$ZSH_CUSTOM/plugins/poetry", from:local

zplug check || zplug install
zplug load

# test -e "$HOME/.iterm2_shell_integration.zsh" && \
#    source "$HOME/.iterm2_shell_integration.zsh"

