" Source vimrc after saving it {{{
autocmd! BufWritePost .vimrc,bundles.rc.vim source $MYVIMRC | redraw
" }}}

" Focus to the last edit line when you reopen a file {{{
autocmd! BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") |
       \     execute 'normal! g`"zvzz' |
       \ endif
" }}}

" Diff update after save {{{
autocmd! InsertLeave,BufWritePost * if &l:diff | diffupdate | endif
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim:ft=vim:fdm=marker:sw=2:ts=2
