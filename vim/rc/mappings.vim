" Function keys {{{
" F1    Help screen
" F2    Insert date and time
inoremap <F2> <C-R>=strftime("%d/%b/%Y %I:%M %p")<CR>
" F3    Toggle NERDTree
" F4    Toggle Alternative file
nnoremap <F4> :A<CR>
" F5    Toggle Undotree
" F6    Toggle Paste mode
set pastetoggle=<F6>
" F7    Trigger Lint check
" F8    Trigger Format
" F9    Toggle iTerm 2
" F10   Toggle Tagbar
" F11   Toggle Goyo
" F12   Fullscreen
nnoremap <F12> :set columns=999 lines=999<CR>
" }}}

" Special keys {{{
" Use <Tab> and <S-Tab> to indent
nnoremap <tab>    v>
nnoremap <s-tab>  v<
xnoremap <tab>   >gv
xnoremap <s-tab> <gv

" Move a line of text using <up><down>
" http://vim.wikia.com/wiki/Moving_lines_up_or_down
nnoremap <up>   :m .-2<CR>==
nnoremap <down> :m .+1<CR>==
vnoremap <up>   :m '<-2<CR>gv=gv
vnoremap <down> :m '>+1<CR>gv=gv

" Move to prev/next location list
nnoremap <left>  :lprev<cr>zvzz
nnoremap <right> :lnext<cr>zvzz
" }}}

" Manage windows {{{
" Quickly move among windows
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

" Use arrows to change the splited windows
nmap <S-right> <C-W>L
nmap <S-left>  <C-W>H
nmap <S-up>    <C-W>K
nmap <S-down>  <C-W>J

" Use shift+arrows to resize the windows
nmap <D-S-right> 3<C-W>>
nmap <D-S-left>  3<C-W><
nmap <D-S-up>    3<C-W>+
nmap <D-S-down>  3<C-W>-
" }}}

" Characters (Normal Mode) {{{
" <~>       Switch character case
" <0>       Go to first non-blank character
nnoremap 0 ^
" <!>
" <@>       Register
" <#>       Search word under cursor backwards
" <$>       To the end of the line
" <%>       Move between open/close tags
cnoremap %% <C-R>=expand("%:h") . "/"<CR>
" *<%>      Move to percentage of file
" <^>       To the first non-blank character of the line.
" <&>       Synonym for `:s` (repeat last substitute)
" <*>       Search word under cursor forwards
" <(>       Sentences backward
" <)>       Sentences forward
" <_>       Quick Horizonal split
nnoremap _ :sp<CR>
" <==>      Format current line
" <+>       Switch
" <q>*      Record Macro
" <Q>       Repeat last recorded Macro
nnoremap Q @@
" <w>       Word forwards
" <W>       Word forwards
" <e>       Forwards to the end of word
" <E>       Forwards to the end of word
" <r>       Replace character
" <R>       Continous replace
" <t>       find to left (exclusive)
" <T>       find to left (inclusive)
" <y>       Yank into register
" <Y>       Yanking to the end of line
nnoremap Y y$
" <u>       Undo
" <U>       Undo all latest changes on last changed line
" <i>       Insert
" <I>       Insert at beginning of line
" <o>       Open new line below
" <O>       Open new line above
" <p>       Yankround after
" <P>       Yankround before
" <[>       tpope/unimpaired
" <{>       Paragraphs backward
" <]>       tpope/unimpaired
" <}>       Paragraphs forward
" <\>       Toggle folding
" <|>       Quick vertical split
nnoremap <bar> :vsp<CR>
" <a>       Append insert
" <A>       Append at end of line
" <s>       EasyMotion (1 char)
" <S>       EasyMotion (2 chars)
" <d>       Delete
" <D>       Delete to end of line
" <f>       find to right (exclusive)
" <F>       find to right (inclusive)
" <g>*      Jump to top/center/bottom of screen
nnoremap gh H
nnoremap gm M
nnoremap gl L
" <gq>      Format text in motion
" <go>1-9   Switch between tabs
" <go>a-Z   Unite mappings
" <G>       Go to end of file
" *<G>      Go to specific line number
" <h>       Left
" <H>       Go to beginning of line. Goes to previous line if repeated
nnoremap <expr> H getpos('.')[2] == 1 ? 'k' : '0'
" <j>       Down
" <J>       Join Sentences
" <k>       Up
" <K>       Run a program to lookup the keyword under the cursor
" <l>       Right
" <L>       Go to end of line. Goes to next line if repeated
nnoremap <expr> L <SID>end_of_line()
function! s:end_of_line()
  let l = len(getline('.'))
  if (l == 0 || l == getpos('.')[2])
    return 'jg_'
  else
    return 'g_'
  endif
