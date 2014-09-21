" use console dialogs
set guioptions+=c

" special style modes
command! LightMode call s:LightMode()
function! s:LightMode()
    set background=light
    colorscheme base16-railscasts
    set linespace=2
    set guifont=Liberation\ Mono\ for\ Powerline:h16
endfunction

command! DarkMode call s:DarkMode()
function! s:DarkMode()
    set background=dark
    colorscheme hybrid
    set linespace=2
    set guifont=Liberation\ Mono\ for\ Powerline:h16
endfunction

command! CodingMode call s:CodingMode()
function! s:CodingMode()
    set background=dark
    colorscheme gruvbox
    set linespace=0
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
    set linespace=2
    set guifont=Fantasque\ Sans\ Mono:h24
endfunction

call s:DarkMode() " use dark mode for a while

" OSX: Specific keybindings
if has("mac")
    " Unmap Apple+N
    macmenu File.New\ Window key=<nop>
    " Unmap Apple+T
    macmenu File.New\ Tab key=<nop>
    " Unmap Apple+O
    macmenu File.Open\.\.\. key=<nop>
    " Unmap Apple+S+T
    macmenu File.Open\ Tab\.\.\. key=<nop>
    " Unmap Apple+P
    macmenu File.Print key=<nop>
    " Unmap Apple+F
    macmenu Edit.Find.Find\.\.\. key=<nop>
    " Unmap Apple+L
    macmenu Tools.List\ Errors key=<nop>
endif
