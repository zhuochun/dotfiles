""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MacVIM Configurations
" Author:    Wang Zhuochun
" Last Edit: 24/Nov/2013 11:06 PM
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
    \ 'build' : {
    \   'windows' : 'make -f make_mingw32.mak',
    \   'cygwin' : 'make -f make_cygwin.mak',
    \   'mac' : 'make -f make_mac.mak',
    \   'unix' : 'make -f make_unix.mak',
    \   },
    \ }

NeoBundle 'mhinz/vim-signify'

NeoBundle 'AndrewRadev/switch.vim'
    nnoremap + :Switch<CR>
    " Some customized definitions
    let g:switch_custom_definitions =
            \ [
            \   ['else', 'elsif', 'else if'],
            \   ['&', '|', '^'],
            \   ['==', '!='],
            \   [' + ', ' - '],
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
            \ 'b': 79,
            \ 'x': 60,
            \ 'y': 88,
            \ 'z': 45,
            \ }
    " enable/disable showing a summary of changed hunks under source control. >
    let g:airline#extensions#hunks#enabled = 0

NeoBundle 'bling/vim-bufferline'

NeoBundle 'bufkill.vim'

NeoBundle 'bkad/CamelCaseMotion'
    " use 'W', 'B' and 'E' to navigate
    nmap <silent> <S-w> <Plug>CamelCaseMotion_w
    nmap <silent> <S-b> <Plug>CamelCaseMotion_b
    nmap <silent> <S-e> <Plug>CamelCaseMotion_e
    xmap <silent> <S-w> <Plug>CamelCaseMotion_w
    xmap <silent> <S-b> <Plug>CamelCaseMotion_b
    xmap <silent> <S-e> <Plug>CamelCaseMotion_e

NeoBundleLazy 'derekwyatt/vim-fswitch', {
            \ 'autoload' : {
            \     'filetypes' : ['c', 'cpp'],
            \    },
            \ }

NeoBundle 'godlygeek/tabular'
    vnoremap <leader>&     :Tabularize /&<CR>
    vnoremap <leader>=     :Tabularize /=<CR>
    vnoremap <leader>:     :Tabularize /:<CR>
    vnoremap <leader>-     :Tabularize /-<CR>
    vnoremap <leader><bar> :Tabularize /<bar><CR>

NeoBundle 'jiangmiao/auto-pairs'
    " toggle auto pairs
    let g:AutoPairsShortcutToggle = '<M-a>'

NeoBundle 'justinmk/vim-sneak'
    " not case censitive
    let g:sneak#use_ic_scs = 0
    " replace f with Sneak
    nmap f <Plug>SneakForward
    xmap f <Plug>VSneakForward
    nmap F <Plug>SneakBackward
    xmap F <Plug>VSneakBackward
    " handle my ; -> : remaps
    nmap : <Plug>SneakNext
    xmap : <Plug>VSneakNext
    nmap ? <Plug>SneakPrevious
    xmap ? <Plug>VSneakPrevious

NeoBundle 'kshenoy/vim-signature'

NeoBundle 'majutsushi/tagbar'
    nnoremap <F3> :TagbarToggle<CR>
    " Modify tagbar settings
    let g:tagbar_left = 0                " dock to the right (default)
    let g:tagbar_autofocus = 1           " auto focus on Tagbar when opened
    let g:tagbar_width = 27              " default is 40
    let g:tagbar_compact = 1             " omit vacant lines
    let g:tagbar_sort = 0                " sort according to order

" JavaScript omni complete
NeoBundle 'marijnh/tern_for_vim', {
    \ 'build': {
    \   'mac': 'npm install',
    \   'unix': 'npm install',
    \   'cygwin': 'npm install',
    \   'windows': 'npm install',
    \   },
    \ }

NeoBundle 'matchit.zip'

NeoBundleLazy 'mattn/webapi-vim'
NeoBundleLazy 'mattn/gist-vim', {
            \ 'depends' : 'mattn/webapi-vim',
            \ 'autoload' : {
            \      'commands' : ['Gist']
            \    },
            \ }
    let g:gist_clip_command = 'pbcopy'
    " if you want to detect filetype from the filename
    let g:gist_detect_filetype = 1
    " If you want to show your private gists with :Gist -l
    let g:gist_show_privates = 1
    " If you want your gist to be private by default
    let g:gist_post_private = 1

