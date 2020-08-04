" NerdTree {{{
autocmd! FileType nerdtree :call s:NerdTreeDef()
function! s:NerdTreeDef() abort
  execute 'nmap <buffer> -' g:NERDTreeMapUpdir
endfunction
" }}}

" Snippets {{{
autocmd! FileType neosnippet,snippet setlocal noexpandtab
" }}}

" Git {{{
autocmd! FileType gitcommit setlocal spell
" }}}

" SQL {{{
" brew install pgformatter
" https://github.com/darold/pgFormatter
autocmd! FileType sql setlocal formatprg=pg_format\ -f\ 2
" }}}

" JSON {{{
" brew install jq
" https://stedolan.github.io/jq/
autocmd! FileType json setlocal shiftwidth=2 tabstop=2 foldmethod=syntax formatprg=jq\ --indent\ 2
" }}}

" Ruby Mappings {{{
autocmd! FileType ruby,eruby,rdoc :call s:RubyDef()
function! s:RubyDef() abort
  setlocal iskeyword+=!,?

  setlocal shiftwidth=2
  setlocal tabstop=2

  " Surround % to %
  let b:surround_{char2nr('%')} = "<% \r %>"
  xmap <buffer> % S%
  " Surround = to %=
  let b:surround_{char2nr('=')} = "<%= \r %>"
  xmap <buffer> _ S=
  " Surround # to #{}
  let b:surround_{char2nr('#')} = "#{\r}"
  xmap <buffer> # S#

  " Make AutoPairs match for these pairs
  let b:AutoPairs = {
        \   '(':')', '[':']', '{':'}', "'":"'", '"':'"', '`':'`', '|': '|'
        \ }

  " Refactoring tools
  nnoremap <buffer> grap :RAddParameter<CR>
  nnoremap <buffer> grel :RExtractLet<CR>
  vnoremap <buffer> grec :RExtractConstant<CR>
  vnoremap <buffer> grev :RExtractLocalVariable<CR>
  vnoremap <buffer> grrv :RRenameLocalVariable<CR>
  vnoremap <buffer> grri :RRenameInstanceVariable<CR>
  vnoremap <buffer> grem :RExtractMethod<CR>

  " Use unite-tag instead of ^] for navigating to tags
  nnoremap <buffer> <C-]> :<C-u>UniteWithCursorWord -buffer-name=tags -immediately tag<CR>

  " Correct typos
  iab <buffer> eif        elsif
  iab <buffer> elseif     elsif
  iab <buffer> ~=         =~
endfunction
" }}}

" Elixir Mappings {{{
autocmd! FileType elixir,eelixir :call s:ElixirDef()
function! s:ElixirDef() abort
  setlocal shiftwidth=2
  setlocal tabstop=2

  " Surround % to %
  let b:surround_{char2nr('%')} = "<% \r %>"
  xmap <buffer> % S%
  " Surround = to %=
  let b:surround_{char2nr('=')} = "<%= \r %>"
  xmap <buffer> _ S=
  " Surround # to #{}
  let b:surround_{char2nr('#')} = "#{\r}"
  xmap <buffer> # S#

  " Correct typos
  iab <buffer> ~=         =~
endfunction
" }}}

" JavaScript/CoffeeScript Mappings {{{
autocmd! BufRead,BufNewFile *.cson set filetype=coffee
autocmd! FileType javascript,coffee :call s:CoffeeDef()
function! s:CoffeeDef() abort
  setlocal iskeyword+=$

  setlocal shiftwidth=2
  setlocal tabstop=2

  " Surround # to #{}
  let b:surround_{char2nr('#')} = "#{\r}"
  xmap <buffer> # S#
  " Surround 4 to ${}
  let b:surround_{char2nr('$')} = "${\r}"
  xmap <buffer> 4 S$

  " Use unite-tag instead of ^] for navigating to tags
  nnoremap <buffer> <C-]> :<C-u>UniteWithCursorWord -buffer-name=tags -immediately tag<CR>
endfunction
" }}}

" Html/Xml Mappings {{{
autocmd! FileType xhtml,html,slim,jade,xml,yaml :call s:WebDef()
function! s:WebDef() abort
  setlocal shiftwidth=2
  setlocal tabstop=2

  " Surround % to {{
  let b:surround_{char2nr('%')} = "{{ \r }}"
  xmap <buffer> % S%
  " Surround = to {{=
  let b:surround_{char2nr('=')} = "{{= \r }}"
  xmap <buffer> _ S=
  " Surround * to <!--
  let b:surround_{char2nr('*')} = "<!-- \r -->"
  xmap <buffer> 8 S*

  " Delete surround tag
  nmap <buffer> <Del> dst

  " Special characters
  iab <buffer> ->> →
  iab <buffer> <<- ←
  iab <buffer> >>  »
  iab <buffer> ^^  ↑
  iab <buffer> VV  ↓
endfunction
" }}}

