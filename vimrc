""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MacVIM Configurations
" Author: Wang Zhuochun
" Last Edit: 26/Sep/2014 03:07 PM
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Hello Vim {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible

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

" NeoBundle start {{{
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
" }}}

" switch words {{{
NeoBundleLazy 'AndrewRadev/switch.vim', {
            \   'autoload' : { 'commands': ['Switch'] },
            \ }
    nnoremap + :Switch<CR>
    " Some customized definitions
    let g:switch_custom_definitions = [
            \   ['else', 'else if', 'elsif'],
            \   ['==', '!='],
            \   ['-=', '+='],
            \   ['if', 'unless'],
            \   ['yes', 'no'],
            \   ['first', 'last'],
            \   ['- [ ]', '- [x]'],
            \   ['get', 'post', 'put', 'patch', 'delete'],
            \   ['\.to_not', '\.to'],
            \   ['\.toBe', '\.not\.toBe'],
            \   ['public', 'protected', 'private'],
            \ ]
" }}}

" powerful split and join {{{
NeoBundleLazy 'AndrewRadev/splitjoin.vim', {
            \   'autoload' : {
            \     'mappings' : ['gS', 'gJ'],
            \     'commands' : ['SplitjoinJoin', 'SplitjoinSplit']
            \   }
            \ }
" }}}

" math calculation in vim {{{
NeoBundleLazy 'arecarn/crunch', {
            \   'autoload' : {
            \     'mappings' : ['g=', 'g=='],
            \     'commands' : ['Crunch'],
            \   }
            \ }
" }}}

" airline {{{
NeoBundle 'bling/vim-airline'
    " enable powerline symbols
    let g:airline_powerline_fonts = 1
    " clear default separator symbols
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    " modify airline symbols
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    let g:airline_symbols.whitespace = '☯'
    " shorter mode names
    let g:airline_mode_map = {
        \ '__' : '-',
        \ 'n'  : 'N',
        \ 'i'  : 'I',
        \ 'R'  : 'R',
        \ 'c'  : 'C',
        \ 'v'  : 'V',
        \ 'V'  : 'V',
        \ '' : 'V',
        \ 's'  : 'S',
        \ 'S'  : 'S',
        \ '' : 'S',
        \ }
    " control which sections get truncated and at what width. >
    let g:airline#extensions#default#section_truncate_width = {
        \   'b': 79,
        \   'x': 60,
        \   'y': 88,
        \   'z': 45,
        \ }
    " disable summary of changed hunks under source control.
    let g:airline#extensions#hunks#enabled = 0
    " enable enhanced tabline.
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#show_buffers = 0
    " display tab number instead of # of splits (default)
    let g:airline#extensions#tabline#tab_nr_type = 1
    " define how file names are displayed in tabline
    let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
    " no default separators for the tabline
    let g:airline#extensions#tabline#left_sep = ''
    let g:airline#extensions#tabline#left_alt_sep = ''
    let g:airline#extensions#tabline#right_sep = ''
    let g:airline#extensions#tabline#right_alt_sep = ''
" }}}

" buffers {{{
NeoBundle 'bling/vim-bufferline'
NeoBundle 'bufkill.vim'
NeoBundleLazy 'schickling/vim-bufonly', {
            \   'autoload' : { 'commands' : ['BufOnly', 'BOnly'] },
            \ }
" }}}

NeoBundleLazy 'chrisbra/NrrwRgn', {
            \   'autoload' : { 'commands' : ['NarrowRegion', 'NRMulti'] }
            \ }

" highlight phrases {{{
NeoBundleLazy 'dimasg/vim-mark', {
            \   'autoload' : {
            \     'commands' : ['Mark', 'MarkLoad', 'MarkClear'],
            \     'mappings' : ['<Plug>', ','],
            \   },
            \ }
    let g:mwDefaultHighlightingPalette = 'maximum'
    " Remove the default overriding of * and #, use: >
    nmap <Plug>IgnoreMarkSearchNext <Plug>MarkSearchNext
    nmap <Plug>IgnoreMarkSearchPrev <Plug>MarkSearchPrev
" }}}

" sequencial numbering with pattern {{{
NeoBundleLazy 'deris/vim-rengbang', {
            \   'autoload' : {
            \     'commands' : ['RengBang', 'RengBangUsePrev'],
            \     'mappings' : ['<Plug>(operator-rengbang'],
            \   },
            \ }
" }}}

" calendar in vim {{{
NeoBundleLazy 'itchyny/calendar.vim', {
            \   'autoload' : { 'commands' : ['Calendar'] },
            \ }
    " open calendar in new tab
    nnoremap gct :Calendar -position=tab<CR>
    " open calendar in right split
    nnoremap gcs :Calendar -split=vertical -width=40 -view=day<CR>
    " first day of a week
    let g:calendar_first_day = "sunday"
    " date format year/month/day
    let g:calendar_date_endian = "big"
    " use name instead of num for month
    let g:calendar_date_month_name = 1
    " default view for new calendar buffer
    let g:calendar_view = "days"
    " yes! google calendar
    let g:calendar_google_calendar = 1
    " nope, google task
    let g:calendar_google_task = 1
" }}}

NeoBundleLazy 'jaxbot/semantic-highlight.vim', {
            \   'autoload' : { 'commands' : ['SemanticHighlight'] },
            \ }

NeoBundle 'jiangmiao/auto-pairs'
    " Disable default BS maps because its also maps <C-H>.
    " But I still want <BS> behavior. It is mapped with AutoPairsDelete().
    let g:AutoPairsMapBS = 0

" EasyAlign {{{
NeoBundleLazy 'junegunn/vim-easy-align', {
            \   'autoload' : { 'mappings' : ['<Plug>(EasyAlign)'], },
            \ }
    " Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
    xmap <CR>      <Plug>(EasyAlign)
    " Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
    nmap <leader>a <Plug>(EasyAlign)
" }}}

NeoBundleLazy 'jeetsukumaran/vim-markology', {
            \   'autoload' : { 'mappings' : ['m'], },
            \ }

" open documentation {{{
NeoBundleLazy 'Keithbsmiley/investigate.vim', {
            \   'autoload' : { 'mappings' : ['gK'], },
            \ }
    let g:investigate_use_dash = 1
" }}}

" Multiple cursors {{{
NeoBundleLazy 'kristijanhusak/vim-multiple-cursors', {
            \   'autoload' : {'insert' : 1}
            \ }
    " Disable NeoComplete once start selecting multiple cursors
    function! Multiple_cursors_before()
        if exists(':NeoCompleteLock') == 2
            exe 'NeoCompleteLock'
        endif
    endfunction
    " Re-enable NeoComplete when the multiple selection is canceled
    function! Multiple_cursors_after()
        if exists(':NeoCompleteUnlock') == 2
            exe 'NeoCompleteUnlock'
        endif
    endfunction
