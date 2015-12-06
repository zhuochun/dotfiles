""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MacVIM Configurations
" Author: Wang Zhuochun
" Last Edit: 19/Aug/2015 02:57 AM
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Hello Vim {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
  set nocompatible
endif

" Function to source individual rc files
function! s:source_rc(path)
  execute 'source' fnameescape(expand('~/.vim/rc/' . a:path))
endfunction

" Turn on alt (option) key on macs, which behaves
" like the 'meta' key. Thus we can now use <M-x>
if has("gui_macvim")
  set macmeta
endif

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" NeoBundle runtime setup {{{
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
" }}}

" Source bundles and configurations {{{
call neobundle#begin(expand('~/.vim/bundle/'))
  if neobundle#load_cache()
    NeoBundleFetch 'Shougo/neobundle.vim'
    call s:source_rc('bundles.vim')
    NeoBundleSaveCache
  endif

  call s:source_rc('bundles.rc.vim')
call neobundle#end()
" }}}

" Check installation for new bundles {{{
if !has('vim_starting')
  NeoBundleCheck
endif
" }}}

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM Settings {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Essential {{{
" Enable filetype plugin
filetype plugin on
filetype indent on
filetype on

" Syntax highlighting on
syntax on

" Encoding to utf-8
set fileencoding=utf-8
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,ucs-bom,chinese,gbk

" , is easier than \
let g:mapleader = ","
let mapleader = ","

" ; is easier than :
noremap ; :
noremap : ;
" }}}

" Basic settings {{{
set autoread                 " Autoread when a file is changed from the outside
set mouse=a                  " Enable mouse
set lazyredraw               " Stops redrawing during complex operations
set ttyfast                  " Indicates fast terminal connection
set synmaxcol=999            " Maximum columns to have syntax coloring
set ttimeout                 " Time out on key codes
set timeoutlen=42            " Quick timeouts for command combinations
set history=999              " Keep 999 lines of command line history
set hidden                   " Change buffer even if it is not saved
set nowrap                   " No wrap in default
set display+=lastline        " Always try to display the last line
set linebreak                " Wrap at word boundary, no break within a word
set modeline                 " Make modeline (mode config in file) works
set modelines=2              " Number of lines to checked for set commands
set shortmess+=filmnrxoOtT   " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash
set virtualedit=block,onemore
" }}}

" More settings {{{
set wildmenu                 " Show autocomplete menus
set wildignore+=*.dll,*.o,*.obj,*.bak,*.exe,*.zip
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.bmp
set wildignore+=*~,*.sw?,*.DS_Store
set wildignore+=*$py.class,*.class,*.gem,*.pyc,*.aps,*.vcxproj.*
set wildignore+=.git,.gitkeep,.hg,.svn,.tmp,.coverage,.sass-cache
set wildignore+=log/**,tmp/**,node_modules/**,build/**,_site/**,dist/**
set wildignore+=vendor/bundle/**,vendor/cache/**,vendor/gems/**

set complete-=i
set backspace=indent,eol,start
set whichwrap+=[,],b,s       " Left/right move to prev/next line in insert

set scrolljump=6             " Lines to scroll when cursor leaves screen
set scrolloff=6              " Minimum lines to keep above and below cursor
set sidescroll=3             " Columns to scroll horizontally
set sidescrolloff=6          " Minimal number of screen columns to keep
set synmaxcol=800            " No highlight on lines longer than 800 characters
" }}}

" Indent behaviors {{{
set shiftwidth=4
set shiftround               " Round indent to multiple of 'shiftwidth'
set tabstop=4
set expandtab
set smarttab
set autoindent
set smartindent
set cindent
" }}}

" Searching {{{
set magic                    " Set magic on for regular expressions
set ignorecase               " Ignore case when searching
set smartcase                " Case sensitive when pattern contains upper case characters
set infercase                " Infer the current case in insert completion
set hlsearch                 " Highlight search things
set incsearch                " Highlight next match on searching
set showmatch                " Show matching bracets
set cpoptions-=m             " No match jumping
set matchtime=1              " Time to show the match parenthesis (in 1/10 s)
set matchpairs+=<:>          " < and > are pairs as well
" }}}

" Folding {{{
set nofoldenable             " Fold disabled by default
set foldmethod=indent        " Fold based on indent
set foldnestmax=99           " Deepest fold levels

" Make zO recursively open whatever fold we're in
nnoremap zO zczO

" Focus the current line.
" https://bitbucket.org/sjl/dotfiles
"
" 1. Close all folds.
" 2. Open just the folds containing the current line.
" 3. Move the line to a little bit (15 lines) above the center of the screen.
" 4. Pulse the cursor line.  My eyes are bad.
"
" This mapping wipes out the z mark, which I never use.
nnoremap <C-z> mzzMzvzz15<c-e>`z
" }}}

" Format options {{{
" o - insert command leader in o or O
" t - autowrap text
" c - autowrap comments
" r - insert comment leader
" mM - useful for Chinese characters, q - gq
" j - remove comment leader when joining lines
augroup format_options
  autocmd!
  autocmd FileType * setlocal formatoptions+=j
  autocmd FileType * setlocal formatoptions-=o
augroup END
" }}}

" Word boundary {{{
autocmd! FileType * setlocal iskeyword-=_,-,:
" }}}

" List chars {{{
set list
set listchars=tab:»»,trail:⌴,conceal:…,extends:❯,precedes:❮,nbsp:_
let &showbreak='↪ '
" }}}

" No sound on errors {{{
set noerrorbells
set visualbell t_vb=
set tm=500
" }}}

" What not to save in session {{{
set sessionoptions-=options
set sessionoptions-=globals
set sessionoptions-=folds
set sessionoptions-=help
set sessionoptions-=buffers
" }}}

" Tags, backups and undos {{{
" Set tag locations
set tags=./tags,tags

" Turn backup on
set backup
set backupdir=/tmp/,~/tmp,~/Temp

" Swap files
set noswapfile
set directory=/tmp/,~/tmp,~/Temp

" Enable Persistent undo
if has('persistent_undo')
  set undofile

  if has("unix")
    set undodir=/tmp/,~/tmp,~/Temp
  else
    set undodir=$HOME/temp/
  endif

  " Maximum number of changes that can be undone
  set undolevels=1000
  " Maximum number lines to save for undo on a buffer reload
  set undoreload=1000
endif
" }}}

" Tabs and windows {{{
" Switch between tab 1 ~ 9
for i in range(1, 9)
  exec "nnoremap <D-".i."> ".i."gt"
endfor

" Some tab shortcuts
nnoremap <silent> <M-l> :<C-u>tabnext<CR>
nnoremap <silent> <M-h> :<C-u>tabprevious<CR>
nnoremap <silent> <D-(> :<C-u>tabprevious<CR>
nnoremap <silent> <D-)> :<C-u>tabnext<CR>
nnoremap <silent> <D-t> :<C-u>tab split<CR>
nnoremap <silent> <D-T> :<C-u>tabnew<CR>
nnoremap <silent> <D-w> :<C-u>tabclose<CR>

" Splitting defaults
set splitright
set splitbelow

" Smart way to move btw. windows
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

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM Visual {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Theme {{{
set background=dark
colorscheme jellybeans

set colorcolumn=119
set lines=42 columns=142
" }}}

" Styles {{{
set shortmess=atI            " No welcome screen in gVim
set ruler                    " Show the cursor position all the time
set number                   " Display current line number
set relativenumber           " Show line number relatively
set laststatus=2             " Display status bar in 2 lines
set showcmd                  " Display incomplete commands
set noshowmode               " No show current mode
" }}}

" GUI {{{
" fonts, powerline fonts:
" https://github.com/powerline/fonts
set guifont=Hack:h12
" set guifont=Inconsolata-g\ for\ Powerline:h14
" set guifont=Monoid\ HalfTight\ Retina:h11
" set guifont=M+\ 1m\ for\ Powerline:h14
" set guifont=Meslo\ LG\ L\ DZ\ for\ Powerline:h12

set guicursor=a:blinkon0     " Disable GUI blinking cursor
set guioptions=              " Disable GUI components
set winaltkeys=no            " Set ALT not map to toolbar
" }}}

" Conceal special chars {{{
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

set completeopt-=preview    " no preview window
" }}}

"}}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key Mappings {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Source all mappings
call s:source_rc('mappings.vim')

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Additional Settings {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Source vimrc after saving it {{{
autocmd! BufWritePost .vimrc,bundles.rc.vim source $MYVIMRC
" }}}

" Focus to the last edit line when you reopen a file {{{
autocmd! BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") |
       \     execute 'normal! g`"zvzz' |
       \ endif
" }}}

" Update diff after save {{{
autocmd! InsertLeave,BufWritePost * if &l:diff | diffupdate | endif
" }}}

" Source specific filetype settings {{{
call s:source_rc('filetypes.vim')
" }}}

" Directory related commands {{{
" yank local working directory to clipboard
command! Ywd   :let @+ = expand("%")

" change working directory
command! Cwd   :cd %:p:h
" change local working directory
command! Clwd  :lcd %:p:h

" change directory to the root of the Git repository {{
command! Root call s:root()
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

" Load local vimrc-extra if found {{{
let s:local_vimrc = fnamemodify(resolve(expand('<sfile>')), ':p:h').'/vimrc-extra'
if filereadable(s:local_vimrc)
  execute 'source' s:local_vimrc
endif
" }}}

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim:ft=vim:fdm=marker:sw=2:ts=2
