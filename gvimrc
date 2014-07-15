" use console dialogs
set guioptions+=c

" colorschemes
colorscheme gruvbox
" transpacy
set transparency=3

" special modes
command! WritingMode call s:WritingMode()
function! s:WritingMode()
    colorscheme base16-railscasts
    set colorcolumn=79
    set transparency=0
    set linespace=2
    set background=dark
    set guifont=Liberation\ Mono\ for\ Powerline:h16
endfunction

command! LightMode call s:LightMode()
function! s:LightMode()
    colorscheme base16-solarized
    set colorcolumn=79
    set transparency=0
    set linespace=2
    set background=light
    set guifont=Liberation\ Mono\ for\ Powerline:h16
endfunction

command! CodingMode call s:CodingMode()
function! s:CodingMode()
    colorscheme jellybeans
    set colorcolumn=79
    set transparency=3
    set linespace=0
    set background=dark
    set guifont=Inconsolata-dz\ for\ Powerline:h16
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