" }}}

" easymotion {{{
NeoBundleLazy 'Lokaltog/vim-easymotion', {
            \   'autoload' : { 'mappings' : ['<Plug>(easymotion-'] },
            \ }
    " easymotion prefix
    map s      <Plug>(easymotion-prefix)
    " alias to normal editor commands
    map <C-f>  <Plug>(easymotion-sn)
    map <D-f>  <Plug>(easymotion-sn)
    " visual mode exact target
    vmap f     <Plug>(easymotion-f)
    vmap F     <Plug>(easymotion-F)
    vmap t     <Plug>(easymotion-t)
    vmap T     <Plug>(easymotion-T)
    " not case censitive
    let g:EasyMotion_smartcase = 1
" }}}

" Tagbar {{{
NeoBundleLazy 'majutsushi/tagbar', {
            \   'autoload' : { 'commands' : ['TagbarToggle'] },
            \ }
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
    " tagbar types
    let g:tagbar_type_coffee = {
        \ 'ctagstype' : 'coffee',
        \ 'kinds'     : [
        \     'c:classes',
        \     'm:methods',
        \     'f:functions',
        \     'v:variables',
        \     'f:fields',
        \   ]
        \ }
    let g:tagbar_type_markdown = {
        \ 'ctagstype' : 'markdown',
        \ 'kinds' : [
        \     'h:Heading_L1',
        \     'i:Heading_L2',
        \     'j:Heading_L3',
        \     'k:Heading_L4'
        \   ]
        \ }
" }}}

NeoBundle 'matchit.zip'

NeoBundleLazy 'mbbill/undotree', {
            \   'autoload' : { 'commands': ['UndotreeToggle'] },
            \ }
    nnoremap <F5> :UndotreeToggle<CR>

" osyo-manga bundles {{{
NeoBundleLazy 'osyo-manga/vim-anzu', {
            \   'autoload' : {
            \     'commands' : ['AnzuClearSearchStatus'],
            \     'mappings' : ['<Plug>(anzu-']
            \   },
            \ }
    nmap n <Plug>(anzu-n-with-echo)
    nmap N <Plug>(anzu-N-with-echo)
    nmap * <Plug>(anzu-star-with-echo)
    nmap # <Plug>(anzu-sharp-with-echo)

NeoBundleLazy 'osyo-manga/vim-over', {
            \   'autoload' : { 'commands' : ['OverCommandLine'] },
            \ }
    " modify prompt design
    let g:over_command_line_prompt = "❯ "
    " <D-r> shortcut over command line
    noremap <D-r> :OverCommandLine<cr>%s///g<Left><Left><Left>
" }}}

" Syntastic {{{
NeoBundle 'scrooloose/syntastic'
    " manual syntastic check
    nnoremap <silent> <F7> :SyntasticCheck<CR>
    " fancy symbols
    let g:syntastic_error_symbol = '✗'
    let g:syntastic_warning_symbol = '‽'
    let g:syntastic_style_error_symbol = '❄'
    let g:syntastic_style_warning_symbol = '❖'
    " error window will be automatically closed
    let g:syntastic_auto_loc_list = 1
    " populate syntastic errors in location list
    let g:syntastic_always_populate_loc_list = 1
    " height of the location lists that syntastic opens
    let g:syntastic_loc_list_height = 5
    " automatic syntax checking
    let g:syntastic_mode_map = {
        \ 'mode': 'active',
        \ 'active_filetypes': ['javascript', 'ruby', 'coffee'],
        \ 'passive_filetypes': ['html', 'css', 'scss', 'c', 'cpp'] }
" }}}

" NERDTree {{{
NeoBundleLazy 'scrooloose/nerdtree'
    " Make it colourful and pretty
    let NERDChristmasTree = 1
    " Size of the NERD tree
    let NERDTreeWinSize = 29
    " Disable 'bookmarks' and 'help'
    let NERDTreeMinimalUI = 1
    " Show hidden files
    let NERDTreeShowHidden = 1
    " Highlight the selected entry in the tree
    let NERDTreeHighlightCursorline = 1
    " Use a single click to fold/unfold directories
    let NERDTreeMouseMode = 2
    " Don't display these kinds of files in NERDTree
    let NERDTreeIgnore = [
        \ '\~$', '\.pyc$', '\.pyo$', '\.class$', '\.aps',
        \ '\.git', '\.hg', '\.svn', '\.sass-cache',
        \ '\.coverage$', '\.tmp$', '\.gitkeep$',
        \ '\.vcxproj', '\.bundle', '\.DS_Store$', '\tags$']

NeoBundle 'jistr/vim-nerdtree-tabs', {
        \   'depends' : 'scrooloose/nerdtree',
        \ }
    map <F3> <Plug>NERDTreeTabsToggle<CR>
    " Do not open NERDTree on startup
    let g:nerdtree_tabs_open_on_gui_startup = 0
" }}}

" Shougo bundles {{{
NeoBundle 'Shougo/context_filetype.vim'

NeoBundle 'Shougo/vimproc', {
        \   'build' : {
        \     'windows' : 'make -f make_mingw32.mak',
        \     'cygwin' : 'make -f make_cygwin.mak',
        \     'mac' : 'make -f make_mac.mak',
        \     'unix' : 'make -f make_unix.mak',
        \   },
        \ }
" }}}

