
if type nvim >/dev/null 2>&1; then 
    alias vim="nvim" 
fi

# eval $(thefuck --alias)
alias whereismyheader="g++ -E -x c - -v < /dev/null"
alias tntsign="codesign --force --deep --sign - "
alias tntattr="sudo xattr -dr com.apple.quarantine "