" Markdown Mappings {{{
autocmd! FileType markdown :call s:MarkdownDef()
function! s:MarkdownDef() abort
  setlocal shiftwidth=2
  setlocal tabstop=2
  setlocal wrap

  " Surround _ to _
  let b:surround_{char2nr('_')} = "_\r_"
  xmap <buffer> _ S_
  " Surround * to **
  let b:surround_{char2nr('*')} = "**\r**"
  xmap <buffer> 8 S*
  " Surround - to ~~
  let b:surround_{char2nr('-')} = "~~\r~~"
  xmap <buffer> - S-

  " Add more parentheses
  let b:AutoPairs = {
        \   '(':')', '[':']', '{':'}', "'":"'", '"':'"', '`':'`',
        \   '“':'”', '‘':'’', '《':'》', '「':'」', '（':'）'
        \ }

  " Insert date and time in Jekyll
  inoremap <buffer> <F2>  <C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR>
  " Hard wrap current paragraph
  nnoremap <buffer> <D-w> gwip
  " Unwrap current paragraph
  nnoremap <buffer> <D-W> vipJ
  " Format all paragraphs in buffer
  nnoremap <buffer> <D-e> ggVGgq
  " Unformat all paragraphs in buffer
  nnoremap <buffer> <D-E> :%norm vipJ<CR>
  " Insert inline link
  vmap <buffer> <D-k> [f]a(
  " Insert inline image
  vmap <buffer> <D-i> [i!<ESC>f]a(

  " Wrap text
  nnoremap <buffer> j gj
  nnoremap <buffer> k gk
  nnoremap <buffer> 0 g0
  nnoremap <buffer> $ g$
  nnoremap <buffer> ^ g^
endfunction
" }}}

" Clojure Mappings {{{
autocmd FileType lisp,clojure,scheme RainbowParentheses
autocmd FileType lisp,clojure,scheme :call s:ClojureDef()
function! s:ClojureDef() abort
  " Make AutoPairs match for these pairs
  let b:AutoPairs = { '(':')', '[':']', '{':'}', '"':'"' }

  " Trigger fireplace Eval
  xnoremap <buffer> <leader><leader> :Eval<CR>
endfunction
" }}}

" Python Mappings {{{
autocmd! FileType python :call s:PythonDef()
function! s:PythonDef() abort
  " Set foldmethod
  setlocal foldmethod=indent

  " Correct typos
  iab <buffer> true       True
  iab <buffer> false      False
  iab <buffer> none       None
  iab <buffer> null       None
  iab <buffer> lamda      lambda
  iab <buffer> &&         and
  iab <buffer> \|\|       or
endfunction
" }}}

" Go Mappings {{{
autocmd! FileType go :call s:GoDef()
function! s:GoDef() abort
  " Disable whitespace checking for an individual buffer
  let b:airline_whitespace_disabled = 1
  " Set foldmethod to syntax
  setlocal foldmethod=syntax

  " Trigger semantic highlight before write
  if (has("gui") || has("termguicolors")) && exists("SemanticHighlight")
    autocmd! BufWritePre *.go :SemanticHighlight
  endif

  " Unite menus for Golang
  nnoremap <buffer> <silent> <leader>gm :<C-u>Unite -buffer-name=menus menu:golang -start-insert<CR>
  " Unite go/decls
  nnoremap <buffer> <silent> <leader>og :<C-u>Unite decls -start-insert<CR>

  " Go specific mappings
  nmap <buffer> <leader>oi <Plug>(go-info)
  nmap <buffer> <leader>od <Plug>(go-doc)
  nmap <buffer> <leader>oD <Plug>(go-describe)
  nmap <buffer> <leader>or <Plug>(go-referrers)
  nmap <buffer> <leader>ol <Plug>(go-metalinter)
  nmap <buffer> <leader>oG <Plug>(go-generate)
  nmap <buffer> <leader>ob <Plug>(go-build)
  nmap <buffer> <leader>or <Plug>(go-rename)
  nmap <buffer> <leader>oR <Plug>(go-run)
  nmap <buffer> <leader>ot <Plug>(go-coverage-toggle)
  nmap <buffer> <leader>oc <Plug>(go-callers)
  nmap <buffer> <leader>oC <Plug>(go-callees)
  nmap <buffer> <leader>os <Plug>(go-callstack)
  nmap <buffer> <leader>oe <Plug>(go-iferr)

  " Overwrite vim-test mappings
  nmap <buffer> <leader>tt <Plug>(go-test)
  nmap <buffer> <leader>tf <Plug>(go-test-func)

  " Alternates between the implementation and test code
  command! -bang A  call go#alternate#Switch(<bang>0, 'edit')
  command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  command! -bang AS call go#alternate#Switch(<bang>0, 'split')

  " Correct typos
  iab <buffer> ;=         :=
  iab <buffer> null       nil
  iab <buffer> stirng     string
  iab <buffer> Springf    Sprintf
endfunction
" }}}

" C/CPP Mappings {{{
autocmd! FileType cpp,c,cc,h,hpp :call s:CppDef()
function! s:CppDef() abort
  " Surround * to /*
  let b:surround_{char2nr('*')} = "/* \r */"
  xmap <buffer> 8 S*

  " Correct typos
  iab <buffer> uis        usi
  iab <buffer> cuot       cout
  iab <buffer> Bool       bool
  iab <buffer> boll       bool
  iab <buffer> Static     static
  iab <buffer> Virtual    virtual
  iab <buffer> True       true
  iab <buffer> False      false
  iab <buffer> String     string
  iab <buffer> prinft     printf
  iab <buffer> pritnt     printf
  iab <buffer> pirntf     printf
  iab <buffer> end;       endl;
  iab <buffer> null       NULL
endfunction
" }}}

" Global Correct typos {{{
iab teh        the
iab nwe        new
iab taht       that
iab fro        for
iab agian      again
iab tyr        try
iab itn        int
iab doulbe     double
iab vodi       void
iab ture       true
iab brake      break
iab breka      break
iab breaka     break
iab labeled    labelled
iab seperate   separate
iab execuse    excuse
iab longtiude  longitude
iab ?8         /*
iab /8         /*
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim:ft=vim:fdm=marker:sw=2:ts=2
