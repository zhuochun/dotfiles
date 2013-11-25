" colorschemes
colorscheme badwolf
" colorscheme background
set background=dark
" use console dialogs
set guioptions+=c
" transpacy
set transparency=9

" OSX: Specific keybindings
if has("mac")
    " Unmap Apple+T
    macmenu File.New\ Tab key=<nop>
    " Unmap Apple+O
    macmenu File.Open\.\.\. key=<nop>
    " Unmap Apple+S+T
    macmenu File.Open\ Tab\.\.\. key=<nop>
    " Unmap Apple+P
    macmenu File.Print key=<nop>
    " Unmap Apple+F so we can...
    macmenu Edit.Find.Find\.\.\. key=<nop>
endif
