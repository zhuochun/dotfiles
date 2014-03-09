""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MacVIM Configurations
" Author:    Wang Zhuochun
" Last Edit: 27/Feb/2014 11:12 AM
" vim:fdm=marker
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" The alt (option) key on macs now behaves like the 'meta' key. This means we
" can now use <m-x> or similar as maps. This is buffer local, and it can easily
" be turned off when necessary (for instance, when we want to input special
" characters) with :set nomacmeta.
if has("gui_macvim")
  set macmeta
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NeoBundle Settings {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

NeoBundle 'Shougo/vimproc', {
        \   'build' : {
        \     'windows' : 'make -f make_mingw32.mak',
        \     'cygwin' : 'make -f make_cygwin.mak',
        \     'mac' : 'make -f make_mac.mak',
        \     'unix' : 'make -f make_unix.mak',
        \   },
        \ }

NeoBundle 'AndrewRadev/switch.vim'
    nnoremap + :Switch<CR>
    " Some customized definitions
    let g:switch_custom_definitions =
            \ [
            \   ['else', 'else if', 'elsif'],
            \   ['==', '!='],
            \   ['-=', '+='],
            \   ['if', 'unless'],
            \   ['yes', 'no'],
            \   ['first', 'last'],
            \ ]

NeoBundle 'bling/vim-airline'
    " enable/disable powerline symbols.
    let g:airline_powerline_fonts = 1
    " control which sections get truncated and at what width. >
    let g:airline#extensions#default#section_truncate_width = {
            \   'b': 79,
            \   'x': 60,
            \   'y': 88,
            \   'z': 45,
            \ }
    " enable/disable showing a summary of changed hunks under source control. >
    let g:airline#extensions#hunks#enabled = 0

NeoBundle 'bling/vim-bufferline'

NeoBundle 'bufkill.vim'

NeoBundleLazy 'chrisbra/NrrwRgn', {
            \   'autoload' : {
            \     'commands' : ['NarrowRegion', 'NR']
            \   },
            \ }

NeoBundle 'godlygeek/tabular'
    xnoremap <leader>&     :Tabularize /&<CR>
    xnoremap <leader>=     :Tabularize /=<CR>
    xnoremap <leader>:     :Tabularize /:<CR>
    xnoremap <leader>-     :Tabularize /-<CR>
    xnoremap <leader><bar> :Tabularize /<bar><CR>

NeoBundle 'itchyny/calendar.vim'
    let g:calendar_google_calendar = 1
    nnoremap <F1> :Calendar -view=week<CR>

NeoBundle 'jiangmiao/auto-pairs'
    " toggle auto pairs
    let g:AutoPairsShortcutToggle = '<M-a>'

NeoBundle 'justinmk/vim-sneak'
    " not case censitive
    let g:sneak#use_ic_scs = 1
    " 1-character enhanced 'f'
    nmap f <Plug>Sneak_f
    nmap F <Plug>Sneak_F
    xmap f <Plug>Sneak_f
    xmap F <Plug>Sneak_F
    omap f <Plug>Sneak_f
    omap F <Plug>Sneak_F
    " 1-character enhanced 't'
    nmap t <Plug>Sneak_t
    nmap T <Plug>Sneak_T
    xmap t <Plug>Sneak_t
    xmap T <Plug>Sneak_T
    omap t <Plug>Sneak_t
    omap T <Plug>Sneak_T
    " handle ; -> : remaps
    nmap : <Plug>SneakNext
    nmap ' <Plug>SneakPrevious
    xmap : <Plug>VSneakNext
    xmap ' <Plug>VSneakPrevious

NeoBundle 'kshenoy/vim-signature'

NeoBundleLazy 'kien/tabman.vim', {
            \   'autoload' : {
            \     'commands' : ['TMToggle']
            \   },
            \ }
    nnoremap <F4> :TMToggle<CR>

NeoBundleLazy 'kien/rainbow_parentheses.vim', {
            \   'autoload' : {
            \     'commands' : ['RainbowParenthesesToggle']
            \   },
            \ }

