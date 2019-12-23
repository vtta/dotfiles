set rtp+=/opt/local/share/fzf/vim
let g:python3_host_prog = '/usr/bin/python3'
" set list
set listchars=eol:¬,tab:--,trail:⋅,extends:❯,precedes:❮,space:⎵
set termguicolors
syntax enable

let theme = 'dark'

if theme == 'light'
    set background=light
    colorscheme solarized8
    let g:airline_theme='solarized'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

if theme == 'dark'
    set background=dark
    colorscheme snazzy
    let g:airline_theme='dracula'
endif