NeoBundle 'mattn/emmet-vim'
    " <C-y> to enter emmet actions
    " <D-y> to expand input in insert mode
    let g:user_emmet_expandabbr_key = '<D-y>'
    " <D-Y> to goto next point
    let g:user_emmet_next_key = '<D-Y>'
    " enable emment functions in insert mode
    let g:user_emmet_mode='i'

NeoBundle 'maxbrunsfeld/vim-yankstack'
    let g:yankstack_map_keys = 0
    " <M-p> - cycle backward through your history of yanks
    nmap <M-p> <Plug>yankstack_substitute_older_paste
    " <M-P> - cycle forwards through your history of yanks
    nmap <M-P> <Plug>yankstack_substitute_newer_paste

NeoBundleLazy 'rking/ag.vim', {
            \ 'autoload' : {
            \      'commands' : ['Ag']
            \    },
            \ }
    " Ag [options] {pattern} [{directory}]
    nnoremap <D-f> :Ag<Space>

NeoBundleLazy 'sjl/gundo.vim', {
            \ 'autoload' : {
            \      'commands' : ['GundoToggle']
            \    },
            \ }
    nnoremap <F11> :GundoToggle<CR>

NeoBundle 'scrooloose/syntastic'
    " Fancy symbols
    let g:syntastic_error_symbol = '✗'
    let g:syntastic_style_error_symbol = '✠'
    let g:syntastic_warning_symbol = '∆'
    let g:syntastic_style_warning_symbol = '≈'
    " Do a manual syntastic check
    nnoremap <silent> <F7>   :SyntasticCheck<CR>
    " Toggle syntastic between active and passive mode
    nnoremap <silent> <C-F7> :SyntasticToggleMode<CR>
    " Output info about what checkers are available and in use
    nnoremap <silent> <S-F7> :SyntasticInfo<CR>
    " error window will be automatically opened and closed
    let g:syntastic_auto_loc_list = 1
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
    map <F10> <plug>NERDTreeMirrorToggle<CR>
    " Do not open NERDTree on startup
    let g:nerdtree_tabs_open_on_gui_startup=0

NeoBundle 'Shougo/unite.vim'
    " Use recursive file search
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    nnoremap <D-o> :<C-u>Unite file_mru<CR>
    " File searching like ctrlp.vim, start in insert mode
    nnoremap <D-i> :<C-u>Unite -start-insert file_rec/async:!<CR>
    " Buffer switching like LustyJuggler
    nnoremap <D-u> :<C-u>Unite -quick-match buffer<CR>
    " Content searching like ack.vim
    nnoremap <D-/> :<C-u>Unite grep:.<CR>
    " Enabled to track yank history
    let g:unite_source_history_yank_enable = 1
    " Yank history like YankRing
    nnoremap <D-y> :<C-u>Unite history/yank<CR>
    " Unite spilt position
    let g:unite_split_rule = 'botright'

    " Use ag
    if executable('ag')
        " Use ag in unite grep source.
        let g:unite_source_grep_command = 'ag'
        let g:unite_source_grep_default_opts =
            \ '--line-numbers --nocolor --nogroup --hidden --ignore ' .
            \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
        let g:unite_source_grep_recursive_opt = ''
    endif

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

