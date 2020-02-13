DOTFILES="$(dirname $(readlink ~/.zshrc))"
export ZSH="$DOTFILES/../module/ohmyzsh"
ZSH_CUSTOM="$DOTFILES/../module/ohmyzsh-custom"
ZSH_THEME=""

PATH="$PATH:/usr/local/bin:/usr/local/sbin:/sbin:/usr/sbin:/bin:/usr/bin"
PATH_CANDIDATE=(
    /usr/local/opt/flex/bin
    /usr/local/opt/bison/bin
    /usr/local/opt/llvm/bin
    /opt/local/bin
    /opt/local/sbin
    /usr/local/share/npm/bin
    ~/.cargo/bin
    ~/perl5/bin
    ~/bin
)
for path_candidate in ${PATH_CANDIDATE} ; do
  if [ -d ${path_candidate} ]; then
    PATH="${PATH}:${path_candidate}"
  fi
done
export PATH="$PATH"
export LANG=en_US.UTF-8

plugins=(
    z cp git sudo extract gitignore 
    rand-quote colored-man-pages
    history-substring-search
    pure fast-syntax-highlighting
)

DISABLE_UPDATE_PROMPT="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
PURE_GIT_UNTRACKED_DIRTY=0
PURE_GIT_DOWN_ARROW="⇣"
PURE_GIT_UP_ARROW="⇡"

source $ZSH/oh-my-zsh.sh

bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

################
####    alias
################
alias ls='exa'
alias dl='aria2c -x 16 -s 16 -k 1M'
alias cfa='fd -a -e c -e cc -e cpp -e cxx -e h -e hh -e hpp -e hxx -x clang-format -style=file -i {}'

################
####    envs
################
HTTP_PROXY_SERVER=http://127.0.0.1:7890
SOCKS_PROXY_SERVER=socks5://127.0.0.1:7891
export http_proxy=$HTTP_PROXY_SERVER
export https_proxy=$HTTP_PROXY_SERVER
export all_proxy=$SOCKS_PROXY_SERVER
export HTTP_PROXY=$http_proxy
export HTTPS_PROXY=$http_proxy
export ALL_PROXY=$all_proxy
export EDITOR='nvim'
export FZF_DEFAULT_COMMAND="fd --type file --color=always"
export FZF_DEFAULT_OPTS="--ansi"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"

################
####    fns
################
y2bdl() {
    youtube-dl -f "bestvideo[ext=mp4]+bestaudio[acodec=opus]/bestvideo[ext=mp4]+bestaudio[ext=m4a]" \
        --external-downloader aria2c --external-downloader-args "-x 16 -s 16 -k 1M" \
        --retries infinite --fragment-retries infinite \
        --write-sub --write-auto-sub --sub-lang en,zh-Hans --sub-format vtt/srt \
        --recode-video mp4 --embed-subs \
        --postprocessor-args "-vcodec copy -b:a 256k" \
        --proxy "$http_proxy" \
        --keep-video "$@"
        # --postprocessor-args "-vcodec copy -b:a 256k -c:v libx265 -preset medium -tag:v hvc1"
}

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

#git config --global http.proxy $all_proxy
# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
# eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"


# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# export MANPATH="/usr/local/man:$MANPATH"
# export ARCHFLAGS="-arch x86_64"

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

typeset -aU path;
quote | cowsay