NeoBundle 'Lokaltog/vim-easymotion'
    map \ <Plug>(easymotion-prefix)
    " not case censitive
    let g:EasyMotion_smartcase = 1

NeoBundle 'majutsushi/tagbar'
    nnoremap <F10> :TagbarToggle<CR>
    " sort according to order
    let g:tagbar_sort = 0
    " default is 40
    let g:tagbar_width = 29
    " omit vacant lines
    let g:tagbar_compact = 1
    " auto focus on Tagbar when opened
    let g:tagbar_autofocus = 1
    " default iconchars are too wide (Mac)
    let g:tagbar_iconchars = ['▸', '▾']
    " expand tag folds
    let g:tagbar_autoshowtag = 1

NeoBundle 'matchit.zip'

NeoBundle 'mattn/emmet-vim'
    " <C-y> to enter emmet actions
    " <D-y> to expand input in insert mode
    let g:user_emmet_expandabbr_key = '<D-y>'
    " <D-Y> to goto next point
    let g:user_emmet_next_key = '<M-y>'
    " enable emment functions in insert mode
    let g:user_emmet_mode='i'

NeoBundle 'mhinz/vim-signify'

NeoBundleLazy 'sjl/gundo.vim', {
            \   'autoload' : {
            \     'commands' : ['GundoToggle']
            \   },
            \ }
    nnoremap <F5> :GundoToggle<CR>

NeoBundle 'scrooloose/syntastic'
    " fancy symbols
    let g:syntastic_error_symbol = '✗'
    let g:syntastic_warning_symbol = '∆'
    let g:syntastic_style_error_symbol = '✠'
    let g:syntastic_style_warning_symbol = '≈'
    " manual syntastic check
    nnoremap <silent> <F7>   :SyntasticCheck<CR>
    " toggle syntastic between active and passive mode
    nnoremap <silent> <C-F7> :SyntasticToggleMode<CR>
    " output info about what checkers are available and in use
    nnoremap <silent> <S-F7> :SyntasticInfo<CR>
    " error window will be automatically opened and closed
    let g:syntastic_auto_loc_list = 1
    " height of the location lists that syntastic opens
    let g:syntastic_loc_list_height = 3
    " automatic syntax checking
    let g:syntastic_mode_map = { 'mode': 'active',
                               \ 'active_filetypes': ['javascript', 'ruby'],
                               \ 'passive_filetypes': ['html', 'css', 'c', 'cpp'] }

NeoBundle 'scrooloose/nerdcommenter'
    " use / to toggle comments
    vnoremap <M-/> :call NERDComment('v', "toggle")<CR>
    nnoremap <M-/> :call NERDComment('n', "toggle")<CR>

NeoBundle 'scrooloose/nerdtree'
    " Make it colourful and pretty
    let NERDChristmasTree = 1
    " Size of the NERD tree
    let NERDTreeWinSize = 29
    " Disable 'bookmarks' and 'help'
    let NERDTreeMinimalUI = 1
    " Highlight the selected entry in the tree
    let NERDTreeHighlightCursorline = 1
    " Use a single click to fold/unfold directories
    let NERDTreeMouseMode = 2
    " Don't display these kinds of files in NERDTree
    let NERDTreeIgnore = ['\~$', '\.pyc$', '\.pyo$', '\.class$', '\.aps', '\.vcxproj']

NeoBundle 'jistr/vim-nerdtree-tabs'
    map <F3> <plug>NERDTreeTabsToggle<CR>
    " Do not open NERDTree on startup
    let g:nerdtree_tabs_open_on_gui_startup = 0