NeoBundleLazy 'Shougo/vimfiler.vim', {
            \ 'depends' : 'Shougo/unite.vim',
            \ 'autoload' : {
            \    'commands' : [{ 'name' : 'VimFiler',
            \                    'complete' : 'customlist,vimfiler#complete' },
            \                  'VimFilerExplorer',
            \                  'Edit', 'Read', 'Source', 'Write'],
            \    'mappings' : ['<Plug>(vimfiler_'],
            \    'explorer' : 1,
            \ }
            \ }
    " open vimfiler
    nnoremap <C-F10> :<C-U>:VimFilerExplorer -toggle<CR>
    " ignore files with filename patterns
    let g:vimfiler_ignore_pattern = '^\%(.git\|.DS_Store\|.pyc\|.vcxproj\)$'
    " <C-l> <Plug>(vimfiler_redraw_screen)
    " c     <Plug>(vimfiler_copy_file)
    " m     <Plug>(vimfiler_move_file)
    " d     <Plug>(vimfiler_delete_file)
    " r     <Plug>(vimfiler_rename_file)
    " K     <Plug>(vimfiler_make_directory)
    " N     <Plug>(vimfiler_new_file)
    " e     <Plug>(vimfiler_edit_file)
    " E     <Plug>(vimfiler_split_edit_file)
    " Q     <Plug>(vimfiler_exit)
    " t     <Plug>(vimfiler_expand_tree)

