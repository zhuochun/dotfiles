" Source gvimrc after saving it
autocmd! BufWritePost .gvimrc source $MYGVIMRC

" GUI styles {{{
set guicursor=a:blinkon0     " Disable GUI blinking cursor
set guioptions=c             " Disable GUI components, except use console dialogs
set winaltkeys=no            " Set ALT not map to toolbar

set lines=42 columns=120
set background=dark

" GUI fonts {{
set macligatures             " Show ligatures with supported fonts (MacVim GUI)

" fonts, powerline fonts:
"   - https://github.com/powerline/fonts
"   - https://github.com/tonsky/FiraCode
"   - https://github.com/i-tu/Hasklig
"   - https://be5invis.github.io/Iosevka
" set guifont=Inconsolata-g\ for\ Powerline:h14
" set guifont=InputMonoNarrow\ Light:h13
" set guifont=Iosevka\ Light:h13
" set guifont=M+\ 1m\ for\ Powerline:h14
" set guifont=Meslo\ LG\ S\ Regular\ for\ Powerline:h13
" set guifont=Office\ Code\ Pro\ Light:h12
" set guifont=Fira\ Code\ Light:h12
" set guifont=Hasklig\ Light:h13
set guifont=Roboto\ Mono\ for\ Powerline:h11
" }}

" GUI colorschems {{
" colorscheme base16-eighties
" colorscheme base16-ocean
" colorscheme dracula
" colorscheme flattened_dark
" colorscheme gruvbox
" colorscheme hybrid
" colorscheme one
" colorscheme tender
colorscheme two-firewatch
" colorscheme yowish
" }}
" }}}

" Common GUI groups {{{
command! DefaultMode call s:DefaultMode()
function! s:DefaultMode()
  set background=dark
  colorscheme hybrid

  set lines=42 columns=142
  set guifont=Inconsolata-g\ for\ Powerline:h12
endfunction

command! MonitorMode call s:MonitorMode()
function! s:MonitorMode()
  set lines=999 columns=999
  set guifont=Iosevka\ Light:h14
endfunction

command! PresentationMode call s:PresentationMode()
function! s:PresentationMode()
  set background=light
  colorscheme one

  set lines=999 columns=999
  set guifont=Inconsolata-g\ for\ Powerline:h23
endfunction
" }}}

" MacVim specific {{{
if has("gui_macvim")
  " Turn on alt (option) key on macs, which behaves
  " like the 'meta' key. Thus we can now use <M-x>
  set macmeta

  " Remove specific OSX keybindings
  " Unmap D-n
  macmenu File.New\ Window key=<nop>
  " Unmap D-t
  macmenu File.New\ Tab key=<nop>
  " Unmap D-o
  macmenu File.Open\.\.\. key=<nop>
  " Unmap D-T
  macmenu File.Open\ Tab\.\.\. key=<nop>
  " Unmap D-W
  macmenu File.Close\ Window key=<nop>
  " Unmap D-w
  macmenu File.Close key=<nop>
  " Unmap D-p
  macmenu File.Print key=<nop>
  " Unmap D-f
  macmenu Edit.Find.Find\.\.\. key=<nop>
  " Unmap D-l
  macmenu Tools.List\ Errors key=<nop>
endif " }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim:ft=vim:fdm=marker:sw=2:ts=2