NeoBundle 'Shougo/unite.vim'
    " Use recursive file search
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    " File searching like ctrlp.vim, start in insert mode
    nnoremap <silent> <D-i> :<C-u>Unite -start-insert file_rec/async:!<CR>
    nnoremap <silent> <C-p> :<C-u>Unite -start-insert file_rec/async:!<CR>
    " Buffer switching like LustyJuggler
    nnoremap <silent> <D-u> :<C-u>Unite -quick-match buffer<CR>
    nnoremap <silent> <M-u> :<C-u>Unite -quick-match tab<CR>
    " Content searching like ack.vim
    nnoremap <silent> <D-/> :<C-u>Unite -no-quit grep:.<CR>
    nnoremap <silent> <D-f> :<C-u>Unite -no-quit -vertical -resume grep:.<CR>
    " Enabled to track yank history
    let g:unite_source_history_yank_enable = 1
    let g:unite_source_history_yank_save_clipboard = 1
    " Yank history like YankRing
    nnoremap <silent> <D-y> :<C-u>Unite history/yank<CR>
    nnoremap <silent> <D-p> :<C-u>Unite history/yank<CR>
    " Unite spilt position
    let g:unite_split_rule = 'botright'

    " Use ag
    if executable('ag')
        " Use ag in unite grep source.
        let g:unite_source_grep_command = 'ag'
        let g:unite_source_grep_default_opts =
            \ '--line-numbers --nocolor --nogroup --hidden ' .
            \ '--ignore ''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
        let g:unite_source_grep_recursive_opt = ''
    endif

    " Key Mappings in Unite
    autocmd FileType unite call s:unite_my_settings()
    function! s:unite_my_settings() "{{{
        " normal mode settings
        nmap <buffer> o         <Plug>(unite_do_default_action)
        nmap <buffer> <ESC>     <Plug>(unite_exit)
        nmap <buffer> <leader>d <Plug>(unite_exit)

        " insert mode settings
        imap <buffer> <CR>      <Plug>(unite_insert_leave)
        imap <buffer> <TAB>     <Plug>(unite_select_next_line)
        imap <buffer> <S-TAB>   <Plug>(unite_select_previous_line)

        " path settings
        imap <buffer> <C-y>     <Plug>(unite_narrowing_path)
        nmap <buffer> <C-y>     <Plug>(unite_narrowing_path)
        nmap <buffer> <C-j>     <Plug>(unite_toggle_auto_preview)

        " change directory
        nnoremap <silent><buffer><expr> cd     unite#do_action('lcd')

        " replace/rename
        let unite = unite#get_current_unite()
        if unite.profile_name ==# 'search'
            nnoremap <silent><buffer><expr> r  unite#do_action('replace')
        else
            nnoremap <silent><buffer><expr> r  unite#do_action('rename')
        endif

        " toggle preview window
        nnoremap <silent><buffer><expr> p
                    \ empty(filter(range(1, winnr('$')),
                    \ 'getwinvar(v:val, "&previewwindow") != 0')) ?
                    \ unite#do_action('preview') : ":\<C-u>pclose!\<CR>"
    endfunction "}}}

NeoBundle 'Shougo/neomru.vim'
    nnoremap <silent> <D-o> :<C-u>Unite file_mru<CR>
NeoBundle 'Shougo/unite-outline'
    nnoremap <silent> <C-o> :<C-u>Unite outline<CR>

NeoBundleLazy 'Shougo/vimshell.vim', {
            \   'depends' : 'Shougo/vimproc',
            \   'autoload' : {
            \     'commands' : [{ 'name' : 'VimShell',
            \                     'complete' : 'customlist,vimshell#complete'},
            \                   'VimShellExecute', 'VimShellInteractive',
            \                   'VimShellTerminal', 'VimShellPop'],
            \     'mappings' : ['<Plug>(vimshell_'],
            \   },
            \ }
    " default prompt string
    let g:vimshell_prompt = $USER." $ "
    " display current dir
    let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
    " send to interpreter
    nnoremap <D-e> V:VimShellSendString<CR>
    vnoremap <D-e> :VimShellSendString<CR>