" Unite {{{
NeoBundle 'Shougo/unite.vim'
    if neobundle#tap('unite.vim')
        function! neobundle#hooks.on_source(bundle) " {{{
            " Default profile
            call unite#custom#profile('default', 'context', {
                \   'ignorecase': 1,
                \   'smartcase': 1,
                \   'winheight': 15,
                \   'direction': 'topleft',
                \   'prompt': '» ',
                \   'marked_icon': '⚲',
                \   'cursor-line-highlight': 'Statusline',
                \ })

            " matchers
            call unite#custom#source(
                \ 'buffer,file,file_rec,file_rec/async,file_rec/git',
                \ 'matchers',
                \ ['converter_relative_word', 'matcher_fuzzy'])

            " matchers for neomru
            call unite#custom#source(
                \ 'neomru/file,neomru/directory',
                \ 'matchers',
                \ ['matcher_fuzzy', 'matcher_hide_hidden_files'])

            " ignore_patterns
            call unite#custom#source(
                \ 'buffer,file,file_rec,file_rec/async,grep',
                \ 'ignore_pattern',
                \ join([
                \   '\.git/', '\.gitkeep', '\.keep', '\.hg/', '\.o', '\.DS_Store',
                \   '_build', '_site', 'dist',
                \   '\.tmp/', 'tmp', 'log', '*.tar.gz', '*.zip',
                \   'node_modules', 'bower_components', '\.sass-cache/',
                \ ], '\|'))

            " sorter_default
            call unite#filters#sorter_default#use(['sorter_rank'])
        endfunction " }}}
        call neobundle#untap()
    endif

    " File switching using git
    nnoremap <silent> <D-i> :<C-u>Unite
        \ -buffer-name=files -start-insert
        \ file_rec/git:--cached:--others:--exclude-standard<CR>
    " File switching using file_rec
    nnoremap <silent> <D-u> :<C-u>Unite -buffer-name=files -start-insert file_rec/async:!<CR>
    nnoremap <silent> <D-p> :<C-u>Unite -buffer-name=files -start-insert file_rec/async:!<CR>
    " Buffer switching
    nnoremap <silent> <C-b> :<C-u>Unite -buffer-name=buffers -quick-match buffer<CR>
    " Tab switching
    nnoremap <silent> <C-t> :<C-u>Unite -buffer-name=tabs -quick-match tab<CR>
    " Reuses the last unite buffer used
    nnoremap <silent> gor :<C-u>UniteResume<CR>

    " Enabled to track yank history
    let g:unite_source_history_yank_enable = 1
    let g:unite_source_history_yank_save_clipboard = 1
    " Yank history like YankRing
    nnoremap <silent> <D-y> :<C-u>Unite -buffer-name=yank
        \ history/yank -quick-match -no-split<CR>

    " Use Ag
    if executable('ag')
        " Use ag in unite grep source.
        let g:unite_source_grep_command = 'ag'
        let g:unite_source_grep_default_opts =
            \ '--line-numbers --nocolor --nogroup --hidden ' .
            \ '--ignore ''.hg'' --ignore ''.svn'' --ignore ''.git'''
        let g:unite_source_grep_recursive_opt = ''
    endif
    " Mapping on Ag
    nnoremap <silent> <D-/> :<C-u>Unite -buffer-name=grep -no-quit grep:.<CR>
    nnoremap <silent> <D-F> :<C-u>Unite -buffer-name=grep -no-quit grep:.<CR>

    " Location alias
    let g:unite_source_alias_aliases = {
            \   'bicrement' : {
            \     'source': 'file_rec/async',
            \     'args': '~/Documents/Programming/Web/zhuochun.github.io/',
            \   },
            \   'mifengtd' : {
            \     'source': 'file_rec/async',
            \     'args': '~/Documents/Programming/Web/mifengtd.cn/',
            \   },
            \ }

    " Key Mappings in Unite "{{{
    autocmd! FileType unite call s:unite_my_settings()
    function! s:unite_my_settings()
        " normal mode settings
        nmap <buffer> <ESC>     <Plug>(unite_exit)
        nmap <buffer> <leader>d <Plug>(unite_exit)
        nmap <buffer> <TAB>     <Plug>(unite_select_next_line)

        " insert mode settings
        imap <buffer> <CR>      <Plug>(unite_do_default_action)
        imap <buffer> <TAB>     <Plug>(unite_select_next_line)
        imap <buffer> <S-TAB>   <Plug>(unite_select_previous_line)
        imap <buffer> <D-d>     <Plug>(unite_complete)

        " path settings
        imap <buffer> <C-y>     <Plug>(unite_narrowing_path)
        nmap <buffer> <C-y>     <Plug>(unite_narrowing_path)
        nmap <buffer> <C-j>     <Plug>(unite_toggle_auto_preview)

        " change directory
        nnoremap <silent><buffer><expr> cd   unite#do_action('lcd')
        nnoremap <silent><buffer><expr> !    unite#do_action('start')

        " replace/rename
        let unite = unite#get_current_unite()
        if unite.profile_name ==# '^search'
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
" }}}

" Unite plugins {{{
NeoBundle 'Shougo/neomru.vim', {
        \   'depends': ['Shougo/unite.vim'],
        \ }
    " <D-o> recent file
    nnoremap <silent> <D-o> :<C-u>Unite -buffer-name=MRU
        \ neomru/file -start-insert<CR>
    " <D-O> recent directory
    nnoremap <silent> <D-O> :<C-u>Unite -buffer-name=MRU
        \ neomru/directory -start-insert -default-action=lcd<CR>
NeoBundleLazy 'Shougo/unite-outline', {
            \   'depends': ['Shougo/unite.vim'],
            \   'autoload': {'unite_sources': 'outline'}
            \ }
    nnoremap <silent> goo :<C-u>Unite -buffer-name=outline outline<CR>
NeoBundleLazy 'Shougo/junkfile.vim', {
            \   'depends': ['Shougo/unite.vim'],
            \   'autoload': {
            \     'commands' : 'JunkfileOpen',
            \     'unite_sources' : ['junkfile', 'junkfile/new'],
            \   }
            \ }
    let g:junkfile#directory = '/Users/zhuochun/Dropbox/Mac/Note'
    " create or open a junk file
    nnoremap <silent> goi :<C-u>Unite -buffer-name=junkfile
            \ junkfile/new junkfile -start-insert<CR>
NeoBundleLazy 'kopischke/unite-spell-suggest', {
            \   'depends': ['Shougo/unite.vim'],
            \   'autoload': {
            \     'unite_sources': 'spell_suggest',
            \     'filetypes' : ['markdown', 'text'],
            \   }
            \ }
    nnoremap <silent> gos :<C-u>Unite -buffer-name=spell spell_suggest<CR>
NeoBundleLazy 'ujihisa/unite-colorscheme', {
            \   'depends': ['Shougo/unite.vim'],
            \   'autoload': {'unite_sources': 'colorscheme'}
            \ }
    nnoremap <silent> goc :<C-u>Unite -buffer-name=colorscheme -auto-preview colorscheme<CR>
NeoBundleLazy 'osyo-manga/unite-quickfix', {
            \   'depends': ['Shougo/unite.vim'],
            \   'autoload': {'unite_sources': ['quickfix', 'location_list']}
            \ }
    nnoremap <silent> goq :<C-u>Unite -buffer-name=quickfix quickfix<CR>
NeoBundleLazy 'osyo-manga/unite-filetype', {
            \   'depends': ['Shougo/unite.vim'],
            \   'autoload': {'unite_sources': ['filetype', 'filetype/new']}
            \ }
    nnoremap <silent> gof :<C-u>Unite -buffer-name=filetypes -start-insert filetype<CR>
NeoBundleLazy 'tsukkee/unite-tag', {
            \   'depends': ['Shougo/unite.vim'],
            \   'autoload': {'unite_sources': 'tag'}
            \ }
    nnoremap <silent> got :<C-u>Unite -buffer-name=tags -start-insert tag<CR>
" }}}

" VimShell {{{
NeoBundleLazy 'Shougo/vimshell.vim', {
            \   'depends' : 'Shougo/vimproc',
            \   'autoload' : {
            \     'commands' : [{'name' : 'VimShell',
            \                    'complete' : 'customlist,vimshell#complete'},
            \                   'VimShellExecute', 'VimShellInteractive',
            \                   'VimShellTerminal', 'VimShellPop'],
            \     'mappings' : ['<Plug>(vimshell_'],
            \   },
            \ }
    " send to interpreter
    nmap <leader>e :Eval<CR>
    vmap <leader>e :Eval<CR>

    " default prompt string
    let g:vimshell_prompt = $USER." $ "
    " display current dir
    let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'

    " VimShellInteractive Commands {{{
    command! -buffer Eval :execute "VimShellSendString"
    command! -buffer Pry  :execute
        \ "VimShellInteractive --split='split <bar> resize 19' pry"
    command! -buffer Irb  :execute
        \ "VimShellInteractive --split='split <bar> resize 19' irb"
    command! -buffer Node :execute
        \ "VimShellInteractive --split='split <bar> resize 19' node"
    command! -buffer Coffee :execute
        \ "VimShellInteractive --split='split <bar> resize 19' coffee"
    command! -buffer Python :execute
        \ "VimShellInteractive --split='split <bar> resize 19' python"
    " }}}
" }}}

" NeoComplete {{{
NeoBundle 'Shougo/neocomplete.vim'
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#enable_camel_case = 1
    let g:neocomplete#enable_auto_delimiter = 1
    let g:neocomplete#enable_fuzzy_completion = 1

    let g:neocomplete#max_list = 42
    let g:neocomplete#auto_completion_start_length = 1
    let g:neocomplete#manual_completion_start_length = 1
    let g:neocomplete#sources#buffer#disabled_pattern = '\.log\|\.log\.\|\.jax'
    let g:neocomplete#lock_buffer_name_pattern = '\.log\|\.log\.\|.*quickrun.*\|.jax'

    " Define dictionary
    let g:neocomplete#sources#dictionary#dictionaries = {
        \   'default'    : '',
        \   'vimshell'   : $CACHE.'/vimshell/command-history',
        \   'ruby'       : $HOME.'/.vim/bundle/vim-dicts/dict/ruby.dict',
        \   'coffee'     : $HOME.'/.vim/bundle/vim-dicts/dict/node.dict',
        \ }

    " Define keyword
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns._ = '\h\w*'

    " Enable heavy omni completion
    let g:neocomplete#force_overwrite_completefunc = 1
    if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
    endif
    if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
    endif
    if !exists('g:neocomplete#sources#omni#functions')
        let g:neocomplete#sources#omni#functions = {}
    endif

    " Plugin key-mappings
    inoremap <expr><C-g> pumvisible() ? neocomplete#undo_completion() : "<ESC>"
    inoremap <expr><C-l> neocomplete#complete_common_string()

    " <CR> close popup and save indent
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
        function! s:my_cr_function()
            return pumvisible() ? neocomplete#close_popup() : "\<CR>"
        endfunction

    " <TAB> completion
    inoremap <silent><expr><TAB> pumvisible() ? "\<C-n>" :
                               \ <SID>check_back_space() ? "\<TAB>" :
                               \ neocomplete#start_manual_complete()
        function! s:check_back_space()
            let col = col('.') - 1
            return !col || getline('.')[col - 1] =~ '\s'
        endfunction
    " <S-TAB> completion backward
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-H>"
    " <BS> close popup and delete backword char
    inoremap <expr><BS> pumvisible() ?
                \ neocomplete#smart_close_popup()."\<C-H>" :
                \ AutoPairsDelete()
    " <Space> close popup
    inoremap <expr><Space> pumvisible() ?
                \ neocomplete#close_popup()."\<Space>" : "\<Space>"
" }}}

" NeoComplete Plugins {{{
" A neocomplete plugin to complete words in English
NeoBundleLazy 'ujihisa/neco-look', {
            \   'depends': ['Shougo/neocomplete.vim'],
            \   'autoload' : {'insert' : 1}
            \ }
" A neocomplete plugin to complete ruby keyword args
NeoBundleLazy 'rhysd/neco-ruby-keyword-args', {
            \   'depends': ['Shougo/neocomplete.vim'],
            \   'autoload' : {'filetypes' : 'ruby'}
            \ }
" }}}

NeoBundleLazy 'rhysd/accelerated-jk', {
            \   'autoload' : { 'mappings' : ['<Plug>(accelerated_'] }
            \ }
    nmap j <Plug>(accelerated_jk_gj)
    nmap k <Plug>(accelerated_jk_gk)

" NeoSnippet {{{
NeoBundle 'Shougo/neosnippet.vim'
    " Default expand with word boundary
    let g:neosnippet#expand_word_boundary = 1
    " Disables standart snippets, use vim-snippets bundle instead
    let g:neosnippet#disable_runtime_snippets = { '_' : 1 }
    " Enable snipMate compatibility feature.
    let g:neosnippet#enable_snipmate_compatibility = 1
    " Tell Neosnippet about the other snippets
    let g:neosnippet#snippets_directory = '~/.vim/bundle/vim-snippets/snippets'
    " Remove snippet markers after save
    autocmd! BufWrite * NeoSnippetClearMarkers

    " Plugin key-mappings
    imap <D-d> <Plug>(neosnippet_jump_or_expand)
    smap <D-d> <Plug>(neosnippet_jump_or_expand)
    " Alternative
    imap <M-d> <Plug>(neosnippet_expand_or_jump)
    smap <M-d> <Plug>(neosnippet_expand_or_jump)
    " Visual
    xmap <D-d> <Plug>(neosnippet_expand_target)

    " Snippet variables
    let g:snips_author = 'Wang Zhuochun'
    let g:snips_email  = 'stone1551@gmail.com'
    let g:snips_github = 'https://github.com/zhuochun'
" }}}

" snippets and dicts {{{
NeoBundle 'zhuochun/vim-snippets'
NeoBundle 'zhuochun/vim-dicts'
" }}}

" vim-exchange {{{
" cx{motion}, cxx (current line), cxc (clear), X (visual exchange)
NeoBundleLazy 'tommcdo/vim-exchange', {
            \   'autoload' : {
            \     'mappings' : ['cx', 'cxx', 'X', '<Plug>(Exchange'],
            \   }
            \ }
" }}}

" tpope bundles {{{
NeoBundleLazy 'tpope/vim-abolish', {
            \   'autoload' : {'mappings' : ['crm', 'crc', 'crs', 'cru']}
            \ }
    " MixedCase (crm), camelCase (crc)
    " snake_case (crs), UPPER_CASE (cru)

NeoBundleLazy 'tpope/vim-commentary', {
            \   'autoload' : {'mappings' : ['gc', 'gcc', 'gcu']}
            \ }
    " Comments (gcc), Uncomment (gcu), Toggle visual block (gc)

NeoBundleLazy 'tpope/vim-characterize', {
            \   'autoload' : {'mappings' : ['ga']}
            \ }

NeoBundle 'tpope/vim-dispatch'

NeoBundleLazy 'tpope/vim-eunuch', {
            \   'autoload' : {
            \     'commands' : [
            \       'Unlink', 'Remove', 'Move', 'Rename', 'Chmod',
            \       'Mkdir', 'Find', 'Wall', 'W', 'SudoWrite', 'SudoEdit'
            \     ]
            \   },
            \ }

NeoBundle "tpope/vim-projectionist"

NeoBundleLazy 'tpope/vim-repeat', {
            \   'autoload' : {'mappings' : ['.']}
            \ }

NeoBundle 'tpope/vim-surround'
    xmap ( S)
    xmap { S{
    xmap [ S]
    xmap " S"
    xmap ' S'
    xmap ` S`
    xmap T St

NeoBundleLazy 'tpope/vim-unimpaired', {
            \   'autoload' : {'mappings' : ['[', ']']}
            \ }
    " bprevious: [b, bnext: ]b, bfirst: [B
    " lprevious: [l, lnext: ]l, lfirst: [L
    " cprevious: [q, cnext: ]q, cfirst: [Q
    " tprevious: [t, tnext: ]t,

NeoBundleLazy 'tpope/vim-vinegar', {
            \   'autoload' : {'mappings' : ['-']}
            \ }
" }}}

" thinca bundles {{{
" * and # to search selection
NeoBundleLazy 'thinca/vim-visualstar', {
            \   'autoload' : {'mappings' : ['<Plug>(visualstar-']}
            \ }
    " search without moving to next match
    map *  <Plug>(visualstar-*)N
    map #  <Plug>(visualstar-#)N

" Perform text replacement in quickfix
NeoBundleLazy 'thinca/vim-qfreplace', {
            \   'autoload' : {'commands' : ['Qfreplace']}
            \ }
" }}}

" vim-expand-region {{{
NeoBundleLazy 'terryma/vim-expand-region', {
            \   'autoload' : {'mappings' : ['<Plug>(expand_region']}
            \ }
    if neobundle#tap('vim-expand-region')
        vmap v    <Plug>(expand_region_expand)
        vmap <BS> <Plug>(expand_region_shrink)

        function! neobundle#hooks.on_source(bundle) " {{{
            " Extend the global default
            " [ia]v variable segment
            " [i]y  sytax segment
            " [ia]i indent segment
            call expand_region#custom_text_objects({
                \   'iv' :0, 'av' :0,
                \   'a]' :0,
                \   'ab' :1, 'aB' :1,
                \ })
            " Add to global default + for ruby
            call expand_region#custom_text_objects('ruby', {
                \   'ir' :0, 'ar' :0,
                \ })
            " Add to global default + for html
            call expand_region#custom_text_objects('html', {
                \   'it' :1, 'at' :1,
                \ })
        endfunction " }}}
        call neobundle#untap()
    endif
