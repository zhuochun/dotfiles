" source gvimrc after saving it
autocmd! BufWritePost .gvimrc source $MYGVIMRC

" gui styles {{{
command! Fullscreen :set lines=999 columns=999

" gui fonts
command! SmallFont  :set guifont=Inconsolata-g\ for\ Powerline:h14
command! LargeFont  :set guifont=Inconsolata-g\ for\ Powerline:h16
" }}}

" common gui groups {{{
command! DefaultMode call s:DefaultMode()
function! s:DefaultMode()
    set background=dark
    colorscheme hybrid

    set lines=42 columns=142
    set guifont=Inconsolata-g\ for\ Powerline:h14
endfunction

command! MonitorMode call s:MonitorMode()
function! s:MonitorMode()
    set lines=999 columns=999
    set guifont=Inconsolata-g\ for\ Powerline:h16
endfunction

command! PresentationMode call s:PresentationMode()
function! s:PresentationMode()
    set background=light
    colorscheme base16-solarized

    set lines=999 columns=999
    set guifont=Inconsolata-g\ for\ Powerline:h23
endfunction
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
