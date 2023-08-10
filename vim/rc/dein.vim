" Plugins
" https://github.com/Shougo/dein.vim

" Dein config {{{
" Set Dein base path (required)
let s:dein_base = g:dotvim_bundles

" Set Dein source path (required)
let s:dein_src = g:dotvim_bundles . '/repos/github.com/Shougo/dein.vim'

" Set Dein runtime path (required)
execute 'set runtimepath+=' . s:dein_src

" Early exit if folder not exists
if !dein#load_state(g:dotvim_bundles)
  filetype plugin indent on
  finish
endif

" Dein init {{{
" Call Dein initialization (required)
call dein#begin(s:dein_base)
call dein#add(s:dein_src)

" Your plugins go here:
call dein#load_toml(g:dotvim_root . '/rc/bundles.toml', {'lazy': 0})
call dein#load_toml(g:dotvim_root . '/rc/bundles_lazy.toml', {'lazy': 1})

call dein#end()
call dein#save_state()
" }}}

" Disable default plugins {{{
let g:loaded_2html_plugin      = 1
let g:loaded_logiPat           = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_gzip              = 1
let g:loaded_man               = 1
let g:loaded_matchparen        = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_rrhelper          = 1
let g:loaded_shada_plugin      = 1
let g:loaded_spellfile_plugin  = 1
let g:loaded_tarPlugin         = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_zipPlugin         = 1
" }}}

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
if has('filetype')
  filetype indent plugin on
endif

" Install not installed plugins on startup
if !has('vim_starting') && dein#check_install()
  call dein#install()
endif

" Dein related commands {{{
" Update plugins
command! DeinUpdate call dein#update()
" Clear state
command! DeinClearState call dein#clear_state()
" Reset runtimepath
command! DeinClearRuntime call dein#recache_runtimepath()
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim:ft=vim:fdm=marker:sw=2:ts=2