" }}}

" OpenBrowser {{{
NeoBundleLazy 'tyru/open-browser.vim', {
            \   'autoload' : {
            \     'commands' : ['OpenBrowser', 'OpenBrowserSearch',
            \                   'OpenBrowserSmartSearch'],
            \     'mappings' : '<Plug>(openbrowser-',
            \   }
            \ }
    " disable netrw's gx mapping.
	let g:netrw_nogx = 1
    " gx mappings
    nmap gx <Plug>(openbrowser-smart-search)
    vmap gx <Plug>(openbrowser-smart-search)
" }}}

NeoBundleLazy 'vim-scripts/DrawIt', {
            \   'autoload' : {'commands' : ['DIstart', 'DIstop', 'DrawIt']}
            \ }

NeoBundle 'whatyouhide/vim-lengthmatters'

NeoBundle 'Yggdroot/indentLine'
    let g:indentLine_char = '┊'
    let g:indentLine_fileTypeExclude = ['markdown', 'text']

" window operations {{{
NeoBundleLazy 't9md/vim-choosewin', {
            \   'autoload' : {
            \     'commands' : 'ChooseWin',
            \     'mappings' : '<Plug>(choosewin',
            \   }
            \ }
    nmap <leader>ww <Plug>(choosewin)
    nmap <leader>ws <Plug>(choosewin-swap)
    " dont' blink at land
    let g:choosewin_blink_on_land = 0