NeoBundle 'Shougo/neocomplete.vim'
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#enable_auto_delimiter = 1
    let g:neocomplete#max_list = 29
    " Completion length.
    let g:neocomplete#auto_completion_start_length   = 2
    let g:neocomplete#manual_completion_start_length = 1

    " Plugin key-mappings.
    inoremap <expr><C-g> neocomplete#undo_completion()
    inoremap <expr><C-l> neocomplete#complete_common_string()

    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
        function! s:my_cr_function()
          return pumvisible() ? neocomplete#close_popup() : "\<cr>"
        endfunction

    " <TAB>: completion.
    inoremap <expr><TAB> pumvisible() ? "\<C-n>" :
                \ <SID>check_back_space() ? "\<TAB>" :
                \ neocomplete#start_manual_complete()
        function! s:check_back_space()
            let col = col('.') - 1
            return !col || getline('.')[col - 1] =~ '\s'
        endfunction
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

    " <BS>: close popup and delete backword char.
    inoremap <expr><BS>    neocomplete#smart_close_popup()."\<C-h>"
    " <Space>: Close popup.
    inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

    " Enable omni completion.
    autocmd FileType css,less,sass setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown,mkd setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript,coffee setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType php setlocal omnifunc=phpcomplete#CompleteTags
    autocmd FileType ruby,eruby setlocal omnifunc=rubycomplete#Complete
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
        \   'default'  : '',
        \   'vimshell' : $HOME.'/.vimshell_hist',
        \   'scheme'   : $HOME.'/.gosh_completions',
        \ }

    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns._ = '\h\w*'

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
    endif
    let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
    let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
    let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'

    " Force neocomplete omni func
    let g:neocomplete#force_overwrite_completefunc = 1
    if !exists('g:neocomplete#force_omni_input_patterns')
      let g:neocomplete#force_omni_input_patterns = {}
    endif
    let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'

NeoBundle 'Shougo/neosnippet.vim'
    " Plugin key-mappings.
    imap <D-d> <Plug>(neosnippet_expand_or_jump)
    smap <D-d> <Plug>(neosnippet_expand_or_jump)
    " Alternative
    imap <M-d> <Plug>(neosnippet_jump_or_expand)
    smap <M-d> <Plug>(neosnippet_jump_or_expand)
    " Visual
    xmap <D-d> <Plug>(neosnippet_expand_target)

    " Disables standart snippets, use vim-snippets bundle instead
    let g:neosnippet#disable_runtime_snippets = { '_' : 1 }
    " Enable snipMate compatibility feature.
    let g:neosnippet#enable_snipmate_compatibility = 1
    " Tell Neosnippet about the other snippets
    let g:neosnippet#snippets_directory = '~/.vim/bundle/vim-snippets/snippets'

    " Snippet variables
    let g:snips_author = 'Wang Zhuochun'
    let g:snips_email  = 'stone1551@gmail.com'
    let g:snips_github = 'https://github.com/zhuochun'

    " For snippet_complete marker.
    if has('conceal')
      set conceallevel=2 concealcursor=i
    endif

    " Disable the neosnippet preview candidate window
    " When enabled, there can be too much visual noise
    " especially when splits are used.
    set completeopt-=preview

" A neocomplcache plugin to complete words in English
NeoBundle 'ujihisa/neco-look'

" Plugin for running your tests
NeoBundleLazy 'skalnik/vim-vroom', {
            \   'autoload' : {
            \     'commands' : ['VroomRunTestFile', 'VroomRunNearestTest']
            \   },
            \ }