endfunction
" <;>       Repeat last find f,t,F,T
noremap ; :
" <:>       Input Command
noremap : ;
" <'>*      Move to {a-zA-Z} mark
" <\">*     Registers
" <z>*      Folding
" <zO>      Ecursively open current folds
nnoremap zO zczO
" <x>       Delete char under cursor
" <X>       Delete char before cursor
" <c>       Change, don't update default register
nnoremap c "_c
" <C>       Change to end of line, don't update register
nnoremap C "_C
" <v>       Visual
" <V>       Visual line
" <b>       Words backwards
" <B>       Words backwards
" <n>       Next search
" <N>       Previous search
" <m>*      Set mark {a-zA-Z}
" <M>       Move cursor to centre of line
nnoremap <silent> M :<C-u>call <SID>MoveMiddleOfLine()<CR>
function! s:MoveMiddleOfLine()
  let strwidth = strdisplaywidth(getline('.'))
  let winwidth = winwidth(0)

  if strwidth < winwidth
    call cursor(0, col('$') / 2)
  else
    normal! M
  endif
endfunction
" <,>       Leader
" [<]       Left Indent
vnoremap < <gv
" <.>       Repeat last command
" [>]       Right Indent
vnoremap > >gv
" </>       incsearch.vim
" <?>       incsearch.vim backwards
" <SPACE>   Enter <SPACE>
nnoremap <SPACE> i<SPACE><ESC>
nnoremap <S-SPACE> a<SPACE><ESC>
" <CR>      Enter <CR> at current position
nnoremap <CR> i<CR><ESC>
" }}}

" <leader>* {{{
" <leader>1~9
for i in range(1, 9)
  exec "nnoremap <leader>".i." ".i."gt"
endfor
" <leader>0 Edit vimrc
noremap <leader>0 :tabe $MYVIMRC<CR>
" <leader>) Edit gvimrc
noremap <leader>) :tabe $MYGVIMRC<CR>
" <leader>-
" <leader>=
" <leader>q Quick quit without save
nnoremap <leader>q :q!<CR>
" <leader>w
" <leader>W Toggle wrap related
nnoremap <leader>W :call ToggleWrap()<CR>
function! ToggleWrap()
  nnoremap <buffer> j gj
  nnoremap <buffer> k gk
  nnoremap <buffer> 0 g0
  nnoremap <buffer> $ g$
  nnoremap <buffer> ^ g^