NeoBundleLazy 'vim-scripts/ZoomWin', {
            \   'autoload' : {'commands' : ['ZoomWin']}
            \ }
    nmap <F12> :ZoomWin<CR>
" }}}

" Text Objects {{{
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-line'               " al | il
NeoBundle 'kana/vim-textobj-syntax'             " ay | iy
NeoBundle 'kana/vim-textobj-indent'             " ai | ii
NeoBundle 'kana/vim-textobj-lastpat'            " a/ | i/
NeoBundle 'nelstrom/vim-textobj-rubyblock'      " ar | ir
NeoBundle 'osyo-manga/vim-textobj-multiblock'   " ab | ib
NeoBundle 'idbrii/textobj-word-column.vim'      " ac | ic
NeoBundle 'Julian/vim-textobj-variable-segment' " av | iv
NeoBundle 'deris/vim-textobj-enclosedsyntax'    " aq | iq
NeoBundle 'whatyouhide/vim-textobj-xmlattr'     " ax | ix
" }}}

" Writings {{{
NeoBundleLazy 'junegunn/goyo.vim', {
            \   'autoload' : { 'commands' : ['Goyo'] },
            \ }
    nnoremap <silent> <F11> :Goyo<CR>

NeoBundleLazy 'junegunn/limelight.vim', {
            \   'autoload' : { 'commands' : ['Limelight', 'Limelight!'] },
            \ }
    autocmd! User GoyoEnter Limelight
    autocmd! User GoyoLeave Limelight!
" }}}

" HTML/XML {{{
NeoBundle 'othree/html5.vim'
NeoBundle 'gregsexton/MatchTag'
NeoBundle 'mattn/emmet-vim'
    " enable emmet functions in insert mode only
    let g:user_emmet_mode = 'i'
    " complete tags using omnifunc
    let g:use_emmet_complete_tag = 1
    " <D-y> to expand input in insert mode
    let g:user_emmet_expandabbr_key = '<D-y>'
    " <M-y> to goto next point
    let g:user_emmet_next_key = '<M-y>'
    " <M-Y> to goto prev point
    let g:user_emmet_prev_key = '<M-Y>'
" }}}

" Template Engines {{{
NeoBundle 'digitaltoad/vim-jade'
NeoBundle 'nono/vim-handlebars'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'tpope/vim-haml'
" }}}

" CSS {{{
NeoBundle 'ap/vim-css-color'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'cakebaker/scss-syntax.vim'
NeoBundle 'groenewege/vim-less'
NeoBundle 'wavded/vim-stylus'
" }}}

" JavaScript {{{
NeoBundle 'elzr/vim-json'
NeoBundle 'kchmck/vim-coffee-script'
    let coffee_make_options = '--bare'
