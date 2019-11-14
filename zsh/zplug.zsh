#zmodload zsh/zprof

DOTFILES="$HOME/dotfiles"
ZSH_BASE="$DOTFILES/zsh"
ZSH_CUSTOM="$ZSH_BASE/custom"

PATH="/usr/local/sbin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/Library/Python/3.7/bin:$PATH"
PATH="$HOME/go/bin:$PATH"
PATH="/usr/local/opt/llvm/bin:$PATH"
PATH="/usr/local/opt/flex/bin:$PATH"
PATH="/usr/local/opt/bison/bin:$PATH"
export PATH

export LDFLAGS="-L/usr/local/opt/flex/lib \
                -L/usr/local/opt/bison/lib \
                -L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/flex/include \
                 -I/usr/local/opt/llvm/include"

#export CPATH="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include"

export ZPLUG_HOME="$ZSH_BASE/zplug"
export LANG=en_US.UTF-8
export EDITOR='nvim'
export FZF_DEFAULT_COMMAND="fd --type file --color=always"
export FZF_DEFAULT_OPTS="--ansi"

export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"

#HTTP_PROXY_SERVER=http://127.0.0.1:7890
#SOCKS_PROXY_SERVER=socks5h://127.0.0.1:7891
HTTP_PROXY_SERVER=http://127.0.0.1:8888
SOCKS_PROXY_SERVER=socks5h://127.0.0.1:8889
export http_proxy=$HTTP_PROXY_SERVER
export https_proxy=$HTTP_PROXY_SERVER
export all_proxy=$SOCKS_PROXY_SERVER
export HTTP_PROXY=$http_proxy
export HTTPS_PROXY=$http_proxy
export ALL_PROXY=$all_proxy
#git config --global http.proxy $all_proxy

alias vim='nvim'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias -g .......='../../../../../..'
alias l='ls -lh'
alias ll='ls -lah'
alias ls='exa'
alias cfa='fd -a -e c -e cc -e cpp -e cxx -e h -e hh -e hpp -e hxx -x clang-format -style=file -i {}'
alias y2bdl='youtube-dl -f bestvideo+bestaudio --write-sub --write-auto-sub --sub-lang en,zh-Hans --embed-subs'

tlc() {
    for i in $@ ; do echo "$i" | tr '[:upper:]' '[:lower:]' ; done
}
uba() {
    brew update
    brew upgrade
    brew cask outdated --greedy --verbose | rg -v latest | cut -d " " -f 1 | xargs brew cask upgrade
    brew cleanup
}
brewdeps() {
    brew leaves | xargs brew deps --installed --for-each | sed "s/^.*:/$(tput setaf 4)&$(tput sgr0)/" | sed "s/://"
}
brewrdeps() {
    brew list -1 | while read cask; do echo -ne "\x1B[1;34m $cask \x1B[0m"; brew uses $cask --installed | awk '{printf(" %s ", $0)}'; echo ""; done
}

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

KEYTIMEOUT=1 # 10 ms
HISTFILE=$ZSH_BASE/zsh_history
HISTSIZE=10000
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
zplug "plugins/fd", from:oh-my-zsh
zplug "plugins/fzf", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh
zplug "plugins/cargo", from:oh-my-zsh
zplug "plugins/extract", from:oh-my-zsh
zplug "plugins/thefuck", from:oh-my-zsh
zplug "plugins/autojump", from:oh-my-zsh
zplug "plugins/web-search", from:oh-my-zsh

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search", defer:3

zplug "valentinocossar/sublime"
zplug "pkulev/zsh-rustup-completion"
zplug "zdharma/fast-syntax-highlighting", defer:2
# zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, as:theme

zplug "$ZSH_CUSTOM/plugins/poetry", from:local

zplug check || zplug install
zplug load

eval "$(starship init zsh)"

export PATH="$HOME/perl5/bin${PATH:+:${PATH}}"
export PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
export PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_MB_OPT="--install_base \"$HOME/perl5\""
export ERL_MM_OPT="INSTALL_BASE=$HOME/perl5"

# Override auto-title when static titles are desired ($ title My new title)
title() { export TITLE_OVERRIDDEN=1; echo -en "\e]0;$*\a"}
# Turn off static titles ($ autotitle)
autotitle() { export TITLE_OVERRIDDEN=0 }; autotitle
# Condition checking if title is overridden
overridden() { [[ $TITLE_OVERRIDDEN == 1 ]]; }
# Echo asterisk if git state is dirty
gitDirty() { [[ $(git status 2> /dev/null | grep -o '\w\+' | tail -n1) != ("clean"|"") ]] && echo "*" }

# Show cwd when shell prompts for input.
tabtitle_precmd() {
   if overridden; then return; fi
   pwd=$(pwd) # Store full path as variable
   cwd=${pwd##*/} # Extract current working dir only
   print -Pn "\e]0;$cwd$(gitDirty)\a" # Replace with $pwd to show full path
}
[[ -z $precmd_functions ]] && precmd_functions=()
precmd_functions=($precmd_functions tabtitle_precmd)

# Prepend command (w/o arguments) to cwd while waiting for command to complete.
tabtitle_preexec() {
   if overridden; then return; fi
   printf "\033]0;%s\a" "${1%% *} | $cwd$(gitDirty)" # Omit construct from $1 to show args
}
[[ -z $preexec_functions ]] && preexec_functions=()
preexec_functions=($preexec_functions tabtitle_preexec)
