""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" WinVIM Configurations
" Author: Wang Zhuochun
" Last Edit: 27/Dec/2013 09:13 AM
" vim:fdm=marker
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
source $VIMRUNTIME/mswin.vim
behave mswin

" encoding
set fileencoding=utf-8
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,ucs-bom,chinese,gbk

" enable filetype plugin
filetype plugin on
filetype indent on
filetype on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NeoBundle Settings {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has('vim_starting')
  set runtimepath+=~/vimfiles/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/vimfiles/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
        \ 'windows' : 'make -f make_mingw32.mak',
        \ 'cygwin' : 'make -f make_cygwin.mak',
        \ 'mac' : 'make -f make_mac.mak',
        \ 'unix' : 'make -f make_unix.mak',
        \ },
    \ }

NeoBundle 'AndrewRadev/switch.vim'
    nnoremap + :Switch<CR>
    " Some customized definitions
    let g:switch_custom_definitions =
        \ [
            \ ['else', 'elsif', 'else if'],
            \ ['==', '!='],
            \ ['-=', '+='],
            \ ['if', 'unless'],
            \ ['yes', 'no'],
            \ ['and', 'or'],
            \ ['first', 'last'],
        \ ]

NeoBundle 'bling/vim-airline'
    " enable/disable powerline symbols.
    let g:airline_powerline_fonts = 1
    " control which sections get truncated and at what width. >
    let g:airline#extensions#default#section_truncate_width = {
        \ 'b': 79,
        \ 'x': 60,
        \ 'y': 88,
        \ 'z': 45,
        \ }
    " enable/disable showing a summary of changed hunks under source control. >
    let g:airline#extensions#hunks#enabled = 0

NeoBundle 'bufkill.vim'

NeoBundleLazy 'chrisbra/NrrwRgn', {
            \ 'autoload' : {
            \      'commands' : ['NarrowRegion', 'NR']
            \    },
            \ }

NeoBundle 'godlygeek/tabular'
    vmap <leader>& :Tabularize /&<CR>
    vmap <leader>= :Tabularize /=<CR>
    vmap <leader>; :Tabularize /:\zs<CR>
    vmap <leader>- :Tabularize /-\zs<CR>

NeoBundle 'jiangmiao/auto-pairs'
    " toggle auto pairs
    let g:AutoPairsShortcutToggle = '<M-a>'

NeoBundle 'justinmk/vim-sneak'
    " not case censitive
    let g:sneak#use_ic_scs = 1
    " replace f with Sneak
    nmap f <Plug>SneakForward
    nmap F <Plug>SneakBackward
    xmap f <Plug>SneakForward
    xmap F <Plug>SneakBackward
    " 1-character enhanced 't'
    nmap t <Plug>Sneak_t
    nmap T <Plug>Sneak_T
    xmap t <Plug>Sneak_t
    xmap T <Plug>Sneak_T
    omap t <Plug>Sneak_t
    omap T <Plug>Sneak_T
    " handle ; -> : remaps
    nmap : <Plug>SneakNext
    xmap : <Plug>VSneakNext
    nmap ' <Plug>SneakPrevious
    xmap ' <Plug>VSneakPrevious

NeoBundle 'Keithbsmiley/investigate.vim'
    nnoremap <leader>i :call investigate#Investigate()<CR>

NeoBundle 'Lokaltog/vim-easymotion'
    map \ <Plug>(easymotion-prefix)
    " not case censitive
    let g:EasyMotion_smartcase = 1

NeoBundle 'majutsushi/tagbar'
    nnoremap <F3> :TagbarToggle<CR>
    " modify tagbar settings
    let g:tagbar_left = 0 " dock to the right (default)
    let g:tagbar_autofocus = 1 " auto focus on Tagbar when opened
    let g:tagbar_width = 27 " default is 40
    let g:tagbar_compact = 1 " omit vacant lines
    let g:tagbar_sort = 0 " sort according to order

NeoBundle 'matchit.zip'

NeoBundle 'mattn/emmet-vim'
    " <C-y> to enter emmet actions
    " <M-y> to expand input in insert mode
    let g:user_emmet_expandabbr_key = '<M-y>'
    " enable emment functions in insert mode
    let g:user_emmet_mode='i'