NeoBundle 'moll/vim-node'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'othree/javascript-libraries-syntax.vim'
    let g:used_javascript_libs =
        \ 'jquery,underscore,backbone,angularjs,angularui,jasmine'
NeoBundleLazy 'marijnh/tern_for_vim', {
        \   'build': {
        \     'windows': 'npm install',
        \     'cygwin': 'npm install',
        \     'mac': 'npm install',
        \     'unix': 'npm install',
        \   },
        \   'autoload' : {
        \     'filetypes' : ['javascript'],
        \   },
        \ }
    let g:tern_show_argument_hints = 'on_hold'
    let g:tern_show_signature_in_pum = 1
" }}}

" Ruby/Rails {{{
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-bundler'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-rake'
NeoBundle 'tpope/vim-rbenv'
NeoBundleLazy 'Keithbsmiley/rspec.vim', {'autoload' : {'filetypes' : 'ruby'}}
NeoBundleLazy 'skalnik/vim-vroom', {'autoload' : {'filetypes' : 'ruby'}}
    let g:vroom_use_dispatch = 1
NeoBundleLazy 'duwanis/tomdoc.vim', {'autoload' : {'filetypes' : 'ruby'}}
NeoBundleLazy 'ecomba/vim-ruby-refactoring', {'autoload' : {'filetypes' : 'ruby'}}
" }}}

" Clojure {{{
NeoBundle 'amdt/vim-niji'
NeoBundleLazy 'guns/vim-clojure-static', {'autoload' : {'filetypes' : 'clojure'}}
NeoBundleLazy 'guns/vim-clojure-highlight', {'autoload' : {'filetypes' : 'clojure'}}
NeoBundleLazy 'tpope/vim-classpath', {'autoload' : {'filetypes' : 'clojure'}}
NeoBundleLazy 'tpope/vim-fireplace', {'autoload' : {'filetypes' : 'clojure'}}
NeoBundleLazy 'tpope/vim-leiningen', {'autoload' : {'filetypes' : 'clojure'}}
NeoBundleLazy 'vim-scripts/paredit.vim', {'autoload' : {'filetypes' : 'clojure'}}
" }}}

" C/Cpp {{{
NeoBundle 'vim-jp/cpp-vim'
NeoBundle 'octol/vim-cpp-enhanced-highlight'
" }}}

" Markdown {{{
NeoBundle 'gabrielelana/vim-markdown'
    let g:markdown_enable_mappings = 0
NeoBundleLazy 'farseer90718/vim-regionsyntax', {
            \   'autoload' : { 'filetypes' : ['markdown', 'text'] }
            \ }
NeoBundleLazy 'kannokanno/previm', {
            \   'depends': ['tyru/open-browser.vim'],
            \   'autoload': {'commands': 'PrevimOpen'}
            \ }
" }}}

" Git {{{
NeoBundle 'mhinz/vim-signify'
    let g:signify_vcs_list = ['git', 'hg']
NeoBundle 'tpope/vim-fugitive'
NeoBundleLazy 'gregsexton/gitv', {
            \   'depends': ['tpope/vim-fugitive'],
            \   'autoload': {'commands': 'Gitv'}
            \ }
" }}}

" Others {{{
NeoBundleLazy 'chase/vim-ansible-yaml'
" }}}

" Colorschemes {{{
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'morhetz/gruvbox'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'sjl/badwolf'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'whatyouhide/vim-gotham'
" }}}

" NeoBundle end {{{
call neobundle#end()
" Installation check
NeoBundleCheck
" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM Visual {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" basic styles
set background=dark
colorscheme hybrid
set colorcolumn=79
set guifont=Inconsolata-dz\ for\ Powerline:h16

" conceal special chars
if has('conceal')
    set conceallevel=2 concealcursor=i
endif