NeoBundle 'tpope/vim-surround'
    " Shortcuts in visual mode
    xmap ( S)
    xmap { S{
    xmap [ S]
    xmap " S"
    xmap ' S'
    xmap ` S`
    xmap T St
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-eunuch'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-vinegar'
NeoBundle 'tpope/vim-sleuth'

NeoBundle 'terryma/vim-expand-region'
    map <M-=> <Plug>(expand_region_expand)
    map <M--> <Plug>(expand_region_shrink)

NeoBundle 'terryma/vim-multiple-cursors'
    " Disable default mapping: ctrl + n/p/x
    let g:multi_cursor_use_default_mapping = 0
    " New mapping
    let g:multi_cursor_next_key = '<M-,>'
    let g:multi_cursor_prev_key = '<M-.>'
    let g:multi_cursor_skip_key = '<M-m>'
    let g:multi_cursor_quit_key = '<Esc>'

NeoBundle 'vim-scripts/DrawIt'
    " \di start, \ds stop
NeoBundle 'vim-scripts/ZoomWin'
    " <c-w>o : toggle window zooms

NeoBundle 'Yggdroot/indentLine'
    let g:indentLine_char = '┆'

NeoBundle 'zhuochun/vim-snippets'

" dash.app {{{
NeoBundleLazy 'rizzatti/funcoo.vim'
NeoBundleLazy 'rizzatti/dash.vim', {
            \   'depends' : 'rizzatti/funcoo.vim',
            \   'autoload' : {
            \     'commands' : ['Dash']
            \   },
            \ }
" }}}

" text objects {{{
NeoBundle 'kana/vim-textobj-user'
" av/iv for a region between either _s or camelCaseVariables
NeoBundle 'Julian/vim-textobj-variable-segment'
" ar/ir for a ruby block
NeoBundle 'nelstrom/vim-textobj-rubyblock'
" ac/ic for a column block
NeoBundle 'coderifous/textobj-word-column.vim'
" }}}

" writings {{{
NeoBundleLazy 'reedes/vim-wordy', {
            \   'autoload' : {
            \     'commands' : ['WeakWordy', 'WordyWordy', 'JargonWordy',
            \                   'WeaselWordy', 'PassiveWordy', 'TriteWordy'],
            \     'filetypes' : ['mkd', 'markdown', 'text']
            \   },
            \ }

NeoBundleLazy 'junegunn/goyo.vim', {
            \   'autoload' : {
            \     'commands' : ['Goyo']
            \   },
            \ }
    nnoremap <silent> <F11> :Goyo<cr>
" }}}

" language syntax {{{
" HTML
NeoBundle 'othree/html5.vim'
NeoBundle 'nono/vim-handlebars'
NeoBundle 'digitaltoad/vim-jade'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'tpope/vim-haml'
" CSS
NeoBundle 'ap/vim-css-color'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'wavded/vim-stylus'
NeoBundle 'groenewege/vim-less'
NeoBundle 'cakebaker/scss-syntax.vim'
" JavaScript
NeoBundle 'elzr/vim-json'
    let g:vim_json_syntax_conceal = 0
NeoBundle 'kchmck/vim-coffee-script'
    let coffee_compile_vert = 1
    let coffee_watch_vert = 1
    let coffee_run_vert = 1
NeoBundle 'moll/vim-node'
NeoBundle 'othree/javascript-libraries-syntax.vim'
    let g:used_javascript_libs = 'jquery,underscore,backbone,jasmine,angularjs,angularui'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'jelera/vim-javascript-syntax'
" Ruby/Rails
NeoBundle 'vim-ruby/vim-ruby'
    let g:rubycomplete_rails = 1
    let g:rubycomplete_use_bundler = 1
    let g:rubycomplete_load_gemfile = 1
    let g:rubycomplete_buffer_loading = 1
    let g:rubycomplete_classes_in_global = 1
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-rake'
NeoBundle 'tpope/vim-bundler'
NeoBundle 'tpope/vim-cucumber'
NeoBundle 'Keithbsmiley/rspec.vim'
NeoBundle 'duwanis/tomdoc.vim'
" C/Cpp
NeoBundle 'vim-jp/cpp-vim'
NeoBundle 'octol/vim-cpp-enhanced-highlight'
" Markdown
NeoBundle 'plasticboy/vim-markdown'
    let g:vim_markdown_folding_disabled = 1
NeoBundle 'itspriddle/vim-marked'
" Others
NeoBundle 'tpope/vim-git'
" }}}

" colorschemes {{{
NeoBundle 'chriskempson/vim-tomorrow-theme'
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'reedes/vim-colors-pencil'
NeoBundle 'sjl/badwolf'
    let g:badwolf_tabline = 2
NeoBundle 'noahfrederick/vim-hemisu'
NeoBundle 'morhetz/gruvbox'
" }}}

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM Settings {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set colorcolumn=80
set linespace=0
set guifont=Inconsolata-dz\ for\ Powerline:h16

set background=dark
colorscheme Tomorrow-Night-Eighties

" enable filetype plugin
filetype plugin on
filetype indent on
filetype on

" , is easier than \
let g:mapleader = ","
let mapleader = ","
" ; is easier than :
noremap ; :

" syntax highlighting on
syntax on

" formatoptions
" o - insert command leader in o or O
" t - autowrap text
" c - autowrap comments
" r - insert comment leader
" mM - useful for Chinese characters, q - gq
" j - remove comment leader when joining lines
autocmd FileType * setlocal formatoptions-=o

" encoding
set fileencoding=utf-8
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,ucs-bom,chinese,gbk

" status line
set laststatus=2

" basic settings
set shortmess=atI                   " no welcome screen in gVim
set mouse=a                         " enable mouse
set timeoutlen=36                   " quick timeouts for command combinations
set history=999                     " keep 999 lines of command line history
set ruler                           " show the cursor position all the time
set relativenumber                  " show line number relatively
set lazyredraw                      " stops Vim from redrawing during complex operations
set hidden                          " change buffer even if it is not saved
set lbr                             " dont break line within a word
set showcmd                         " display incomplete commands
set showmode                        " show current mode
set cursorline                      " highlight the current line
set magic                           " set magic on, for regular expressions
set winaltkeys=no                   " set ALT not map to toolbar
set autoread                        " autoread when a file is changed from the outside
set shiftround                      " Round indent to multiple of 'shiftwidth'
set shortmess+=filmnrxoOtT          " abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " better Unix / Windows compatibility
set virtualedit=onemore             " allow for cursor beyond last character

set wildmenu                        " show autocomplete menus
set wildignore+=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.min.js
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.aps,*.vcxproj.*
set wildignore+=*$py.class,*.class,*.gem,*.zip
set wildignore+=*/node_modules/*,*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*
set wildignore+=*/log/*,*/tmp/*,*/build/*,*/vendor/bundle/*,*/vendor/cache/*,*/vendor/gems/*

set scrolljump=6                    " lines to scroll when cursor leaves screen
set scrolloff=6                     " minimum lines to keep above and below cursor

" related to <TAB> indents {{{
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab
" }}}

" related to indents {{{
set autoindent                      " always set autoindenting on
set smartindent
set cindent                         " indent for c/c++
" }}}

" word boundary to be a little bigger than the default {{{
set iskeyword-=_,-
set iskeyword+=$,@,%,#,`,!,?
" }}}

" Related to Search {{{
set ignorecase                      " Ignore case when searching
set smartcase
set hlsearch                        " Highlight search things
set incsearch                       " Highlight next match on searching
set showmatch                       " Show matching bracets
set mat=1                           " Blink How many times
" }}}

" folding settings {{{
set foldmethod=indent               " fold based on indent
set foldnestmax=99                  " deepest fold levels
set nofoldenable                    " dont fold by default
" }}}

" list chars {{
set list
set listchars=tab:»»,trail:⌴,extends:❯,precedes:❮,nbsp:_,
set showbreak=↪
" }}

" no sound on errors {{{
set noerrorbells
set visualbell
set t_vb=
set tm=500
" }}}

" set tag generated locations
set tags=./.tags,~/.vim/tags

" backups and undos {{{
"set nobackup
"set nowb
"set noswapfile

" Turn backup on
set backup
set backupdir=/tmp/,~/tmp,~/Temp

" Swap files
set swapfile
set directory=/tmp/,~/tmp,~/Temp

" Persistent undo
if has('persistent_undo')
    set undofile         " So is persistent undo ...

    if has("unix")
        set undodir=/tmp/,~/tmp,~/Temp
    else
        set undodir=$HOME/temp/
    endif

    set undolevels=1000  " Maximum number of changes that can be undone
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
    " F1    Calendar
    " F2    Insert date and time
    inoremap <F2> <C-R>=strftime("%d/%b/%Y %I:%M %p")<CR>
    " F3    Toggle NERDTree
    " F4    Toggle TabMan
    " F5    Toggle Gundo
    " F6    Paste mode
    set pastetoggle=<F6>
    " F7    Tigger Syntastic check
    " F8
    " F9    Toggle iTerm 2
    " F10   Toggle Tagbar
    " F11   Open Goyo Zen Writing
    " F12   Toggle MenuBar
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
    nnoremap Q @@
    " Y: Quick yanking to the end of the line
    nnoremap Y y$
    " H: Go to beginning of line.
    "    Repeated invocation goes to previous line
    nnoremap <expr> H getpos('.')[2] == 1 ? 'k' : '0'
    " L: Go to end of line.
    "    Repeated invocation goes to next line
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
    " <p> Paste Yank, keep cursor position when pasting
    nnoremap p p`[
    nnoremap P P`[
    " <{> Paragraphs backward
    " <}> Paragraphs forward
    " <\> Easymotion
    " <|> Vertical split
    " <a> Append insert
    " <s> Substitue, dont update default register
    vnoremap s "_s
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
    " <c> Change, dont update default register
    nnoremap c "_c
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
    " <leader>0
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
    nnoremap <D-1> 1gt
    nnoremap <D-2> 2gt
    nnoremap <D-3> 3gt
    nnoremap <D-4> 4gt
    nnoremap <D-5> 5gt
    nnoremap <D-6> 6gt
    nnoremap <D-7> 7gt
    nnoremap <D-8> 8gt
    nnoremap <D-9> 9gt
    nnoremap <D-(> :tabprevious<cr>
    nnoremap <D-)> :tabnext<cr>
    nnoremap <D-t> :tab split<CR>
    nnoremap <D-T> :tabnew<CR>
    nnoremap <D-w> :tabclose<CR>

    " Smart way to move btw. windows
    nmap <C-j> <C-W>j
    nmap <C-k> <C-W>k
    nmap <C-h> <C-W>h
    nmap <C-l> <C-W>l

    " Use arrows to change the splited windows
    nmap <right> <C-W>L
    nmap <left> <C-W>H
    nmap <D-up> <C-W>K
    nmap <D-down> <C-W>J

    " _ : Quick horizontal splits
    nnoremap _ :sp<cr>
    " | : Quick vertical splits
    nnoremap <bar> :vsp<cr>

    " Always splits to the right and below
    set splitright
    set splitbelow
" }}}

" <Ctrl-*> key mappings {{{
    " <C-1> Mac Desktop Switch
    " <C-2> Mac Desktop Switch
    " <C-3> Mac Desktop Switch
    " <C-4> Mac Desktop Switch
    " <C-5> Mac Desktop Switch
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
    " <C-u> Switch word case
    inoremap <C-u> <esc>mzg~iw`za
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

" Insert mode Emacs key mappings {{{
    " <C-j>: Move cursor down
    inoremap <expr> <C-j> pumvisible() ? "\<C-e>\<Down>" : "\<Down>"
    " <C-k>: Move cursor up
    inoremap <expr> <C-k> pumvisible() ? "\<C-e>\<Up>" : "\<Up>"
    " <C-h> move word left
    inoremap <C-h> <C-o>b
    " <C-l>: Move word right
    inoremap <C-l> <C-O>w
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
    " <M-t>
    " <M-y>
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

" <D-*> key mappings {{{
    " <D--> Mac Smaller font
    " <D-=> Mac Larger font
    " <D-q> Mac Quit
    " <D-w> Mac Close
    " <D-e> Send to Vimshell Interpreter
    " <D-r>
    " <D-t> New Tab
    " <D-y> (Normal) Yank History
    " <D-y> (Insert) Emmet expand, alias to <C-y>,
    " <D-Y> (Insert) Emmet next, alias to <C-y>,
    " <D-u> Unite files
    " <D-i> Unite buffers
    " <D-o> Unite recent files
    " <D-O> Unite outline
    " <D-p> Unite yank
    " <D-{> Previous Tabs
    " <D-}> Next Tabs
    " <D-a> Mac Select all
    " <D-s> Mac Save
    " <D-d> Snippet autocomplete
    " <D-f> Unite grep
    " <D-g>
    " <D-h>
    " <D-j>
    " <D-k>
    " <D-l> Mac List Errors
    " <D-;> Mac Go to Next Error
    " <D-:> Mac Suggest Correction to Next Error
    " <D-'>
    " <D-z> Mac Undo
    " <D-x> Mac Cut
    " <D-c> Mac Copy
    " <D-v>
    " <D-b>
    " <D-n> Mac New Window
    " <D-m> Mac Minimize windows
    " <D-,> Mac Advance settings
    " <D-.> Cannot map
    " <D-/> Unite grep
" }}}

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual mode related {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" In visual mode, press * or # to search the current selection
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> ? :call VisualSelection('b')<CR>

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
autocmd! bufwritepost .vimrc source $MYVIMRC

" Quick edit _vimrc and code_complete template
noremap <leader>0 :tabe $MYVIMRC<CR>
noremap <leader>) :e $MYVIMRC<CR>

" Remap 0 to first non-blank character
nnoremap 0 ^

" fix broken default regex
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

" C/CPP Mappings {{{
au FileType cpp,c,cc,h,hpp :call s:CppDef()
function! s:CppDef()
    " Surround * to /*
    let b:surround_42 = "/* \r */"
    xmap 8 S*

    " Correct typos
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
au FileType ruby,eruby,rdoc :call s:RubyDef()
function! s:RubyDef()
    setlocal shiftwidth=2
    setlocal tabstop=2

    " edit routes
    command! -buffer EGemfile :e Gemfile
    command! -buffer TGemfile :tabe Gemfile
    command! -buffer ERoutes  :e config/routes.rb
    command! -buffer TRoutes  :tabe config/routes.rb

    " Vimshell shorter command
    command! -buffer Pry  :execute "VimShellInteractive --split='split <bar> resize 19' pry"
    command! -buffer Irb  :execute "VimShellInteractive --split='split <bar> resize 19' irb"

    " Surround % to %
    let b:surround_37 = "<% \r %>"
    xmap % S%
    " Surround = to %=
    let b:surround_61 = "<%= \r %>"
    xmap _ S=
    " Surround # to #{}
    let b:surround_35 = "#{\r}"
    xmap # S#

    " Correct typos
    iab elseif      elsif
    iab ~=         =~
endfunction
" }}}

" CoffeeScript Mappings {{{
au FileType coffee :call s:CoffeeDef()
function! s:CoffeeDef()
    setlocal shiftwidth=2
    setlocal tabstop=2

    " Vimshell shorter command
    command! -buffer Node   :execute "VimShellInteractive --split='split <bar> resize 19' node"
    command! -buffer Coffee :execute "VimShellInteractive --split='split <bar> resize 19' coffee"
endfunction
" }}}

" Html/Xml Mappings {{{
au FileType xhtml,html,xml,yaml,haml :call s:WebDef()
function! s:WebDef()
    setlocal shiftwidth=2
    setlocal tabstop=2

    " Surround % to {{
    let b:surround_37 = "{{ \r }}"
    xmap % S%
    " Surround = to {{=
    let b:surround_61 = "{{= \r }}"
    xmap _ S=
    " Surround * to <!--
    let b:surround_42 = "<!-- \r -->"
    xmap 8 S*

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
au FileType markdown,mkd,md,text :call s:MarkdownDef()
function! s:MarkdownDef()
    setlocal shiftwidth=2
    setlocal tabstop=2

    " Insert date and time in Jekyll
    inoremap <F2> <C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR>
    " Hard wrap current paragraph
    nnoremap <silent><buffer> <D-w>   gwip
    " Unwrap current paragraph
    nnoremap <silent><buffer> <D-S-w> vipJ
    " Format all paragraphs in buffer
    nnoremap <silent><buffer> <D-e>   ggVGgq
    " Unformat all paragraphs in buffer
    nnoremap <silent><buffer> <D-S-e> :%norm vipJ<cr>

    " Surround _ to _
    let b:surround_95 = "_\r_"
    xmap _ S_
    " Surround * to **
    let b:surround_42 = "**\r**"
    xmap 8 S*
    " Surround - to ~~
    let b:surround_45 = "~~\r~~"
    xmap - S-
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
iab execuse    excuse
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
" jekyll post/note
command! Blog  :execute "e ~/Documents/Programming/Web/zhuochun.github.io/"
command! Post  :execute "e ~/Documents/Programming/Web/zhuochun.github.io/_posts/"
command! Draft :execute "e ~/Documents/Programming/Web/zhuochun.github.io/_drafts/new-draft.markdown"

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Installation check.
NeoBundleCheck