NeoBundle 'scrooloose/syntastic'
    " manual syntastic check
    nnoremap <silent> <F7> :SyntasticCheck<CR>
    " toggle syntastic between active and passive mode
    nnoremap <silent> <C-F7> :SyntasticToggleMode<CR>
    " output info about what checkers are available and in use
    nnoremap <silent> <S-F7> :SyntasticInfo<CR>
    " error window will be automatically opened and closed
    let g:syntastic_auto_loc_list = 1
    " height of the location lists that syntastic opens
    let g:syntastic_loc_list_height = 9
    " automatic syntax checking
    let g:syntastic_mode_map = { 'mode': 'active',
                               \ 'active_filetypes': ['javascript', 'ruby'],
                               \ 'passive_filetypes': ['html', 'css'] }

NeoBundle 'scrooloose/nerdcommenter'
    " use / to toggle comments
    vnoremap <M-/> :call NERDComment('v', "toggle")<CR>
    nnoremap <M-/> :call NERDComment('n', "toggle")<CR>

NeoBundle 'scrooloose/nerdtree'
    " Make it colourful and pretty
    let NERDChristmasTree = 1
    " size of the NERD tree
    let NERDTreeWinSize = 27
    " Disable 'bookmarks' and 'help'
    let NERDTreeMinimalUI = 1
    " Highlight the selected entry in the tree
    let NERDTreeHighlightCursorline = 1
    " Use a single click to fold/unfold directories
    let NERDTreeMouseMode = 2
    " Don't display these kinds of files in NERDTree
    let NERDTreeIgnore=['\~$', '\.pyc$', '\.pyo$', '\.class$', '\.aps', '\.vcxproj']

NeoBundle 'jistr/vim-nerdtree-tabs'
    map <F10> <plug>NERDTreeTabsToggle<CR>
    " Do not open NERDTree on startup
    let g:nerdtree_tabs_open_on_gui_startup = 0

NeoBundle 'Shougo/unite.vim'
    " Use recursive file search
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    " Most recently used files
    nnoremap <M-o> :<c-u>Unite file_mru<CR>
    " File searching like ctrlp.vim, start in insert mode
    nnoremap <M-i> :<c-u>Unite -start-insert file_rec/async:!<CR>
    " Buffer switching like LustyJuggler
    nnoremap <M-u> :<c-u>Unite -quick-match buffer<CR>
    " Content searching like ack.vim
    nnoremap <M-f> :<c-u>Unite grep:.<CR>
    " Enabled to track yank history
    let g:unite_source_history_yank_enable = 1
    " Yank history like YankRing
    nnoremap <M-h> :<c-u>Unite history/yank<CR>
    nnoremap <M-p> :<c-u>Unite history/yank<CR>
    " Unite spilt position
    let g:unite_split_rule = 'botright'

    " Key Mappings in Unite
    autocmd FileType unite call s:unite_my_settings()
    function! s:unite_my_settings() "{{{
        " Overwrite settings.
        nmap <buffer> <ESC> <Plug>(unite_exit)
        nmap <buffer> <leader>d <Plug>(unite_exit)

        imap <buffer> <CR> <Plug>(unite_insert_leave)
        imap <buffer> <TAB> <Plug>(unite_select_next_line)
        imap <buffer> <S-TAB> <Plug>(unite_select_previous_line)
    endfunction "}}}

NeoBundle 'Shougo/unite-outline'