" no preview window
set completeopt-=preview
"}}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM Settings {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" necessary {{{
" , is easier than \
let g:mapleader = ","
let mapleader = ","
" ; is easier than :
noremap ; :
noremap : ;

" enable filetype plugin
filetype plugin on
filetype indent on
filetype on

" syntax highlighting on
syntax on

" formatoptions
" o - insert command leader in o or O
" t - autowrap text
" c - autowrap comments
" r - insert comment leader
" mM - useful for Chinese characters, q - gq
" j - remove comment leader when joining lines
autocmd! FileType * setlocal formatoptions-=o
" }}}

" encoding {{{
set fileencoding=utf-8
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,ucs-bom,chinese,gbk
" }}}

" basic settings {{{
set shortmess=atI            " no welcome screen in gVim
set laststatus=2             " status line
set mouse=a                  " enable mouse
set gcr=a:blinkon0           " disable the blinking cursor
set go=                      " disable GUI components
set ttimeout
set timeoutlen=42            " quick timeouts for command combinations
set history=999              " keep 999 lines of command line history
set ruler                    " show the cursor position all the time
set number                   " display current line number
set relativenumber           " show line number relatively
set lazyredraw               " stops redrawing during complex operations
set hidden                   " change buffer even if it is not saved
set lbr                      " dont break line within a word
set showcmd                  " display incomplete commands
set showmode                 " show current mode
set nowrap                   " no wrap in default
set linebreak                " wrap at word boundary
set magic                    " set magic on, for regular expressions
set modeline                 " make modeline works
set winaltkeys=no            " set ALT not map to toolbar
set autoread                 " autoread when a file is changed from the outside
set shortmess+=filmnrxoOtT   " abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash
set virtualedit=block,onemore
" }}}

" basic settings 2 {{{
set wildmenu                 " show autocomplete menus
set wildignore+=*.dll,*.o,*.obj,*.bak,*.exe,*.zip
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.bmp
set wildignore+=*~,*.sw?,*.DS_Store
set wildignore+=*$py.class,*.class,*.gem,*.pyc,*.aps,*.vcxproj.*
set wildignore+=.git,.gitkeep,.hg,.svn,.tmp,.coverage,.sass-cache
set wildignore+=log/**,tmp/**,node_modules/**,build/**,_site/**,dist/**
set wildignore+=vendor/bundle/**,vendor/cache/**,vendor/gems/**

set complete-=i
set backspace=indent,eol,start
set whichwrap+=[,],b,s       " left/right move to prev/next line in insert

set scrolljump=6             " lines to scroll when cursor leaves screen
set scrolloff=6              " minimum lines to keep above and below cursor
set sidescroll=1             " columns to scroll horizontally
set sidescrolloff=6          " minimal number of screen columns to keep
set synmaxcol=800            " no highlight on lines longer than 800 characters
" }}}

" indent behaviors {{{
set shiftwidth=4
set shiftround               " round indent to multiple of 'shiftwidth'
set tabstop=4
set expandtab
set smarttab
set autoindent
set smartindent
set cindent
" }}}

" word boundary {{{
set iskeyword-=_,-,:
set iskeyword+=$,@,%,#,`,!,?
" }}}

" searching {{{
set ignorecase               " Ignore case when searching
set smartcase
set hlsearch                 " Highlight search things
set incsearch                " Highlight next match on searching
set showmatch                " Show matching bracets
set cpoptions-=m             " No match jumping
set matchtime=1              " Time to show the match parenthesis (in 1/10 s)
set matchpairs+=<:>          " < and > are pairs as well
" }}}

" folding {{{
set nofoldenable             " fold disabled by default
set foldmethod=indent        " fold based on indent
set foldnestmax=99           " deepest fold levels

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

" list chars {{{
set list
set listchars=tab:»»,trail:⌴,conceal:…,extends:❯,precedes:❮,nbsp:_
let &showbreak='↪ '
" }}}

" no sound on errors {{{
set noerrorbells
set visualbell t_vb=
set tm=500
" }}}

" tags, backups and undos {{{
" set tag locations
set tags=./tags;

" Turn backup on
set backup
set backupdir=/tmp/,~/tmp,~/Temp

" Swap files
set noswapfile
set directory=/tmp/,~/tmp,~/Temp

" Persistent undo
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

" tabs and windows {{{
    " Switch between tab 1 ~ 9
    for i in range(1, 9)
        exec "nnoremap <D-".i."> ".i."gt"
    endfor

    nnoremap <silent> <M-l> :<C-u>tabnext<CR>
    nnoremap <silent> <M-h> :<C-u>tabprevious<CR>
    nnoremap <silent> <D-(> :<C-u>tabprevious<CR>
    nnoremap <silent> <D-)> :<C-u>tabnext<CR>
    nnoremap <silent> <D-t> :<C-u>tab split<CR>
    nnoremap <silent> <D-T> :<C-u>tabnew<CR>
    nnoremap <silent> <D-w> :<C-u>tabclose<CR>

    " splitting
    set splitright
    set splitbelow

    " Smart way to move btw. windows
    nmap <C-j> <C-W>j
    nmap <C-k> <C-W>k
    nmap <C-h> <C-W>h
    nmap <C-l> <C-W>l

    " Use arrows to change the splited windows
    nmap <D-right> <C-W>L
    nmap <D-left>  <C-W>H
    nmap <D-up>    <C-W>K
    nmap <D-down>  <C-W>J
" }}}

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key Mappings {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Function keys {{{
    " F1
    " F2    Insert date and time
    inoremap <F2> <C-R>=strftime("%d/%b/%Y %I:%M %p")<CR>
    " F3    Toggle NERDTree
    " F4
    " F5    Toggle Undotree
    " F6    Toggle Paste mode
    set pastetoggle=<F6>
    " F7    Tigger Syntastic manual check
    " F8
    " F9    Toggle iTerm 2
    " F10   Toggle Tagbar
    " F11   Toggle Goyo
    " F12   Toggle ZoomWin
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

" Characters (Normal Mode) {{{
    " <~>       Switch character case
    " <0>       Go to first non-blank character
    nnoremap 0 ^
    " <!>
    " <@>       Register
    " <#>       Search word under cursor backwards
    " <$>       To the end of the line
    " <%>       Move between open/close tags
    " *<%>      Move to percentage of file
    " <^>       To the first non-blank character of the line.
    " <&>       Synonym for `:s` (repeat last substitute)
    " <*>       Search word under cursor forwards
    " <(>       Sentences backward
    " <)>       Sentences forward
    " <_>       Quick Horizonal split
    nnoremap _ :sp<cr>
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
    " <p>       Paste yank after, keep cursor position
    nnoremap p p`[
    " <p>       Paste yank before, keep cursor position
    nnoremap P P`[
    " <[>       tpope/unimpaired
    " <{>       Paragraphs backward
    " <]>       tpope/unimpaired
    " <}>       Paragraphs forward
    " <\>       Toggle folding
    " <|>       Quick vertical split
    nnoremap <bar> :vsp<cr>
    " <a>       Append insert
    " <A>       Append at end of line
    " <s>       EasyMotion
    " <S>       Substitue, don't update default register
    nnoremap S "_s
    " <d>       Delete
    " <D>       Delete to end of line
    " <f>       find to right (exclusive)
    " <F>       find to right (inclusive)
    " <g>       Go and Unite mappings
    nnoremap gh H
    nnoremap gm M
    nnoremap gl L
    " <G>       Go to end of file
    " *<G>      Go to specific line number
    " <h>       Left
    " <H>       Go to beginning of line. Goes to previous line if repeated
    nnoremap <expr> H getpos('.')[2] == 1 ? 'k' : '0'
    " <j>       Down
    " <J>       Join Sentences
    " <k>       Up
    " <K>
    " <l>       Right
    " <L>       Go to end of line. Goes to next line if repeated
    nnoremap <expr> L <SID>end_of_line()
        function! s:end_of_line()
            let l = len(getline('.'))
            if (l == 0 || l == getpos('.')[2])
                return 'jg_'
            else
                return 'g_'
        endfunction
    " <;>       Repeat last find f,t,F,T
    " <:>       Input Command
    " <'>*      Move to {a-zA-Z} mark
    " <z>*      Folding
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
    " </>       Search
    nnoremap / /\v
    vnoremap / /\v
    " <?>       Search backwards
    nnoremap ? ?\v
    vnoremap ? ?\v
    " <space>   Enter <space>
    nnoremap <space> i<space><ESC>
    " <CR>      Enter <CR> at current position
    nnoremap <CR> i<CR><ESC>
" }}}

" <leader>* {{{
    " <leader>1
    " <leader>2
    " <leader>3
    " <leader>4
    " <leader>5
    " <leader>6
    " <leader>7
    " <leader>8
    " <leader>9
    " <leader>0 Edit vimrc
    " <leader>) Edit gvimrc
    " <leader>-
    " <leader>=
    " <leader>q Quick Quit without save
    nnoremap <leader>q :q!<CR>
    " <leader>w vim-choosewin
    nnoremap <leader>W :call ToggleWrap()<CR>
    function! ToggleWrap()
        nnoremap <buffer> j gj
        nnoremap <buffer> k gk
        nnoremap <buffer> 0 g0
        nnoremap <buffer> $ g$
        nnoremap <buffer> ^ g^
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
    " <leader>s Spell checkings
    nnoremap <leader>ss :setlocal spell!<CR>
    nnoremap <leader>sn ]s
    nnoremap <leader>sp [s
    nnoremap <leader>sa zg
    nnoremap <leader>s? z=
    " <leader>S Clear trailing whitespace
    nnoremap <leader>S :%s/\s\+$//ge<CR>:nohl<CR>
    " <leader>d Close buffer with leave window intact
    nnoremap <leader>d :BD<CR>
    " <leader>D Close buffer
    nnoremap <leader>D :bd<CR>
    " <leader>f Format file
    nnoremap <leader>f gg=G''
    " <leader>F Format file
    nnoremap <leader>F gg=G''
    " <leader>g
    " <leader>h
    " <leader>j
    " <leader>k
    " <leader>l
    " <leader>L Reduce a sequence of blank lines into a single line
    nnoremap <leader>L GoZ<Esc>:g/^[ <Tab>]*$/.,/[^ <Tab>]/-j<CR>Gdd
    " <leader>z
    " <leader>x
    " <leader>c
    " <leader>v Select the just pasted text
    nnoremap <leader>v V`]
    " <leader>b
    " <leader>n
    " <leader>m
    " <leader>M Remove ^M
    nnoremap <leader>M mmHmt:%s/<C-V><CR>//ge<CR>'tzt'm
    " <leader>, Run Eval
    " <leader><space> Close search highlight
    nnoremap <leader><space> :nohl<CR>:AnzuClearSearchStatus<CR>
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
    " <C-q> Multiple select
    " <C-w>
    " <C-e>
    " <C-r>
    " <C-t>
    " <C-y> Emmet Expand
    " <C-u> Page up
    " <C-u> Switch word case
    inoremap <C-u> <esc>mzg~iw`za
    " <C-i>
    " <C-o>
    " <C-p>
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
    " <C-CR> Like in Visual Studio
    inoremap <C-CR> <ESC>o
    " <S-CR> Like in Visual Studio
    inoremap <S-CR> <ESC>O
    " <C-z>
    " <C-x>
    " <C-c>
    " <C-v>
    " <C-b> Switch Buffers
    " <C-n>
    " <C-m>
    " <C-,>
    " <C-.>
" }}}

" <C-*> (Insert Mode) {{{
    inoremap <expr> <C-j> pumvisible() ? "\<C-e>\<Down>" : "\<Down>"
    inoremap <expr> <C-k> pumvisible() ? "\<C-e>\<Up>" : "\<Up>"
    inoremap <C-H>  <S-Left>
    inoremap <C-L>  <S-Right>
    inoremap <C-B>  <Left>
    inoremap <C-F>  <Right>
    inoremap <C-A>  <C-O>^
    inoremap <C-E>  <End>
    inoremap <C-D>  <C-R>=AutoPairsDelete()<CR>
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
    " <M-/>
" }}}

" <D-*> {{{
    " <D--> Mac Smaller font
    " <D-=> Mac Larger font
    " <D-q> Mac Quit
    " <D-w> Mac Close
    " <D-e>
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
" Additional Settings {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Source vimrc after saving it {{{
autocmd! BufWritePost .vimrc source $MYVIMRC

" Quick edit _vimrc template
noremap <leader>0 :tabe $MYVIMRC<CR>
noremap <leader>) :tabe $MYGVIMRC<CR>
" }}}

" Returns to the last edit line when you reopen a file {{{
autocmd! BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \     execute 'normal! g`"zvzz' |
    \ endif
" }}}

" Update diff after save {{{
autocmd! InsertLeave,BufWritePost * if &l:diff | diffupdate | endif
" }}}

" Snippets {{{
autocmd! FileType neosnippet,snippet set noexpandtab
" }}}

" C/CPP Mappings {{{
autocmd! FileType cpp,c,cc,h,hpp :call s:CppDef()
function! s:CppDef()
    " Surround * to /*
    let b:surround_42 = "/* \r */"
    xmap 8 S*

    " Correct typos
    iab uis        usi
    iab cuot       cout
    iab Bool       bool
    iab boll       bool
    iab Static     static
    iab Virtual    virtual
    iab True       true
    iab False      false
    iab String     string
    iab prinft     printf
    iab pritnt     printf
    iab pirntf     printf
    iab end;       endl;
    iab null       NULL
endfunction
" }}}

" Ruby Mappings {{{
autocmd! FileType ruby,eruby,rdoc :call s:RubyDef()
function! s:RubyDef()
    setlocal shiftwidth=2
    setlocal tabstop=2

    " Surround % to %
    let b:surround_37 = "<% \r %>"
    xmap % S%
    " Surround = to %=
    let b:surround_61 = "<%= \r %>"
    xmap _ S=
    " Surround # to #{}
    let b:surround_35 = "#{ \r }"
    xmap # S#

    " Correct typos
    iab elseif     elsif
    iab ~=         =~
endfunction
" }}}

" Python Mappings {{{
autocmd! FileType python :call s:PythonDef()
function! s:PythonDef()
    " Correct typos
    iab true       True
    iab false      False
endfunction
" }}}

" CoffeeScript Mappings {{{
autocmd! FileType coffee :call s:CoffeeDef()
function! s:CoffeeDef()
    setlocal shiftwidth=2
    setlocal tabstop=2
endfunction
" }}}

" Html/Xml Mappings {{{
autocmd! FileType xhtml,html,slim,jade,xml,yaml :call s:WebDef()
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

    " Special characters
    iab ->> →
    iab <<- ←
    iab >>  »
    iab ^^  ↑
    iab VV  ↓
endfunction
" }}}

" Markdown Mappings {{{
autocmd! FileType markdown :call s:MarkdownDef()
function! s:MarkdownDef()
    setlocal shiftwidth=2
    setlocal tabstop=2
    setlocal spell
    setlocal wrap

    " Surround _ to _
    let b:surround_95 = "_\r_"
    xmap _ S_
    " Surround * to **
    let b:surround_42 = "**\r**"
    xmap 8 S*
    " Surround - to ~~
    let b:surround_45 = "~~\r~~"
    xmap - S-

    " Add more parentheses
    let b:AutoPairs = { '(':')',   '[':']',  '{':'}',
                    \   "'":"'",   '"':'"',  '`':'`',
                    \   '“':'”',   '‘':'’', '《':'》',
                    \  '「':'」', '（':'）'}

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
    " Insert headings
    nnoremap <buffer> <M-1> I# <ESC>
    nnoremap <buffer> <M-2> I## <ESC>
    nnoremap <buffer> <M-3> I### <ESC>
    nnoremap <buffer> <M-4> I#### <ESC>
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
iab brake;     break;
iab breka;     break;
iab breaka;    break;
iab labeled    labelled
iab seperate   separate
iab execuse    excuse
iab ture       true
iab ?8         /*
iab /8         /*
iab /*         /*
" }}}

" Directory {{{
" change working directory
command! Cwd   :cd %:p:h
" change local working directory
command! Clwd  :lcd %:p:h
" }}}

" Jekyll post/note {{{
command! Atom     :!atom %
command! Mifengtd :Unite mifengtd -start-insert -buffer-name=mifengtd
command! Blog     :Unite bicrement -start-insert -buffer-name=bicrement
command! Draft    :execute
    \ "e ~/Documents/Programming/Web/zhuochun.github.io/_drafts/new-draft.markdown"
" }}}

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim:ft=vim:fdm=marker:
