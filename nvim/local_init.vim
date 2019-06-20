
let g:python2_host_prog = '/opt/local/bin/python2'
let g:python3_host_prog = '/opt/local/bin/python3'

" silent! colorscheme snazzy
" let g:airline_theme='dracula'
silent! colorscheme one
let g:airline_theme='one'
let iterm_profile = $ITERM_PROFILE
if iterm_profile == "Dark"
    set background=dark
else
    set background=light
endif

" set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set listchars=tab:--,nbsp:⎵,trail:⋅,extends:❯,precedes:❮
set list
autocmd Filetype c setlocal tabstop=8 noexpandtab