NeoBundle 'Shougo/neocomplcache.vim'
    " Use neocomplcache.
    let g:neocomplcache_enable_at_startup = 1
    " Use smartcase.
    let g:neocomplcache_enable_smart_case = 1
    " Use camel case completion.
    let g:neocomplcache_enable_camel_case_completion = 1
    " Use underbar completion.
    let g:neocomplcache_enable_underbar_completion = 1
    " Completion at 1 char
    let g:neocomplcache_auto_completion_start_length = 1
    " Overwrite complete func!
    let g:neocomplcache_force_overwrite_completefunc = 1
    " Less candidate displays
    let g:neocomplcache_max_list = 19

    " Define dictionary.
    let g:neocomplcache_dictionary_filetype_lists = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

    " Plugin key-mappings.
    inoremap <expr><C-g> neocomplcache#undo_completion()
    inoremap <expr><C-l> neocomplcache#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
        return pumvisible() ? neocomplcache#smart_close_popup() : "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
    " <BS>: close popup and delete backword char.
    inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
    " <SPACE>: Close popup.
    inoremap <expr><Space> pumvisible() ? neocomplcache#smart_close_popup()."\<Space>" : "\<Space>"

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType php setlocal omnifunc=phpcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType ruby,eruby setlocal omnifunc=rubycomplete#Complete
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable heavy omni completion.
    if !exists('g:neocomplcache_omni_patterns')
        let g:neocomplcache_omni_patterns = {}
    endif
    let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
    let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
    let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'

NeoBundle 'Shougo/neosnippet.vim'
    " Plugin key-mappings.
    imap <M-d> <Plug>(neosnippet_expand_or_jump)
    " Alternative
    imap <M-D> <Plug>(neosnippet_jump_or_expand)
    " Visual
    xmap <M-d> <Plug>(neosnippet_expand_target)

    " Enable snipMate compatibility feature.
    let g:neosnippet#enable_snipmate_compatibility = 1
    " Tell Neosnippet about the other snippets
    let g:neosnippet#snippets_directory='~/vimfiles/bundle/vim-snippets/snippets'

    let g:snips_author='Wang Zhuochun'
    let g:snips_email='stone1551@gmail.com'
    let g:snips_github='https://github.com/zhuochun'

    " For snippet_complete marker.
    if has('conceal')
      set conceallevel=2 concealcursor=i
    endif

    " Disable the neosnippet preview candidate window
    " When enabled, there can be too much visual noise
    " especially when splits are used.
    set completeopt-=preview

NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-surround'
    " Shortcuts
    vmap ( S)
    vmap { S{
    vmap [ S]
    vmap " S"
    vmap ' S'
    vmap ` S`
    vmap T St
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-vinegar'

NeoBundle 'terryma/vim-multiple-cursors'
    " Disable default mapping
    let g:multi_cursor_use_default_mapping=0
    " New mapping
    let g:multi_cursor_next_key='<M-,>'
    let g:multi_cursor_prev_key='<M-.>'
    let g:multi_cursor_skip_key='<M-m>'
    let g:multi_cursor_quit_key='<Esc>'

NeoBundle 'Yggdroot/indentLine'

NeoBundle 'zhuochun/vim-snippets'

" text objects {{{
NeoBundle 'kana/vim-textobj-user'
" av/iv for a region between either _s or camelCaseVariables
NeoBundle 'Julian/vim-textobj-variable-segment'
" ar/ir for a ruby block
NeoBundle 'nelstrom/vim-textobj-rubyblock'
" ac/ic for a column block
NeoBundle 'coderifous/textobj-word-column.vim'
" }}}

" language syntax {{{
NeoBundle 'elzr/vim-json'
NeoBundle 'groenewege/vim-less'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'kchmck/vim-coffee-script'
    let coffee_compile_vert = 1
    let coffee_watch_vert = 1
    let coffee_run_vert = 1
NeoBundle 'moll/vim-node'
NeoBundle 'othree/html5.vim'
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'chrisbra/color_highlight'
    let g:colorizer_auto_filetype = 'css,less,scss,scss.css,stylus'
    let g:colorizer_colornames = 0
NeoBundle 'plasticboy/vim-markdown'
    let g:vim_markdown_folding_disabled = 1
NeoBundle 'vim-ruby/vim-ruby'
    let g:rubycomplete_buffer_loading = 1
    let g:rubycomplete_classes_in_global = 1
    let g:rubycomplete_rails = 1
    let g:rubycomplete_load_gemfile = 1
    let g:rubycomplete_use_bundler = 1
" }}}

" writing {{{
NeoBundle 'reedes/vim-wordy'
NeoBundle 'reedes/vim-pencil'
NeoBundle 'junegunn/goyo.vim'
" }}}

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM Styles {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" colorschemes {{{
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'reedes/vim-colors-pencil'
NeoBundle 'sjl/badwolf'
    let g:badwolf_tabline = 2
" }}}

" colorscheme background
set background=dark
" colorschemes
colorscheme badwolf
" vim fonts
set guifont=Inconsolata-dz\ for\ Powerline:h12:cDEFAULT
" vim window size
set lines=42 columns=99
" highlight 80 column
set colorcolumn=80

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM Settings {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" , is much easier than \
" \ is used in EasyMotion
let mapleader = ","
let g:mapleader = ","
" ; is easier than :
noremap ; :

" Syntax highlighting on
syntax on

" formatoptions
" o - insert command leader in o or O
" t - autowrap text
" c - autowrap comments
" r - insert comment leader
" mM - useful for Chinese characters, q - gq
" j - remove comment leader when joining lines
autocmd FileType * setlocal formatoptions-=o
autocmd FileType * setlocal formatoptions+=tcrqmMj

" status line
set laststatus=2

" basic settings
set shortmess=atI                   " No welcome screen in gVim
set mouse=a                         " Enable Mouse
set timeoutlen=33                   " Quick timeouts for command combinations
set history=999                     " keep 999 lines of command line history
set ruler                           " show the cursor position all the time
set relativenumber                  " show line number relatively
set lazyredraw                      " stops Vim from redrawing during complex operations
set hidden                          " change buffer even if it is not saved
set lbr                             " dont break line within a word
set showcmd                         " display incomplete commands
set showmode                        " show current mode
set cursorline                      " highlight the current line
set magic                           " Set magic on, for regular expressions
set winaltkeys=no                   " Set ALT not map to toolbar
set autoread                        " autoread when a file is changed from the outside
set shiftround                      " Round indent to multiple of 'shiftwidth'
set shortmess+=filmnrxoOtT          " abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " better Unix / Windows compatibility
set virtualedit=onemore             " allow for cursor beyond last character

set wildmenu                        " Show autocomplete menus
set wildignore+=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.aps,*.vcxproj.*
set wildignore+=*$py.class,*.class,*.gem,*.zip
set wildignore+=*/node_modules/*,*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*
set wildignore+=*/log/*,*/tmp/*,*/build/*,*/vendor/bundle/*,*/vendor/cache/*,*/vendor/gems/*

set scrolljump=9                    " lines to scroll when cursor leaves screen
set scrolloff=9                     " minimum lines to keep above and below cursor

" related to <TAB> indents
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab

" related to indents
set autoindent        " always set autoindenting on
set smartindent
set cindent           " indent for c/c++

" word boundary to be a little bigger than the default
set iskeyword+=$,@,%,#,`,!,?
set iskeyword-=_,-

" Related to Search {{{
set ignorecase        " Ignore case when searching
set smartcase
set hlsearch          " Highlight search things
set incsearch         " Make search act like search in modern browsers
set showmatch         " Show matching bracets
set mat=1             " Blink How many times
" }}}

" folding settings {{{
set foldmethod=indent " fold based on indent
set foldnestmax=99    " deepest fold levels
set nofoldenable      " dont fold by default
" }}}

" No sound on errors
set noerrorbells
set visualbell
set t_vb=
set tm=500

" backups and undos {{{
set nobackup
set nowb
set noswapfile

" Persistent undo
if has('persistent_undo')
    set undofile
    if has("unix")
        set undodir=/tmp/,~/tmp,~/Temp
    else
        set undodir=$HOME/temp/
    endif
    set undolevels=1000 " Maximum number of changes that can be undone
    set undoreload=1000 " Maximum number lines to save for undo on a buffer reload
endif
" }}}

" Set backspace config
set backspace=start,indent,eol
set whichwrap+=<,>,b,s

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key Mappings and Settings {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Function keys {{{
    " F1  Help
    " F2  Insert date and time
    inoremap <F2> <C-R>=strftime("%d/%b/%Y %I:%M %p")<CR>
    " F3  Toggle Tagbar
    " F4  Open Alternative File (c, cpp, rails)
    " F5  Open Alternative File Split (c, cpp, rails)
    " F6  Paste mode
    set pastetoggle=<F6>
    " F7  Manual syntastic check
    " F8  System
    " F9
    " F10 Toggle NERDTree
    " F11
    " F12 Toggle Menu and Toolbar {{{
    set go=
    nnoremap <expr> <F12> <SID>toggle_menubar()
    function! s:toggle_menubar()
        if &guioptions =~# 'T'
            set guioptions-=T
            set guioptions-=m
        else
            set guioptions+=T
            set guioptions+=m
        endif
    endfunction
    " }}}
" }}}

" use <Tab> and <S-Tab> to indent
" in Normal, Visual, Select Mode
nmap <tab> v>
nmap <s-tab> v<
vmap <tab> >gv
vmap <s-tab> <gv

" Move a line of text using <up><down>
" http://vim.wikia.com/wiki/Moving_lines_up_or_down
nnoremap <up> :m .-2<CR>==
nnoremap <down> :m .+1<CR>==
vnoremap <up> :m '<-2<CR>gv=gv
vnoremap <down> :m '>+1<CR>gv=gv

" normal char key mappings {{{
    " Q: to repeat last recorded macro
    nmap Q @@
    " Y: Quick yanking to the end of the line
    nmap Y y$
    " H: Go to beginning of line.
    " Repeated invocation goes to previous line
    nnoremap <expr> H getpos('.')[2] == 1 ? 'k' : '0'
    " L: Go to end of line.
    " Repeated invocation goes to next line
    nnoremap <expr> L <SID>end_of_line()
    function! s:end_of_line()
      let l = len(getline('.'))
      if (l == 0 || l == getpos('.')[2])
        return 'jg_'
      else
        return 'g_'
    endfunction
    " Change folder mappings
    " zo: Open all folds under the cursor recursively
    nnoremap zo zO
    " zO: Open all folds
    nnoremap zO zR
    " zC: Close all folds
    nnoremap zC zM
    " Reselect visual block after indent/outdent
    vnoremap < <gv
    vnoremap > >gv
    " Make space work in normal mode
    nnoremap <space> i<space><ESC>
    " Make enter work in normal mode
    nnoremap <CR> i<CR><ESC>
" }}}

" normal char key mappings {{{
    " <`> Move to mark (linewise)
    " <~> Up/Downcase
    " <0-9> 0-9
    " <!>
    " <@> Register
    " <#> Search word under cursor backwards
    " <$> To the end of the line
    " <%> Move between open/close tags
    " <^> To the first non-blank character of the line.
    " <&> Synonym for `:s` (repeat last substitute)
    " <*> Search word under cursor forwards
    " <(> Sentences backward
    " <)> Sentences forward
    " <_> Horizonal split
    " <->
    " <==> Format current line
    " <+> Switch
    " <S-Delete> Insert Mode Delete word
    " <q*> Record Macro
    " <w> Word forwards
    " <W> Word forwards (CamelCase)
    " <e> Forwards to the end of word
    " <E> Forwards to the end of word
    " <r> Replace char
    " <R> Continous replace
    " <t> find to left (exclusive)
    " <T> find to left (inclusive)
    " <y> Yank into register
    " <u> Undo
    " <i> Insert
    " <o> Open new line below
    " <O> Open new line above
    " <p> Paste Yank
    " <{> Paragraphs backward
    " <}> Paragraphs forward
    " <\> Easymotion
    " <|> Vertical split
    " <a> Append insert
    " <s> Substitue
    " <d> Delete
    " <f> find to right (exclusive)
    " <F> find to right (inclusive)
    " <g> Go
    " <h> Left
    " <j> Down
    " <J> Join Sentences
    " <k> Up
    " <l> Right
    " <;> Repeat last find f,t,F,T
    " <:> Comamnd Input
    " <''> Move to previous context mark, alias to <m'>
    " <'*> Move to {a-zA-Z} mark
    " <CR> Open new line at cursor
    " <z*> Folds
    " <x> Delete char cursor
    " <c> Change
    " <v> Visual
    " <b> Words Backwards
    " <B> Words Backwards (CamelCase)
    " <n> Next search
    " <N> Previous search
    " <m*> Set mark {a-zA-Z}
    " <,> Repeat last find f,t,F,T in opposite direction
    " <.> Repeat last command
" }}}


" <leader>* key mappings {{{
    " <leader>1
    " <leader>2
    " <leader>3
    " <leader>4
    " <leader>5
    " <leader>6
    " <leader>7
    " <leader>8
    " <leader>9
    " <leader>0 edit VIMRC
    " <leader>-
    " <leader>= align with =
    " <leader>q quick quit without save
    nnoremap <leader>q :q!<CR>
    " <leader>w
    nnoremap <leader>w :call ToggleWrap()<CR>
    function! ToggleWrap()
        nnoremap j gj
        nnoremap k gk
        nnoremap 0 g0
        nnoremap $ g$
        nnoremap ^ g^
    endfunction
    " <leader>W
    nnoremap <Leader>W :w<CR>
    " <leader>e
    " <leader>r
    " <leader>t
    " <leader>y
    " <leader>u
    " <leader>i
    " <leader>o
    " <leader>p
    " <leader>a
    " <leader>s spell checkings
        nnoremap <leader>ss :setlocal spell!<cr>
        nnoremap <leader>sn ]s
        nnoremap <leader>sp [s
        nnoremap <leader>sa zg
        nnoremap <leader>s? z=
    " <leader>S clear trailing whitespace
    nnoremap <leader>S :%s/\s\+$//ge<cr>:nohl<cr>
    nnoremap \s :%s/\s\+$//ge<cr>:nohl<cr>
    " <leader>d close buffer
    nnoremap <leader>d :BD<CR>
    " <leader>D close buffer
    nnoremap <leader>D :bdelete<CR>
    nnoremap \d :bdelete<CR>
    nnoremap \q :bdelete<CR>
    " <leader>f easier code formatting
    nnoremap <leader>f gg=G''
    " <leader>g
    " <leader>h
    " <leader>j
    " <leader>k
    " <leader>l
    " <leader>L reduce a sequence of blank lines into a single line
    nnoremap <leader>L GoZ<Esc>:g/^[ <Tab>]*$/.,/[^ <Tab>]/-j<CR>Gdd
    " <leader>z
    " <leader>x
    " <leader>c
    " <leader>v select the just pasted text
    nnoremap <leader>v V`]
    " <leader>b
    " <leader>n
    " <leader>m
    " <leader>M remove the ^M - when the encodings gets messed up
    nnoremap <leader>M mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
    nnoremap \m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
    " <leader><space> close search highlight
    nnoremap <silent> <leader><space> :noh<cr>
" }}}

" Tabs and Windows mappings {{{
    " Tab Mappings
    nnoremap <M-1> 1gt
    nnoremap <M-2> 2gt
    nnoremap <M-3> 3gt
    nnoremap <M-4> 4gt
    nnoremap <M-5> 5gt
    nnoremap <M-6> 6gt
    nnoremap <M-7> 7gt
    nnoremap <M-8> 8gt
    nnoremap <M-9> 9gt
    nnoremap <M-(> :tabprevious<cr>
    nnoremap <M-)> :tabnext<cr>
    nnoremap <M-t> :tab split<CR>
    nnoremap <M-T> :tabnew<CR>
    nnoremap <M-w> :tabclose<CR>

    " Smart way to move btw. windows
    nmap <C-j> <C-W>j
    nmap <C-k> <C-W>k
    nmap <C-h> <C-W>h
    nmap <C-l> <C-W>l

    " Use arrows to change the splited windows
    nmap <right> <C-W>L
    nmap <left> <C-W>H
    nmap <C-up> <C-W>K
    nmap <C-down> <C-W>J
    nmap <M-up> <C-W>K
    nmap <M-down> <C-W>J

    " _ : Quick horizontal splits
    nnoremap _ :sp<cr>
    " | : Quick vertical splits
    nnoremap <bar> :vsp<cr>

    " Always splits to the right and below
    set splitright
    set splitbelow
" }}}

" <Ctrl-*> key mappings {{{
    " <C-1>
    " <C-2>
    " <C-3>
    " <C-4>
    " <C-5>
    " <C-6>
    " <C-7>
    " <C-8>
    " <C-9>
    " <C-0>
    " <C-->
    " <C-=>
    " <C-q> Multiple select
    " <C-w>
    " <C-e>
    " <C-r>
    " <C-t>
    " <C-y> Emmet Expand
    " <C-u>
    " <C-i>
    " <C-o>
    " <C-p>
    " <C-a>
    " <C-s>
    " <C-d>
    " <C-f>
    " <C-g>
    " <C-h> (n) move to left window
    " <C-j> (n) move to down window
    " <C-k> (n) move to up window
    " <C-l> (n) move right window
    " <C-;>
    " <C-'>
    " <C-CR> Like in Visual Studio
    inoremap <C-CR> <ESC>o
    " <C-S-CR> Like in Visual Studio
    inoremap <C-S-CR> <ESC>O
    " <S-CR> Like in Visual Studio
    inoremap <S-CR> <ESC>O
    " <C-z>
    " <C-x>
    " <C-c>
    " <C-v>
    " <C-b>
    " <C-n>
    " <C-m>
    " <C-,>
    " <C-.>
" }}}

" I/C mode Emacs key mappings {{{
    " <C-j>: Move cursor down
    inoremap <expr> <C-j> pumvisible() ? "\<C-e>\<Down>" : "\<Down>"
    " <C-k>: Move cursor up
    inoremap <expr> <C-k> pumvisible() ? "\<C-e>\<Up>" : "\<Up>"
    " <C-h> move word left
    inoremap <C-h> <C-o>b
    " <C-l>: Move word right
    inoremap <C-l> <C-o>w
    " <C-f>: Move move cursor left
    inoremap <C-f> <LEFT>
    " <C-b>: Move move cursor right
    inoremap <C-b> <RIGHT>

    " <C-a>: command mode HOME
    cnoremap <C-a> <HOME>
    " <C-e>: command mode END
    cnoremap <C-e> <END>
    " <C-h>: command mode cursor left
    cnoremap <C-h> <S-LEFT>
    " <C-l>: command mode cursor right
    cnoremap <C-l> <S-RIGHT>
    " <C-@>: command mode show command history
    cnoremap <C-@> <C-f>
" }}}

" <M-*> key mappings {{{
    " <M-q>
    " <M-w>
    " <M-e>
    " <M-r>
    " <M-t> New tab
    " <M-y> (Normal) Yank History
    " <M-y> (Insert) Emmet expand, alias to <C-y>,
    " <M-u> Unite files
    " <M-i> Unite buffers
    " <M-o> Unite MRU
    " <M-p> Yankstack old
    " <M-P> Yankstack new
    " <M-[>
    " <M-]>
    " <M-a>
    " <M-s> Unite Search
    " <M-d> Snippet autocomplete
    " <M-f>
    " <M-g>
    " <M-h>
    " <M-j> Move selected line down
    " <M-k> Move selected line up
    " <M-l>
    " <M-;>
    " <M-'>
    " <M-z>
    " <M-x>
    " <M-c>
    " <M-v>
    " <M-b>
    " <M-n>
    " <M-m>
    " <M-m> vim-multiple-cursors: skip
    " <M-,> vim-multiple-cursors: next
    " <M-.> vim-multiple-cursors: prev
    " <M-/> NERDComment
" }}}

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual mode related {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" In visual mode, press * or # to search the current selection
    vnoremap <silent> * :call VisualSelection('f')<CR>
    vnoremap <silent> # :call VisualSelection('b')<CR>

    function! VisualSelection(direction) range
        let l:saved_reg = @"
        execute "normal! vgvy"

        let l:pattern = escape(@", '\\/.*$^~[]')
        let l:pattern = substitute(l:pattern, "\n$", "", "")

        if a:direction == 'b'
            execute "normal ?" . l:pattern . "^M"
        elseif a:direction == 'gv'
            call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
        elseif a:direction == 'replace'
            call CmdLine("%s" . '/'. l:pattern . '/')
        elseif a:direction == 'f'
            execute "normal /" . l:pattern . "^M"
        endif

        let @/ = l:pattern
        let @" = l:saved_reg
    endfunction
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Additional Settings {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Source the vimrc file after saving it
autocmd! bufwritepost _vimrc source $MYVIMRC

" Quick edit _vimrc and code_complete template
nnoremap <leader>0 :tabe $MYVIMRC<CR>
nnoremap <leader>) :e $MYVIMRC<CR>

" Remap 0 to first non-blank character
nnoremap 0 ^

" fix broken default regex
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

" C/CPP Mappings {{{
au FileType cpp,c,cc,h,hpp :call CppDef()
function! CppDef()
    " FSwitch (support cpp better than a.vim) {{{
    nmap <silent> <F4>   :FSHere<CR>
    nmap <silent> <F5>   :FSSplitRight<CR>
    nmap <silent> <C-F5> :FSSplitLeft<CR>
    " }}}

    " Correct typos that only in C/Cpp
    iab uis        usi
    iab cuot       cout
    iab itn        int
    iab Bool       bool
    iab boolean    bool
    iab Static     static
    iab Virtual    virtual
    iab True       true
    iab False      false
    iab String     string
    iab prinft     printf
    iab pritnt     printf
    iab pirntf     printf
    iab boll       bool
    iab end;       endl;
    iab color      colour
    iab null       NULL
endfunction
" }}}

" Ruby Mappings {{{
au FileType ruby,eruby,rdoc :call RubyDef()
function! RubyDef()
    setlocal shiftwidth=2
    setlocal tabstop=2

    " vim-rails
    " alternative files (usually tests) in split
    nnoremap <F4>   :AS<CR>
    " related files (Split, Tab)
    nnoremap <F5>   :R<CR>
    nnoremap <C-F5> :RS<CR>
    nnoremap <M-F5> :RT<CR>

    " edit routes
    command! Rroutes :e config/routes.rb

    " Surround % to %
    let b:surround_37 = "<% \r %>"
    xmap % S%
    " Surround = to %=
    let b:surround_61 = "<%= \r %>"
    xmap _ S=

    " Correct typos
    iab elseif     elsif
    iab ~=         =~
endfunction
" }}}

" CoffeeScript Mappings {{{
au FileType coffee :call CoffeeDef()
function! CoffeeDef()
    setlocal shiftwidth=2
    setlocal tabstop=2

    " Vimshell shorter command
    cab <buffer> Coffee VimShellInteractive --split='split <bar> resize 19' coffee
    cab <buffer> Eval   VimShellSendString
endfunction
" }}}

" Html/Xml Mappings {{{
au FileType xhtml,html,xml,yaml :call WebDef()
function! WebDef()
    setlocal shiftwidth=2
    setlocal tabstop=2

    " Surround % to {{
    let b:surround_37 = "{{ \r }}"
    xmap % S%
    " Surround = to {{=
    let b:surround_61 = "{{= \r }}"
    xmap _ S=

    " Delete surround tag
    nmap <Del> dst

    " Correct typos
    iab colour color
    iab ->> →
    iab <<- ←
    iab ^^  ↑
    iab VV  ↓
    iab aa  λ
endfunction
" }}}

" Markdown Mappings {{{
au FileType markdown :call MarkdownDef()
function! MarkdownDef()
    setlocal shiftwidth=2
    setlocal tabstop=2

    " F2  Insert date and time in Jekyll
    inoremap <F2> <C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR>

    " Surround _ to _
    let b:surround_95 = "_\r_"
    xmap _ S_
    " Surround * to **
    let b:surround_42 = "**\r**"
    xmap 8 S*
    " Surround ~ to ```
    let b:surround_126 = "```\r```"
    xmap 1 S~

    " Check spell
    setlocal spell

    " Correct typos
    iab ->> →
    iab <<- ←
endfunction
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
iab seperate   separate
iab regester   register
iab ture       true
iab ?8         /*
iab /8         /*
iab /*         /*
" }}}

" change working directory
cab cwd        cd %:p:h
" change local working directory
cab lwd        lcd %:p:h
" edit in tab, split, vsplit
cab t          tabe

" list chars {{
set list
set listchars=tab:»»,trail:¬,extends:§,nbsp:·
" }}

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Installation check.
NeoBundleCheck

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