NeoBundleLazy 'Shougo/vimshell.vim', {
            \ 'depends' : 'Shougo/vimproc',
            \ 'autoload' : {
            \   'commands' : [{ 'name' : 'VimShell',
            \                   'complete' : 'customlist,vimshell#complete'},
            \                 'VimShellExecute', 'VimShellInteractive',
            \                 'VimShellTerminal', 'VimShellPop'],
            \   'mappings' : ['<Plug>(vimshell_']
            \ }
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
    let g:neocomplete#max_list = 23
    " Completion length.
    let g:neocomplete#auto_completion_start_length = 2
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
    function! s:check_back_space() "{{{
        let col = col('.') - 1
        return !col || getline('.')[col - 1] =~ '\s'
    endfunction"}}}
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
    " <BS>: close popup and delete backword char.
    inoremap <expr><BS>  neocomplete#smart_close_popup()."\<C-h>"
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
        \ 'default'  :  '',
        \ 'vimshell' :  $HOME.'/.vimshell_hist',
        \ 'scheme'   :  $HOME.'/.gosh_completions'
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

    " Enable snipMate compatibility feature.
    let g:neosnippet#enable_snipmate_compatibility = 1
    " Tell Neosnippet about the other snippets
    let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

    " Snippet variables
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

" A neocomplcache plugin to complete words in English
NeoBundle 'ujihisa/neco-look'

NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-rake'
NeoBundle 'tpope/vim-bundler'
NeoBundle 'tpope/vim-surround'
    " Surround % to %
    let b:surround_37 = "<% \r %>"
    " Surround = to %=
    let b:surround_61 = "<%= \r %>"
    " Shortcuts
    xmap ( S)
    xmap { S{
    xmap [ S]
    xmap " S"
    xmap ' S'
    xmap ` S`
    xmap T St
NeoBundle 'tpope/vim-abolish'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-eunuch'

NeoBundle 'terryma/vim-multiple-cursors'
    " Disable default mapping: ctrl + n/p/x
    let g:multi_cursor_use_default_mapping=0
    " New mapping
    let g:multi_cursor_next_key='<M-,>'
    let g:multi_cursor_prev_key='<M-.>'
    let g:multi_cursor_skip_key='<M-m>'
    let g:multi_cursor_quit_key='<Esc>'

NeoBundle 'Valloric/MatchTagAlways'

NeoBundle 'xolox/vim-misc'
NeoBundle 'xolox/vim-easytags'
    let g:easytags_file = '~/.vim/tags'
    let g:easytags_dynamic_files = 1
    let g:easytags_updatetime_warn = 0
NeoBundleLazy 'xolox/vim-notes', {
            \ 'depends' : 'xolox/vim-misc',
            \ 'autoload' : {
            \      'commands' : ['Note']
            \    },
            \ }
    let g:notes_directories = ['~/Dropbox/Mac/Note']
    let g:notes_suffix = '.md'
    let g:notes_tab_indents = 0
    let g:notes_markdown_program = 'kramdown'

NeoBundle 'Yggdroot/indentLine'
    let g:indentLine_char = '┆'

NeoBundle 'zhuochun/vim-snippets'

" dash.app {{{
NeoBundleLazy 'rizzatti/funcoo.vim'
NeoBundleLazy 'rizzatti/dash.vim', {
            \ 'depends' : 'rizzatti/funcoo.vim',
            \ 'autoload' : {
            \      'commands' : ['Dash']
            \    },
            \ }
" }}}

" text objects {{{
NeoBundle 'kana/vim-textobj-user'
" a,/i, for an argument to a function
NeoBundle 'sgur/vim-textobj-parameter'
" av/iv for a region between either _s or camelCaseVariables
NeoBundle 'Julian/vim-textobj-variable-segment'
" ar/ir for a ruby block
NeoBundle 'nelstrom/vim-textobj-rubyblock'
" ac/ic for a column block
NeoBundle 'coderifous/textobj-word-column.vim'
" }}}

" language syntax {{{
NeoBundle 'cakebaker/scss-syntax.vim'
NeoBundle 'digitaltoad/vim-jade'
NeoBundle 'elzr/vim-json'
NeoBundle 'groenewege/vim-less'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'kchmck/vim-coffee-script'
    let coffee_compile_vert = 1
    let coffee_watch_vert = 1
    let coffee_run_vert = 1
NeoBundle 'Keithbsmiley/rspec.vim'
NeoBundle 'moll/vim-node'
NeoBundle 'nono/vim-handlebars'
NeoBundle 'octol/vim-cpp-enhanced-highlight'
NeoBundle 'othree/html5.vim'
NeoBundle 'othree/javascript-libraries-syntax.vim'
    let g:used_javascript_libs = 'jquery,underscore,backbone,requirejs,angularjs'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'chrisbra/color_highlight'
    let g:colorizer_auto_filetype = 'css,less,scss,scss.css,stylus'
    let g:colorizer_colornames = 0
NeoBundle 'tpope/vim-cucumber'
NeoBundle 'tpope/vim-git'
NeoBundle 'tpope/vim-haml'
NeoBundle 'plasticboy/vim-markdown'
    let g:vim_markdown_folding_disabled = 1
NeoBundle 'vim-ruby/vim-ruby'
    let g:rubycomplete_buffer_loading = 1
    let g:rubycomplete_classes_in_global = 1
    let g:rubycomplete_rails = 1
    let g:rubycomplete_load_gemfile = 1
    let g:rubycomplete_use_bundler = 1
NeoBundle 'vim-jp/cpp-vim'
NeoBundle 'wavded/vim-stylus'
" }}}

" colorschemes {{{
NeoBundle 'chriskempson/vim-tomorrow-theme'
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'sjl/badwolf'
    let g:badwolf_tabline = 2
NeoBundle 'tomasr/molokai'
    let g:molokai_original = 0
" }}}

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM Settings {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" colorscheme background
set background=dark
" colorschemes
colorscheme Tomorrow-Night-Bright
" vim fonts
set guifont=Droid\ Sans\ Mono\ for\ Powerline:h16
" vim window size
set lines=99 columns=999

" enable filetype plugin
filetype plugin on
filetype indent on
filetype on

" , is easier than \
let g:mapleader = ","
let mapleader = ","
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
set formatoptions=tcrqmMj

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

" word boundary to be a little bigger than the default
set iskeyword-=_,-
set iskeyword+=$,@,%,#,`,!,?

" Related to Search {{{
set ignorecase                      " Ignore case when searching
set smartcase
set hlsearch                        " Highlight search things
set incsearch                       " Make search act like search in modern browsers
"set gdefault                       " search/replace global by default
set showmatch                       " Show matching bracets
set mat=1                           " Blink How many times
" }}}

" folding settings {{{
set foldmethod=indent               " fold based on indent
set foldnestmax=99                  " deepest fold levels
set nofoldenable                    " dont fold by default
" }}}

" no sound on errors
set noerrorbells
set visualbell
set t_vb=
set tm=500

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
    " F1    Help
    " F2    Insert date and time
    inoremap <F2> <C-R>=strftime("%d/%b/%Y %I:%M %p")<CR>
    " F3    Toggle Tagbar
    " F4    Open Alternative File (c, cpp, rails)
    " F5    Open Alternative File Split (c, cpp, rails)
    " F6    Paste mode
    set pastetoggle=<F6>
    " F7    Tigger Syntastic check
    " F8
    " F9    Toggle iTerm 2
    " C-F9  Used in System
    " M-F9  Used in System
    " F10   Toggle NERDTree
    " C-F10 Toggle Vimfiler
    " F11   Toggle Gundo
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
    nnoremap <Leader>W :w<CR>
    " <leader>W
    nnoremap <leader>w :call ToggleWrap()<CR>
    function! ToggleWrap()
        nnoremap j gj
        nnoremap k gk
        nnoremap 0 g0
        nnoremap $ g$
        nnoremap ^ g^
    endfunction
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
    nmap <D-1> 1gt
    nmap <D-2> 2gt
    nmap <D-3> 3gt
    nmap <D-4> 4gt
    nmap <D-5> 5gt
    nmap <D-6> 6gt
    nmap <D-7> 7gt
    nmap <D-8> 8gt
    nmap <D-9> 9gt
    nnoremap <D-_> :tabprevious<cr>
    nnoremap <D-+> :tabnext<cr>
    nnoremap <D-t> :tabnew<CR>
    nnoremap <D-w> :tabclose<CR>

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

" Insert mode Emacs key mappings {{{
    " some Emacs key bindings in insert mode
    inoremap <C-a> <HOME>
    inoremap <C-e> <END>
    " <C-h> move word left
    inoremap <C-h> <C-O>B
    " <C-j>: Move cursor down
    inoremap <expr> <C-j> pumvisible() ? "\<C-e>\<Down>" : "\<Down>"
    " <C-k>: Move cursor up
    inoremap <expr> <C-k> pumvisible() ? "\<C-e>\<Up>" : "\<Up>"
    " <C-l>: Move word right
    inoremap <C-l> <C-O>W
    " <C-f>: Move move cursor left
    inoremap <C-f> <LEFT>
    " <C-b>: Move move cursor right
    inoremap <C-b> <RIGHT>
    " <C-a>: command mode HOME
    cnoremap <C-a> <home>
    " <C-e>: command mode END
    cnoremap <C-e> <end>
    " <C-h>: command mode cursor left
    cnoremap <C-h> <s-left>
    " <C-l>: command mode cursor right
    cnoremap <C-l> <s-right>
    " <C-@>: command mode show command history
    cnoremap <C-@> <c-f>
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
    " <M-p> Yankstack old
    " <M-P> Yankstack new
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
    " <D-o> Unite MRO
    " <D-p>
    " <D-{> Previous Tabs
    " <D-}> Next Tabs
    " <D-a> Mac Select all
    " <D-s> Mac Save
    " <D-d> Snippet autocomplete
    " <D-f>
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
au FileType cpp,c,cc,h,hpp :call CppDef()
function! CppDef()
    " FSwitch (support cpp better than a.vim) {{{
    nnoremap <F4>   :FSHere<CR>
    nnoremap <F5>   :FSSplitRight<CR>
    nnoremap <C-F5> :FSSplitLeft<CR>
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
au FileType ruby,eruby,rdoc,coffee :call RubyDef()
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

    " Vimshell shorter command
    cab pry        VimShellInteractive --split='split <bar> resize 19' pry
    cab irb        VimShellInteractive --split='split <bar> resize 19' irb
    cab coffee     VimShellInteractive --split='split <bar> resize 19' coffee
    cab eval       VimShellSendString

    " Correct typos
    iab elseif      elsif
endfunction
" }}}

" Html/Xml Mappings {{{
au FileType xhtml,html,xml,yaml :call WebDef()
function! WebDef()
    setlocal shiftwidth=2
    setlocal tabstop=2

    nnoremap <del> F<df>
    nnoremap <BS> F<df>

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
au FileType markdown,mkd,text :call MarkdownDef()
function! MarkdownDef()
    setlocal shiftwidth=2
    setlocal tabstop=2

    " Correct typos
    iab ->> →
    iab <<- ←

    " F2  Insert date and time in Jekyll
    inoremap <F2> <C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR>
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
set listchars=tab:»»,trail:⌴,extends:§,nbsp:_
" }}

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Installation check.
NeoBundleCheck
