let g:python_host_prog = '/opt/local/bin/python2'
let g:python3_host_prog = '/opt/local/bin/python3'

if empty($ITERM_PROFILE)
    let iterm_profile == "Dark"
else
    let iterm_profile = $ITERM_PROFILE
endif

" choose from ayu, one, snazzy
let custom_theme = "ayu"

if custom_theme == "ayu"
    set termguicolors
    if iterm_profile == "Dark"
        let ayucolor="mirage"
    else
        let ayucolor="light" 
    endif
    silent! colorscheme ayu
    let g:airline_theme='one'
endif

if custom_theme == "one"
    silent! colorscheme one
    if iterm_profile == "Dark"
        set background=dark
    else
        set background=ligh
    endif
endif

if custom_theme == "snazzy"
    silent! colorscheme snazzy
    let g:airline_theme='dracula'
endif

if has("nvim")
    let g:one_allow_italics = 1
endif

set list
" set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮,nbsp:⎵
set listchars=eol:¬,tab:--,trail:⋅,extends:❯,precedes:❮,space:␣

autocmd Filetype c setlocal tabstop=8 noexpandtab

