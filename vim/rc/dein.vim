" Plugins
" https://github.com/Shougo/dein.vim

" Dein config {{{
let g:dein#types#git#clone_depth = 5
" }}}

" Dein init {{{
let s:dotvim_dein = g:dotvim_bundles . '/repos/github.com/Shougo/dein.vim'
execute 'set runtimepath^=' . s:dotvim_dein

if !dein#load_state(g:dotvim_bundles)
  filetype plugin indent on
  finish
endif

call dein#begin(g:dotvim_bundles)

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

filetype plugin indent on

" Install not installed plugins on startup
if !has('vim_starting') && dein#check_install()
  call dein#install()
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim:ft=vim:fdm=marker:sw=2:ts=2
