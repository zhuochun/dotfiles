" Directory related commands {{{
" yank local working directory to clipboard
command! Ywd   :let @+ = expand("%")
command! Ycl   :let @+ = line(".")

" change working directory
command! Cwd   :cd %:p:h
" change local working directory
command! Clwd  :lcd %:p:h

" change directory to the root of the Git repository {{
command! Root call s:root()
" Find the root folder in git repo
function! s:root()
  let root = systemlist('git rev-parse --show-toplevel')[0]
  if v:shell_error
    echo 'Not in git repo'
  else
    execute 'lcd' root
    echo 'Changed directory to: '.root
  endif
endfunction
" }}
" }}}

" Visual resize {{{
" https://github.com/wellle/visual-split.vim
command! -range VSResize     call <SID>resize(<line1>, <line2>)
command! -range VSSplit      call <SID>split("",      <line1>, <line2>)
command! -range VSSplitAbove call <SID>split("above", <line1>, <line2>)
command! -range VSSplitBelow call <SID>split("below", <line1>, <line2>)

" functions execute wincmds
function! s:resize(line1, line2)
  execute (a:line2 - a:line1 + 1) . "wincmd _"
  call s:scroll(a:line1)
endfunction

function! s:split(position, line1, line2)
  execute a:position . (a:line2 - a:line1 + 1) . "wincmd s"
  call s:scroll(a:line1)
  wincmd p
endfunction

function! s:scroll(line)
  let scrolloff = &scrolloff
  let &scrolloff = 0
  call cursor(a:line, 0)
  normal! ztM
  let &scrolloff=scrolloff
endfunction
" }}}

" Format to JSON
command! JSON :%!python -m json.tool<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim:ft=vim:fdm=marker:sw=2:ts=2
