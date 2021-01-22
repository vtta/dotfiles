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
  ~/.local/bin
)
for path_candidate in ${PATH_CANDIDATE}; do
  if [ -d ${path_candidate} ]; then
    PATH="${PATH}:${path_candidate}"
  fi
done
export PATH="$PATH"
export LANG=en_US.UTF-8
export ZSH_DISABLE_COMPFIX=true
typeset -aU path

source "${HOME}/.zgen/sindresorhus/pure-master/async.zsh" 

# load zgen
source "${HOME}/.zgen/zgen.zsh"
# if the init script doesn't exist
if ! zgen saved; then
  zgen oh-my-zsh
  zgen oh-my-zsh plugins/z
  zgen oh-my-zsh plugins/cp
  zgen oh-my-zsh plugins/fzf
  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/osx
  zgen oh-my-zsh plugins/brew
  # zgen oh-my-zsh plugins/sudo
  zgen oh-my-zsh plugins/extract
  zgen oh-my-zsh plugins/gitignore
  zgen oh-my-zsh plugins/rand-quote
  zgen oh-my-zsh plugins/colored-man-pages
  zgen oh-my-zsh plugins/history-substring-search
  zgen load zsh-users/zsh-completions src
  zgen load zsh-users/zsh-autosuggestions
  zmodload zsh/terminfo
  GENCOMPL_FPATH=$HOME/.zsh/complete
  zgen load RobSis/zsh-completion-generator
  zgen load zdharma/fast-syntax-highlighting
  zgen load djui/alias-tips
  zgen load unixorn/autoupdate-zgen
  PURE_GIT_UNTRACKED_DIRTY=0
  PURE_GIT_DOWN_ARROW="⇣"
  PURE_GIT_UP_ARROW="⇡"
  zgen load sindresorhus/pure

  zgen save
fi

################
####    alias
################
alias ls='exa'
alias dl='aria2c -x 16 -s 16 -k 1M'
alias cfa='fd -a -e c -e cc -e cpp -e cxx -e h -e hh -e hpp -e hxx -x clang-format -style=file -i {}'
alias pbit='pastebinit -b http://paste.ubuntu.com'

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
#export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'
#ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=("${(@)ZSH_AUTOSUGGEST_ACCEPT_WIDGETS:#forward-char}")
#ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(forward-char)
bindkey '^[[F' autosuggest-accept
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

################
####    fns
################
y2bdl() {
  youtube-dl -f "bestvideo[ext=mp4]+bestaudio[acodec=opus]/bestvideo[ext=mp4]+bestaudio[ext=m4a]/best" \
    --external-downloader aria2c --external-downloader-args "-x 16 -s 16 -k 1M" \
    --retries infinite --fragment-retries infinite \
    --write-sub --write-auto-sub --sub-lang en,zh-Hans --sub-format vtt/srt \
    --recode-video mp4 --embed-subs \
    --postprocessor-args "-vcodec copy -b:a 256k" \
    --proxy "$http_proxy" \
    --keep-video "$@"
  # --postprocessor-args "-vcodec copy -b:a 256k -c:v libx265 -preset medium -tag:v hvc1"
}

uba() {
  # brew outdated --cask --greedy --verbose | rg -v latest | cut -d " " -f 1 | xargs brew upgrade --cask
  brew update && \
  brew upgrade && \
  brew outdated --cask --verbose | rg -v latest | cut -d " " -f 1 | xargs brew upgrade --cask && \
  brew cleanup
}
brewdeps() {
  brew leaves | xargs brew deps --installed --for-each | sed "s/^.*:/$(tput setaf 4)&$(tput sgr0)/" | sed "s/://"
}
brewrdeps() {
  brew list -1 | while read cask; do
    echo -ne "\x1B[1;34m $cask \x1B[0m"
    brew uses $cask --installed | awk '{printf(" %s ", $0)}'
    echo ""
  done
}
cowquote() {
  COWS=($(cowsay -l | sed 1d)) 
  quote | cowsay -f ${COWS[RANDOM%${#COWS[@]}]} 
}
cowquote

