""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM (gVim/Win) Configurations
" Author:    Wang Zhuochun
" Last Edit: 17/Jul/2012 04:13 PM
" vim:fdm=marker
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use Vim settings, rather then Vi settings (much better!). {{
" This must be first, because it changes other options as a side effect.
    set nocompatible
    source $VIMRUNTIME/mswin.vim
    behave mswin
" }}

" Required setting for pathogen plugin loading {{
    call pathogen#infect()
    call pathogen#helptags()
" }}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Colorscheme and fonts {{
    "colorscheme gummybears
    "colorscheme werks
    colorscheme molokai
    let g:molokai_original = 1

    set guifont=Dina:h10:cDEFAULT
    set lines=48 columns=168
" }}

    " , is much easier to reach than \ (\ is used in EasyMotion)
    let mapleader = ","
    let g:mapleader = ","

    " t - autowrap text, c - autowrap comments, r - insert comment leader
    " mM - useful for Chinese characters, q - gq
    set formatoptions+=tcrqmM
    " Syntax highlighting on
    syntax on

    " encoding
    set fileencoding=utf-8
    set encoding=utf-8
    set termencoding=utf-8
    set fileencodings=utf-8,ucs-bom,chinese,gbk

    " enable filetype plugin
    filetype plugin on
    filetype indent on
    filetype on

    " vim settings
    set shortmess=atI                   " No welcome screen in gVim
    set mouse=a                         " Enable Mouse
    set timeoutlen=30                   " Quick timeouts for command combinations
    "set clipboard+=unnamed             " Share the clipboard with system
    set history=888                     " keep 888 lines of command line history
    set ruler                           " show the cursor position all the time
    set relativenumber                  " show line number relatively
    set lazyredraw
    "set nolazyredraw                   " don't redraw while executing marcros |:redraw|
    set hidden                          " change buffer even if it is not saved
    set lbr                             " dont break line within a word
    set showcmd                         " display incomplete commands
    set showmode                        " show current mode
    set autochdir                       " automatically change to current file location
    set cursorline                      " highlight the current line
    set magic                           " Set magic on, for regular expressions
    set winaltkeys=no                   " Set ALT not map to toolbar
    set wildmenu                        " Show autocomplete menus
    set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.jpeg,*.gif,*.png,*.aps,*.vcxproj.*,*$py.class,*.class,
    "set wildchar=<Tab>
    "set wildmode=longest:full,full
    set scrolljump=5                    " lines to scroll when cursor leaves screen
    set scrolloff=6                     " minimum lines to keep above and below cursor

    " related to <TAB> indents
    set shiftwidth=4
    set tabstop=4
    set expandtab
    set smarttab

    " related to indents
    set autoindent                      " always set autoindenting on
    set smartindent
    set cindent                         " indent for c/c++
    set autoread                        " autoread when a file is changed from the outside

" Status line {{
    set laststatus=2                    " Always show the statusline
    set statusline=\[FILE]\ %f%m%r%h\ %w\ \ [PWD]\ %r%{CurrectDir()}%h\ \ %=LINE:\%l/%L\ COL:%c\ %=\[%P]\%{HasPaste()}
    function! CurrectDir()
        let curdir = substitute(getcwd(), "", "", "g")
        return curdir
    endfunction
    function! HasPaste()
        if &paste
            return ' [PASTE MODE] '
        else
            return ''
        endif
    endfunction
" }}

" Related to Search {{
    nnoremap <silent> <leader><space> :noh<cr>
    set ignorecase                      " Ignore case when searching
    set smartcase
    set hlsearch                        " Highlight search things
    set incsearch                       " Make search act like search in modern browsers
    set showmatch                       " Show matching bracets
    set mat=1                           " Blink How many times
" }}

" folding settings {{
    set foldmethod=indent               " fold based on indent
    "set foldmethod=syntax
    set foldnestmax=30                  " deepest fold levels
    set nofoldenable                    " dont fold by default
" }}

    " paste mode, disabling all kinds of smartness when pasting
    set pastetoggle=<F6>

    " Turn backup off
    "set backupdir=$HOME/vi_backup/
    set nobackup
    set nowb
    set noswapfile

    " autocomplete: k:dictionary, f:file, l:line, ]:tag
    inoremap <M-p> <C-x><C-p>
    inoremap <M-n> <C-x><C-n>
    inoremap <M-f> <C-x><C-f>
    inoremap <M-l> <C-x><C-l>
    inoremap <M-k> <C-x><C-k>
    "inoremap <M-]> <C-x><C-]>

    " use <Tab> and <Shift-Tab> to indent in Normal, Visual and Select Mode
    nmap <tab> v>
    nmap <s-tab> v<
    vmap <tab> >gv
    vmap <s-tab> <gv

    " Move a line of text using <up><down>
    nmap <up> ddkP
    nmap <down> ddp
    vmap <up> dkP`[V`]
    vmap <down> dp`[V`]

    " Map F1 to ESC for Laptop
    map <F1> <ESC>
    imap <F1> <ESC>

    " No sound on errors
    set noerrorbells
    set visualbell
    set t_vb=
    set tm=500

    " Set backspace config
    set backspace=start,indent,eol
    set whichwrap+=<,>,b,s

