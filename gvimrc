" use console dialogs
set guioptions+=c

" colorschemes
colorscheme gruvbox
" transpacy
set transparency=6

" special modes
command! WritingMode call s:WritingMode()
function! s:WritingMode()
    set transparency=0
    set linespace=6
    set guifont=Fantasque\ Sans\ Mono:h24
    set background=light
    colorscheme hemisu
endfunction

command! CodingMode call s:CodingMode()
function! s:CodingMode()
    set transparency=3
    set linespace=3
    set guifont=Inconsolata-dz\ for\ Powerline:h16
    set background=dark
    colorscheme base16-eighties
endfunction

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
