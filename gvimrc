" special style modes {{{
command! LightMode call s:LightMode()
function! s:LightMode()
    set background=light
    colorscheme base16-atelierforest
    set linespace=3
    set guifont=Liberation\ Mono\ for\ Powerline:h16
endfunction

command! DarkMode call s:DarkMode()
function! s:DarkMode()
    set background=dark
    colorscheme hybrid
    set linespace=6
    set guifont=InputMono\ ExLight\ for\ Powerline:h16
endfunction

command! CodingMode call s:CodingMode()
function! s:CodingMode()
    set background=dark
    colorscheme gruvbox
    set linespace=3
    set guifont=Inconsolata-dz\ for\ Powerline:h16
endfunction

command! WritingMode call s:WritingMode()
function! s:WritingMode()
    set background=dark
    colorscheme base16-tomorrow
    set linespace=5
    set guifont=Fantasque\ Sans\ Mono:h19
endfunction

command! PresentingMode call s:PresentingMode()
function! s:PresentingMode()
    set background=light
    colorscheme base16-solarized
    set linespace=3
    set guifont=Fantasque\ Sans\ Mono:h24
endfunction

call s:CodingMode() " set default style mode
" }}}

" remove specific OSX keybindings {{{
if has("mac")
    " Unmap D-n
    macmenu File.New\ Window key=<nop>
    " Unmap D-t
    macmenu File.New\ Tab key=<nop>
    " Unmap D-o
    macmenu File.Open\.\.\. key=<nop>
    " Unmap D-T
    macmenu File.Open\ Tab\.\.\. key=<nop>
    " Unmap D-p
    macmenu File.Print key=<nop>
    " Unmap D-f
    macmenu Edit.Find.Find\.\.\. key=<nop>
    " Unmap D-l
    macmenu Tools.List\ Errors key=<nop>
endif
" }}}
