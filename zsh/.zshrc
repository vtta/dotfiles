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
    git
    pure
    fast-syntax-highlighting
)

DISABLE_UPDATE_PROMPT="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
PURE_GIT_UNTRACKED_DIRTY=0
PURE_GIT_DOWN_ARROW="⇣"
PURE_GIT_UP_ARROW="⇡"

source $ZSH/oh-my-zsh.sh

alias ls='exa'

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