" Persistent undo {{
    if has('persistent_undo')
        set undofile
        if has("unix")
            set undodir=/tmp/,~/tmp,~/Temp
        else
            set undodir=$HOME/temp/
        endif
        set undolevels=1000
        set undoreload=10000
    endif
" }}

" Spell checking {{
    map <leader>ss :setlocal spell!<cr>
    map <leader>sn ]s
    map <leader>sp [s
    map <leader>sa zg
    map <leader>s? z=
" }}

" Toggle Menu and Toolbar {{
    set go=
    map <silent> <F11> :if &guioptions =~# 'T' <Bar>
            \set guioptions-=T <Bar>
            \set guioptions-=m <bar>
        \else <Bar>
            \set guioptions+=T <Bar>
            \set guioptions+=m <Bar>
        \endif<CR>
" }}

" Diff {{
    " Convenient command to see the difference between the current buffer
    " and the file it was loaded from, thus the changes you made.
    " Only define it when not defined already.
    if !exists(":DiffOrig")
      command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                \ | wincmd p | diffthis
    endif

    set diffexpr=MyDiff()
    function! MyDiff()
      let opt = '-a --binary '
      if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
      if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
      let arg1 = v:fname_in
      if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
      let arg2 = v:fname_new
      if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
      let arg3 = v:fname_out
      if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
      let eq = ''
      if $VIMRUNTIME =~ ' '
        if &sh =~ '\<cmd'
          let cmd = '""' . $VIMRUNTIME . '\diff"'
          let eq = '"'
        else
          let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
        endif
      else
        let cmd = $VIMRUNTIME . '\diff'
      endif
      silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
" }}

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins' Settings {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Auto Pairs {{
    let g:AutoPairsShortcutToggle = '<M-a>'
    " force closed-pair jumping instead of inserting. only for ), }, ]
    let g:AutoPairsFlyMode = 0
    " if jumps in mistake, use AutoPairsBackInsert to jump back and insert closed pair
    let g:AutoPairsShortcutBackInsert = '<M-b>'
" }}

" MRU (Most Recent Visited files) plugin {{
    let MRU_Max_Entries   = 200
    let MRU_Window_Height = 12
    nmap <M-o> :MRU<CR>
" }}

" Tabular Alignment {{
    " Align with =
    vnoremap <leader>= :Tab /=<CR>
    " Align with :
    vnoremap <leader>: :Tab /:<CR>
" }}

" zencoding-vim {{
    let g:use_zen_complete_tag = 1
    let g:user_zen_settings = {
    \  'php' : {
    \    'extends' : 'html',
    \    'filters' : 'html,c',
    \  },
    \  'css' : {
    \    'filters' : 'fc',
    \  },
    \  'cshtml' : {
    \    'extends' : 'html',
    \  },
    \  'asp' : {
    \    'extends' : 'html',
    \  },
    \  'xml' : {
    \    'extends' : 'html',
    \  },
    \  'haml' : {
    \    'extends' : 'html',
    \  },
    \}
" }}

" NERDTree && Vim NERDTree {{
    " Open Vim Explorer
    map <C-F10> :Explore<cr>
    " NERDTree Commands - o/go (open), s/gs (vsplit), x (close)
    map <silent> <F10> :NERDTreeTabsToggle<CR>
    " Window open position
    let NERDTreeWinPos = "right"
    " Size of the NERD tree
    let NERDTreeWinSize = 42
    " Make it colourful and pretty
    let NERDChristmasTree = 1
    " Disable 'bookmarks' and 'help'
    let NERDTreeMinimalUI = 0
    " Highlight the selected entry in the tree
    let NERDTreeHighlightCursorline = 1
    " Use a single click to fold/unfold directories
    let NERDTreeMouseMode = 2
    " Don't display these kinds of files in NERDTree
    let NERDTreeIgnore=['\~$', '\.pyc$', '\.pyo$', '\.class$', '\.aps', '\.vcxproj']
" }}

" YankRing {{
    "let g:yangkring_zap_keys = 'f F t T / ?' " remove @ char
    nnoremap <silent> <F9> :YRShow<CR>
    nnoremap <silent> <C-F9> :YRToggle<CR>
    let g:yankring_ignore_operator = 'g~ gu gU ! = gq g? > < zf g@'
    let g:yankring_map_dot = 0

    " Use ,d (or ,dd or ,dj or 20,dd) to delete a line without adding it to the
    " yanked stack (also, in visual mode)
    nmap <silent> <leader>d "_d
    vmap <silent> <leader>d "_d
" }}

" SuperTab 0 - dont remember, 2 - remember until <ESC> {{
    let g:SuperTabRetainCompletionType=2
    let g:SuperTabDefaultCompletionType="<C-x><C-o>"
" }}

" snipMate {{
    let g:snip_author = 'Wang Zhuochun'
" }}

" syntastic {{
    " Do a manual syntastic check
    nnoremap <silent> <F7> :SyntasticCheck<CR>
    " Toggle syntastic between active and passive mode
    nnoremap <silent> <C-F7> :SyntasticToggleMode<CR>
    " error window will be automatically opened and closed
    let g:syntastic_auto_loc_list = 1
    " automatic syntax checking
    let g:syntastic_mode_map = { 'mode': 'passive',
                                 \ 'active_filetypes': [],
                                 \ 'passive_filetypes': [] }
    " statulsine text
    let g:syntastic_stl_format = ' [%E{Err: #%e}%B{, }%W{Warn: #%w}]'
    " syntax checking method for javascript
    let g:syntastic_javascript_checker = 'jshint'
" }}

" Syntax {{
    autocmd! BufRead,BufNewFile *.less set filetype=less 
    autocmd! BufRead,BufNewFile *.json set filetype=json 
" }}

" Numbers.vim {{
    " Toggle between relative line number and absolute line number
    nnoremap ;l :NumbersToggle<cr>
" }}

" EasyMotion {{
    " Change back to pre-1.3 behavior, now use <leader><leader>
    "let g:EasyMotion_leader_key = '<Leader>'
" }}

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Move between tabs and splited Windows easier {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Tab Line Configurations {{
    hi TabLine     cterm=none ctermfg=lightgrey ctermbg=lightblue    guifg=darkgrey guibg=black
    hi TabLineSel  cterm=none ctermfg=lightgrey ctermbg=LightMagenta guifg=white    guibg=dimgrey
    hi TabLineFill cterm=none ctermfg=lightblue ctermbg=lightblue    guifg=black    guibg=black
" }}

" Tab Mappings {{
    nmap <M-_> :tabprevious<cr>
    nmap <M-+> :tabnext<cr>
    nmap <M-1> 1gt
    nmap <M-2> 2gt
    nmap <M-3> 3gt
    nmap <M-4> 4gt
    nmap <M-5> 5gt
    nmap <M-6> 6gt
    nmap <M-7> 7gt
    nmap <M-8> 8gt
    nmap <M-9> 9gt
    nmap <M-0> :tablast<CR>
    nmap <M-t> :tabnew<CR>
    nmap <M-w> :tabclose<CR>
    nmap <M-S-t> <C-W>T
" }}

" Smart way to move btw. windows {{
    nmap <C-j> <C-W>j
    nmap <C-k> <C-W>k
    nmap <C-h> <C-W>h
    nmap <C-l> <C-W>l
" }}

" Use arrows to change the splited windows {{
    nmap <right> <C-W>L
    nmap <left> <C-W>H
    nmap <C-up> <C-W>K
    nmap <C-down> <C-W>J
" }}

" create split {{
    nmap ;v <C-w>v
    nmap ;s <C-w>s
    nmap ;n :vnew<cr>
" }}

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual mode Related {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Some Special Settings for Personal Usage {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Quick edit _vimrc and code_complete template {{
    nmap <leader>0 :e $MYVIMRC<cr>
    nmap <leader>) :tabnew $MYVIMRC<cr>

    " Source the vimrc file after saving it
    "if has("autocmd")
    "  autocmd bufwritepost _vimrc source $MYVIMRC
    "endif
" }}

" Key bidding that save time {{{
    " Remove the Windows ^M - when the encodings gets messed up
    nnoremap <leader>M mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
    " Easier Code Formatting
    nnoremap <leader>F gg=G''
    " Clear trailing whitespace
    nnoremap <leader>S :%s/\s\+$//g<cr>:nohl<cr>
    " Reduce a sequence of blank lines into a single line
    nnoremap <leader>L GoZ<Esc>:g/^[ <Tab>]*$/.,/[^ <Tab>]/-j<CR>Gdd
    " Quick quit and save
    nnoremap <leader>q :q!<CR>
    nnoremap ,, :w!<CR>
    " Buffers
    nnoremap <leader>bd :bdelete!<CR>
    nnoremap <leader>bw :bwipeout<CR> 
    " Quick yanking to the end of the line
    nnoremap Y y$
    " Select the just pasted text
    nnoremap <leader>v V`]

    " Map control-cr to goto new line without comment leader
    inoremap <C-CR> <ESC>o
    inoremap <C-S-CR> <ESC>O
    inoremap <S-CR> <ESC>O
    " delete prev word
    inoremap <C-BS> <c-w>
    nnoremap <del> BdW
    nnoremap <BS> bdW
    nnoremap <S-BS> BdW
    " make space work in normal mode
    nnoremap <space> i<space><ESC>
    " make enter work in normal mode
    nnoremap <CR> i<CR><ESC>
    nnoremap <leader>o o<ESC>
    nnoremap <leader>O O<ESC>
    " some Emacs key bindings in insert mode
    inoremap <C-f> <ESC>i
    inoremap <C-b> <ESC>la
    inoremap <C-a> <ESC>I
    inoremap <C-e> <ESC>A
    "inoremap <C-b> <ESC>Bi
    inoremap <C-w> <ESC>Wi
" }}}

" Global Correct typos {{{
    iab teh        the
    iab fro        for
    iab agian      again
    iab tyr        try
    iab itn        int
    iab doulbe     double
    iab vodi       void
    iab brake;     break;
    iab breka;     break;
    iab breaka;    break;
    iab labeled    labelled
    iab abandonned abandoned
    iab seperate   separate
    iab regester   register
    iab ?8         /**/<LEFT><LEFT>
    iab /8         /**/<LEFT><LEFT>
    iab /*         /**/<LEFT><LEFT>
    iab ?*         /**/<LEFT><LEFT>
    iab uis        usi
    iab cuot       cout
    "iab True       TRUE
    "iab true       TRUE
    "iab False      FALSE
    "iab false      FALSE
    "iab null       NULL
    iab prinft     printf
    iab pritnt     printf
    iab pirntf     printf
    iab boll       bool
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Some Very Powerful Functions {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Deal with Wrapped text {{
    noremap <silent> <leader>w :call ToggleWrap()<cr>
    function! ToggleWrap()
        echo "Wrap Movement On"
        nnoremap <silent> j gj
        nnoremap <silent> k gk
        nnoremap <silent> 0 g0
        nnoremap <silent> $ g$
    endfunction
" }}

" Deal with list showing chars {{
    set list!
    set listchars=eol:¶,tab:»»,trail:·,extends:§,nbsp:·

    noremap <silent> \l :call ToggleList()<cr>
    function! ToggleList()
        echo "List On"
        set list!
    endfunction
" }}

" Add Credits with F2 {{
    " Time Credits with F2 in Insert Mode
    inoremap <F2> <C-R>=strftime("%d/%b/%Y %I:%M %p")<CR>
    " Author Credit with F2 in Normal Mode
    nmap <F2> ms:call TitleDet()<cr>'s
    function! AddTitle()
        call append(0,"/// @file ".expand('%:t'))
        call append(1,"/// @class ".expand('%:t:r'))
        call append(2,"/// @brief `<...>`")
        call append(3,"/// @last edit ".strftime("%d/%b/%Y %I:%M %p"))
        echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
    endf

    "Update Last modification date
    function! UpdateTitle()
        "normal m'
        execute '/@last edit /s@\s[0-9].*$@\=strftime(" %d/%b/%Y %I:%M %p")@'
        normal ''
        execute "noh"
        echohl WarningMsg | echo "Successful in updating the copy right." | echohl None
    endfunction

    function! TitleDet()
        let n = 1
        while n < 8
            let line = getline(n)
            if line =~ '^///\s@last\sedit\S*.*$'
                call UpdateTitle()
                return
            endif
            let n = n + 1
        endwhile
        call AddTitle()
    endfunction
" }}
" }}}
