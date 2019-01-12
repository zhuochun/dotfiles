" Styles {{{
set colorcolumn=119
set background=dark
set shortmess=atI            " No welcome screen in gVim
set shortmess+=filmnrxoOtT   " Abbrev. of messages (avoids 'hit enter')
set title                    " Display title
"set ruler                   " Show the cursor position all the time
"set number                  " Display current line number
"set relativenumber          " Show line number relatively
set laststatus=2             " Display status bar in 2 lines
set showcmd                  " Display incomplete commands
set noshowmode               " No show current mode

if has("termguicolors") && !has('gui_running')
  set termguicolors
endif

if !exists('g:syntax_on')
  syntax enable
endif
" }}}

" , is easier than \ {{{
let g:mapleader = ","
let mapleader = ","
" }}}

" Settings {{{
set autoread                 " Autoread when a file is changed from the outside
set backspace=indent,eol,start
set display+=lastline        " Always try to display the last line
set mouse=a                  " Enable mouse
set lazyredraw               " Stops redrawing during complex operations
set ttyfast                  " Indicates fast terminal connection
set synmaxcol=190            " Maximum columns to have syntax coloring
set ttimeout                 " Time out on key codes
set timeoutlen=42            " Quick timeouts for command combinations
set history=999              " Keep 999 lines of command line history
set hidden                   " Change buffer even if it is not saved
set nowrap                   " No wrap in default
set linebreak                " Wrap at word boundary, no break within a word
set whichwrap+=[,],b,s       " Left/right move to prev/next line in insert
set display+=lastline        " Always try to display the last line
set modeline                 " Make modeline (mode config in file) works
set modelines=2              " Number of lines to checked for set commands
set cpoptions-=m             " No match jumping
set nojoinspaces             " Use one space after punctuation
set viewoptions=folds,options,cursor,unix,slash
set virtualedit=block,onemore

set wildmenu                 " Command line autocomplete menus
set wildignore+=*.dll,*.o,*.obj,*.bak,*.exe,*.zip
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.bmp
set wildignore+=*~,*.sw?,*.DS_Store
set wildignore+=*$py.class,*.class,*.gem,*.pyc,*.aps,*.vcxproj.*
set wildignore+=.git,.gitkeep,.hg,.svn,.tmp,.coverage,.sass-cache
set wildignore+=log/**,tmp/**,node_modules/**,build/**,_site/**,dist/**
set wildignore+=vendor/bundle/**,vendor/cache/**,vendor/gems/**

set scrolljump=6             " Lines to scroll when cursor leaves screen
set scrolloff=6              " Minimum lines to keep above and below cursor
set sidescroll=3             " Columns to scroll horizontally
set sidescrolloff=6          " Minimal number of screen columns to keep
" }}}

" Indentation {{{
set tabstop=4
set shiftwidth=4
set shiftround               " Round indent to multiple of 'shiftwidth'
set expandtab
set smarttab
set autoindent
set smartindent
set cindent
" }}}

" Search {{{
set magic                    " Set magic on for regular expressions
set ignorecase               " Ignore case when searching
set smartcase                " Case sensitive when pattern contains upper case characters
set infercase                " Infer the current case in insert completion
set hlsearch                 " Highlight search things
set incsearch                " Highlight next match on searching
set showmatch                " Show matching brackets
set matchtime=1              " Time to show the match parenthesis (in 1/10 s)
set matchpairs+=<:>          " < and > are pairs as well
" }}}

" Folding {{{
set nofoldenable             " Fold disabled by default
set foldmethod=indent        " Fold based on indent
set foldnestmax=99           " Deepest fold levels
" }}}

" Tab Split {{{
set splitright
set splitbelow
" }}}

" Format options {{{
" o - insert command leader in o or O
" t - autowrap text
" c - autowrap comments
" q - allow formatting of comments with gq
" r - insert comment leader
" mM - useful for Chinese characters
" j - remove comment leader when joining lines
set formatoptions+=mMjq
set formatoptions-=o
" }}}

" List chars {{{
set list
set listchars=tab:▸\ ,trail:⌴,conceal:…,extends:❯,precedes:❮,nbsp:_
let &showbreak='↪ '
" }}}

" Session options {{{
set sessionoptions-=options
set sessionoptions-=globals
set sessionoptions-=folds
set sessionoptions-=help
set sessionoptions-=buffers
" }}}

" No sound on errors {{{
set noerrorbells
set visualbell t_vb=
set tm=500
" }}}

" Conceal special chars {{{
set conceallevel=2
set concealcursor=i

" https://github.com/mhinz/vim-galore#faster-keyword-completion
set complete-=i              " Disable complete scanning included files
set complete-=t              " Disable complete scanning included tags

set completeopt-=preview    " no preview window
" }}}

" Encoding {{{
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,chinese,gbk
" }}}

" Undo {{{
if has('persistent_undo')
  let &undodir = g:dotvim_root . '/undo'
  set undofile               " Automatically saves undo history
  set undoreload=1000        " Max num of lines to save for undo on buffer reload
endif
"}}}

" Swap {{{
let &directory = g:dotvim_root . '/swap'
set noswapfile               " Do not use swapfile
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim:ft=vim:fdm=marker:sw=2:ts=2