endfunction
" <leader>e
" <leader>r Redraw screen, fix syntax highlighting
nnoremap <leader>r :nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-l>
" <leader>tl Run last test
nnoremap <silent> <leader>tl :TestLast<CR>
" <leader>tn Run nearest test/function
nnoremap <silent> <leader>tn :TestNearest<CR>
nnoremap <silent> <leader>tf :TestNearest<CR>
" <leader>tc Run current file
nnoremap <silent> <leader>tt :TestFile<CR>
" <leader>T  Run current file
nnoremap <silent> <leader>T  :TestFile<CR>
" <leader>y yankround-prev
" <leader>Y yankround-next
" <leader>u
" <leader>i
" <leader>o* Filetype specific operations
" <leader>p
" <leader>a
" <leader>s* Spell checkings
" <leader>sc Unite spell suggest
nnoremap <leader>ss :setlocal spell!<CR>
nnoremap <leader>sa zg
nnoremap <leader>s? z=
" <leader>s* System clipping
vnoremap <leader>sy "+y
nnoremap <leader>sp "+p
" <leader>S Clear trailing whitespace
nnoremap <leader>S :%s/\s\+$//ge<CR>:nohl<CR>
" <leader>d Close buffer and leave Window intact
" <leader>D Close buffer
" <leader>f Find and replace (WritableSearch)
" <leader>F Format file
nnoremap <leader>F gg=G''
" <leader>gf Run Neoformat
" <leader>gm Toggle Unite Menu (filetype specific)
" <leader>hs GitGutterStageHunk
" <leader>hr GitGutterRevertHunk
" <leader>js Format JSON file (python required)
nnoremap <leader>js :%!python -m json.tool<CR>
" <leader>k
" <leader>L Reduce a sequence of blank lines into a single line
nnoremap <leader>L GoZ<ESC>:g/^[ <Tab>]*$/.,/[^ <Tab>]/-j<CR>Gdd
" <leader>z
" <leader>x
" <leader>c
" <leader>v Select the just pasted text
nnoremap <leader>v V`]
" <leader>b
" <leader>B Close other buffers (BufOnly)
" <leader>n MarkClear
" <leader>m MarkSet
" <leader>M Remove ^M
nnoremap <leader>M mmHmt:%s/<C-V><CR>//ge<CR>'tzt'm
" <leader>, Switch between current and last buffer
nnoremap <leader>, <C-^>
" <leader>. Edit macro in the cmdline-window
nnoremap <leader>. :<C-U><C-R><C-R>='let @'. v:register .' = '. string(getreg(v:register))<CR><C-F><LEFT>
" <leader><space> Close search highlight
nnoremap <leader><space> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
" }}}

" <C-*> (Normal Mode) {{{
" <C-1> Mac Desktop Switch
" <C-2> Mac Desktop Switch
" <C-3> Mac Desktop Switch
" <C-4> Mac Desktop Switch
" <C-5> Mac Desktop Switch
" <C-6>
" <C-7>
" <C-8>
" <C-9>
" <C-0> Jump back tap
" <C-->
" <C-=>
" <C-q> Visual block select
" <C-w>
" <C-e>
" <C-r>
" <C-t> Jump back tag stack
" <C-y> Emmet Expand
" <C-u> Page up
" <C-u> Switch word case
inoremap <C-U> <ESC>mzg~iw`za
" <C-i>
" <C-o>
" <C-p> vim-multiple-cursors, prev key
" <C-[> Same as <ESC>
" <C-]> Jump tag
" <C-a>
" <C-s>
" <C-d> Page Down
" <C-f> Easymotion
" <C-g>
" <C-h> Move to left window
" <C-j> Move to down window
" <C-k> Move to up window
" <C-l> Move to right window
" <C-;>
" <C-'>
" <C-CR> Enter a new line below
inoremap <C-CR> <ESC>o
" <S-CR> Enter a new line above
inoremap <S-CR> <ESC>O
" <C-z>  Fold and focus the current line
" https://bitbucket.org/sjl/dotfiles
"
" 1. Close all folds.
" 2. Open just the folds containing the current line.
" 3. Move the line to a little bit (15 lines) above the center of the screen.
" 4. Pulse the cursor line.  My eyes are bad.
"
" This mapping wipes out the z mark, which I never use.
nnoremap <C-z> mzzMzvzz15<c-e>`z
" <C-x> vim-multiple-cursors, skip key
" <C-c>
" <C-v> Visual block select
" <C-b> Switch Buffers
" <C-n> vim-multiple-cursors, next key
" <C-m>
" <C-,>
" <C-.>
" }}}

" <C-*> (Insert Mode) {{{
inoremap <C-B>  <Left>
inoremap <C-F>  <Right>
inoremap <C-A>  <C-O>^
inoremap <C-E>  <End>
inoremap <C-BS> <C-W>
inoremap <D-BS> <S-Right><C-W>
" }}}

" <C-*> (Command Mode) {{{
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
cnoremap <C-N> <Down>
cnoremap <C-P> <Up>
cnoremap <C-K> <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>
cnoremap <C-D> <Del>
cnoremap <C-Y> <C-r>*
" }}}

" <M-*> {{{
" <M-q>
" <M-w> Tab close
" <M-e>
" <M-r>
" <M-t> Tab split
" <M-T> Tab new
" <M-y> Emmet go to prev
" <M-u>
" <M-i>
" <M-o>
" <M-p>
" <M-P>
" <M-[>
" <M-]>
" <M-a>
" <M-s>
" <M-d>
" <M-f>
" <M-g>
" <M-h> Tab previous
nnoremap <silent> <M-h> :<C-u>tabprevious<CR>
" <M-j>
" <M-k>
" <M-l> Tab next
nnoremap <silent> <M-l> :<C-u>tabnext<CR>
" <M-;>
" <M-'>
" <M-z>
" <M-x>
" <M-c>
" <M-v>
" <M-b>
" <M-n>
" <M-m>
" <M-,>
" <M-.>
" <M-/>
" }}}

" <D-*> {{{
" <D-1~9> Switch tabs
for i in range(1, 9)
  exec "nnoremap <D-".i."> ".i."gt"
endfor
" <D--> Mac Smaller font
" <D-=> Mac Larger font
" <D-q> Mac Quit
" <D-w> Mac Close
" <D-e>
" <D-r>
" <D-t> Duplicate current buffer in new tab
nnoremap <silent> <D-t> :<C-u>tab split<CR>
" <D-T> Open a new tab
nnoremap <silent> <D-T> :<C-u>tabnew<CR>
" <D-y>
" <D-y> Emmet expand abbr (insert)
" <D-Y> Emmet next key
" <D-u>
" <D-i> Unite file_rec
" <D-o> Unite file_rec/git
" <D-p>
" <D-{> Previous Tabs
" <D-}> Next Tabs
" <D-a> Mac Select all
" <D-s> Mac Save
" <D-d> Snippet autocomplete jump or expand
" <D-D> Snippet autocomplete expand or jump
" <D-f> Unite grep
" <D-g>
" <D-h> Mac Hide Window
" <D-h> Mac Hide Others
" <D-j>
" <D-k>
" <D-l> Mac List Errors
" <D-;> Mac Go to Next Error
" <D-:> Mac Suggest Correction to Next Error
" <D-'>
" <D-z> Mac Undo
" <D-x> Mac Cut
" <D-c> Mac Copy
" <D-v> Mac Paste
" <D-b>
" <D-n>
" <D-m> Mac Minimize windows
" <D-,> Mac Advance settings
" <D-.> Cannot map
" <D-/> Unite grep
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim:ft=vim:fdm=marker:sw=2:ts=2
