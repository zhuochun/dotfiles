" Directory related commands {{{
" yank local working directory to clipboard
command! Ywd   :let @+ = expand("%")
command! Ycd   :let @+ = substitute(expand("%:p"), expand("~"), "~", "g")
command! Ycf   :let @+ = expand("%:t")
command! Ycl   :let @+ = expand("%") . ":" . line(".")

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
command! -range VResize      call <SID>resize(<line1>, <line2>)
command! -range VResizeSplit call <SID>split("",      <line1>, <line2>)
command! -range VResizeAbove call <SID>split("above", <line1>, <line2>)
command! -range VResizeBelow call <SID>split("below", <line1>, <line2>)

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

" Correct commas at in selected lines {{{
" https://github.com/benmills/vim-commadown
command! -range CommaDown call <SID>commaDown()

function! s:commaDown()
  let last_line = getpos("'>")[1]
  let current_line = line("v")
  let current_line_contents = getline(current_line)
  let stripped_line = substitute(current_line_contents, ",\$", "", "")

  call setline(current_line, stripped_line)

  if (current_line != last_line) || $USER == "fairley"
    call setline(current_line, stripped_line . ",")
  endif
endfunction
" }}}

" Delete all buffers not open in windows/tabs {{{
" https://github.com/fatih/dotfiles/blob/master/vimrc#L249
command! BufActive call s:deleteInactiveBufs()

function! s:deleteInactiveBufs()
  " From tabpagebuflist() help, get a list of all buffers in all tabs
  let tablist = []
  for i in range(tabpagenr('$'))
    call extend(tablist, tabpagebuflist(i + 1))
  endfor

  " Below originally inspired by Hara Krishna Dara and Keith Roberts
  " http://tech.groups.yahoo.com/group/vim/message/56425
  let nWipeouts = 0
  for i in range(1, bufnr('$'))
    if bufexists(i) && !getbufvar(i, "&mod") && index(tablist, i) == -1
      " bufno exists AND isn't modified AND isn't in the list of buffers
      " open in windows and tabs
      silent exec 'bwipeout' i
      let nWipeouts = nWipeouts + 1
    endif
  endfor

  echomsg nWipeouts . ' buffer(s) wiped out'
endfunction
" }}}

" Format JSON
if executable("jsonmatter")
  command! JSON :%!jsonmatter --indent 4
elseif executable("python")
  command! JSON :%!python -m json.tool
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim:ft=vim:fdm=marker:sw=2:ts=2
