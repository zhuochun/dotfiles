if neobundle#tap('switch.vim') "{{{
  function! neobundle#hooks.on_source(bundle)
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
          \   ['\.toBe', '\.not\.toBe'],
          \   ['public', 'protected', 'private'],
          \ ]
  endfunction

  " Default switch mapping `gs` is still available
  nnoremap + :Switch<CR>

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-airline') "{{{
  function! neobundle#hooks.on_source(bundle)
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
    " modify whitespace symbol
    let g:airline_symbols.whitespace = ''
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

    " control which sections get truncated and at what width
    let g:airline#extensions#default#section_truncate_width = {
          \ 'b': 79,
          \ 'x': 60,
          \ 'y': 88,
          \ 'z': 45,
          \ 'warning': 80,
          \ 'error': 80,
          \ }

    " disable some plugin integrations
    let g:airline#extensions#tagbar#enabled = 0
    " disable summary of changed hunks under source control (gitgutter)
    let g:airline#extensions#hunks#enabled = 0
    " disable bufferline integration
    let g:airline#extensions#bufferline#enabled = 0

    " enable enhanced tabline.
    let g:airline#extensions#tabline#enabled = 1
    " display tab number instead of # of splits (default)
    let g:airline#extensions#tabline#tab_nr_type = 1
    " define the minimum number of tabs needed to show the tabline
    let g:airline#extensions#tabline#tab_min_count = 2
    " define how file names are displayed in tabline
    let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
    " disable displaying tab type, buffers, splits, close button
    let g:airline#extensions#tabline#show_buffers = 0
    let g:airline#extensions#tabline#show_tab_type = 0
    let g:airline#extensions#tabline#show_splits = 0
    let g:airline#extensions#tabline#show_close_button = 0
    " no default separators for the tabline
    let g:airline#extensions#tabline#left_sep = ''
    let g:airline#extensions#tabline#left_alt_sep = ''
    let g:airline#extensions#tabline#right_sep = ''
    let g:airline#extensions#tabline#right_alt_sep = ''
  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-bufferline') "{{{
  function! neobundle#hooks.on_source(bundle)
    " do not automatically echo bufferline to the command bar
    let g:bufferline_echo = 0
    " scrolling with fixed current buffer position
    let g:bufferline_rotate = 1
  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('CamelCaseMotion') "{{{
  " Default switch mapping `gs` is still available
  map W <Plug>CamelCaseMotion_w
  map B <Plug>CamelCaseMotion_b
  map E <Plug>CamelCaseMotion_e

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-rest-console') "{{{
  " <C-j> to trigger request
  function! neobundle#hooks.on_source(bundle)
    " set output buffer to json format
    let g:vrc_output_buffer_name = '__RESPONSE__.json'
  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-mark') "{{{
  function! neobundle#hooks.on_source(bundle)
    " Enable a richer palette of highlight colors
    let g:mwDefaultHighlightingPalette = 'maximum'
  endfunction

  " Remove the default overriding of * and #, use: >
  nmap <Plug>IgnoreMarkSearchNext <Plug>MarkSearchNext
  nmap <Plug>IgnoreMarkSearchPrev <Plug>MarkSearchPrev

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-rengbang') "{{{
  function! neobundle#hooks.on_source(bundle)
    " regex pattern for insertint sequencial numbering
    let g:rengbang_default_pattern = '\(\d\+\)'
    " start number for sequencial numbering.
    let g:rengbang_default_start = 1
    " use first number for sequencial numbering
    let g:rengbang_default_usefirst = 1
  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-easymotion') "{{{
  function! neobundle#hooks.on_source(bundle)
    " disable default mappings
    let g:EasyMotion_do_mapping = 0
    " not case censitive
    let g:EasyMotion_smartcase = 1
  endfunction

  " alias to normal editor commands
  map <C-f>  <Plug>(easymotion-sn)
  map <D-f>  <Plug>(easymotion-sn)
  " single char easymotion
  nmap s     <Plug>(easymotion-s)
  vmap s     <Plug>(easymotion-s)
  " multiple chars easymotion
  nmap S     <Plug>(easymotion-s2)
  vmap S     <Plug>(easymotion-s2)
  " visual mode to hit exact target in line
  vmap f     <Plug>(easymotion-fl)
  vmap F     <Plug>(easymotion-Fl)
  vmap t     <Plug>(easymotion-tl)
  vmap T     <Plug>(easymotion-Tl)

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-argwrap') "{{{
  function! neobundle#hooks.on_source(bundle)
    " closing brace is preceded with a comma when wrapping lines
    let g:argwrap_tail_comma = 1
  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-asterisk') "{{{
  function! neobundle#hooks.on_source(bundle)
    " keep cursor position when next/prev
    let g:asterisk#keeppos = 1
  endfunction

  map *  <Plug>(asterisk-z*)
  map #  <Plug>(asterisk-z#)
  map g* <Plug>(asterisk-gz*)
  map g# <Plug>(asterisk-gz#)

  call neobundle#untap()
endif "}}}

if neobundle#tap('incsearch.vim') "{{{
  function! neobundle#hooks.on_source(bundle)
    " enable very magic option
    let g:incsearch#magic = '\v'
    " enables Emacs-like keymappings (readline)
    let g:incsearch#emacs_like_keymap = 1
  endfunction

  " mappings to search
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)

  call neobundle#untap()
endif "}}}

if neobundle#tap('incsearch-fuzzy.vim') "{{{
  " mappings to fuzzy search
  map z/ <Plug>(incsearch-fuzzy-/)
  map z? <Plug>(incsearch-fuzzy-?)

  call neobundle#untap()
endif "}}}

if neobundle#tap('semantic-highlight.vim') "{{{
  function! neobundle#hooks.on_source(bundle)
    " A optimally distinct colors http://tools.medialab.sciences-po.fr/iwanthue/
    let g:semanticGUIColors = ['#A7C575', '#BDBDE4', '#E0ED85', '#E9C5E3', '#CAF19B', '#E9A9BB',
                              \'#9BDE9D', '#F4A091', '#89EEE4', '#E1A46A', '#97DBE2', '#E2B964',
                              \'#C4DBEC', '#D7CC71', '#B2C4CC', '#F1A87F', '#8EE9CA', '#E7C183',
                              \'#7CC9BC', '#E9B7A2', '#87DCB0', '#CEB7B5', '#CDF8C9', '#CAB996',
                              \'#97C19A', '#F5E2A8', '#B3D2BF', '#C6C989', '#E6E3CC', '#C2DDAA',
                              \'#B4BC9F', '#E6E5B2']
    " Cache color values across files
    let g:semanticUseCache = 1
    " Cache color values across sessions
    let g:semanticPersistCache = 1
    " Activate automatically for certain filetypes
    let g:semanticEnableFileTypes = {
                \   'javascript' : 'js',
                \   'coffee'     : 'coffee',
                \   'ruby'       : 'ruby',
                \   'elixir'     : 'elixir',
                \   'go'         : 'go',
                \ }
    " Add backlists item in Golang
    let g:semanticBlacklistOverride = {
                \ 'go': [
                \   'break',    'default',     'func',   'interface', 'select',
                \   'case',     'defer',       'go',     'map',       'struct',
                \   'chan',     'else',        'goto',   'package',   'switch',
                \   'const',    'fallthrough', 'if',     'range',     'type',
                \   'continue', 'for',         'import', 'return',    'var',
                \ ]}
  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-test') "{{{
  function! neobundle#hooks.on_source(bundle)
    " Use tpope/vim-dispatch to run tests in background
    let g:test#strategy = 'dispatch'
  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('auto-pairs') "{{{
  function! neobundle#hooks.on_source(bundle)
    " Disable default <BS> mapping because it maps <C-h>, which is used elsewhere
    " The original <BS> behavior is mapped with AutoPairsDelete() down below
    let g:AutoPairsMapBS = 0
    " Disable jumping multiline close
    let g:AutoPairsMultilineClose = 0
  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-easy-align') "{{{
  function! neobundle#hooks.on_source(bundle)
    " Additional align delimiters
    let g:easy_align_delimiters = {
          \ '>': { 'pattern': '>>\|=>\|>' },
          \ '\': { 'pattern': '\\' },
          \ '/': { 'pattern': '//\+\|/\*\|\*/', 'delimiter_align': 'l', 'ignore_groups': ['!Comment'] },
          \ }
  endfunction

  " Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
  xmap <CR>      <Plug>(EasyAlign)
  " Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
  nmap <leader>a <Plug>(EasyAlign)

  call neobundle#untap()
endif "}}}

if neobundle#tap('investigate.vim') "{{{
  function! neobundle#hooks.on_source(bundle)
    let g:investigate_command_for_elixir="^i!mix eh ^s"
  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('tagbar') "{{{
  function! neobundle#hooks.on_source(bundle)
    " sort according to order in file
    let g:tagbar_sort = 0
    " default is 40
    let g:tagbar_width = 42
    " omit vacant lines
    let g:tagbar_compact = 1
    " auto focus on Tagbar when opened
    let g:tagbar_autofocus = 1
    " default iconchars are too wide (Mac)
    let g:tagbar_iconchars = ['▸', '▾']
    " expand tag folds
    let g:tagbar_autoshowtag = 1
    " tagbar types coffeescript
    let g:tagbar_type_coffee = {
          \ 'ctagstype' : 'coffee',
          \ 'kinds' : [
          \   'c:classes',
          \   'm:methods',
          \   'f:functions',
          \   'v:variables',
          \   'f:fields',
          \ ]}
    " tagbar types markdown
    let g:tagbar_type_markdown = {
          \ 'ctagstype' : 'markdown',
          \ 'kinds' : [
          \   'h:Heading_L1',
          \   'i:Heading_L2',
          \   'j:Heading_L3',
          \   'k:Heading_L4'
          \ ]}
  endfunction

  " Toggle Tagbar
  nnoremap <silent> <F10> :TagbarToggle<CR>

  call neobundle#untap()
endif "}}}

if neobundle#tap('undotree') "{{{
  function! neobundle#hooks.on_source(bundle)
    " default is 30
    let g:undotree_SplitWidth = 42
    " default is 10
    let g:undotree_DiffpanelHeight = 19
    " focus undotree on open
    let g:undotree_SetFocusWhenToggle = 1
  endfunction

  " Toggle Undotree
  nnoremap <silent> <F5> :UndotreeToggle<CR>

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-anzu') "{{{
  " map to update search status and echo matches
  nmap n n<Plug>(anzu-update-search-status-with-echo)
  nmap N N<Plug>(anzu-update-search-status-with-echo)

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-over') "{{{
  function! neobundle#hooks.on_source(bundle)
    " modify prompt design
    let g:over_command_line_prompt = "❯ "
  endfunction

  " <D-r> shortcut over command line
  noremap <D-r> :OverCommandLine<CR>s/

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-brightest') "{{{
  function! neobundle#hooks.on_source(bundle)
    " Highlight with underline
    let g:brightest#highlight = { 'group': 'BrightestUnderline' }
    " Enable highlight in insert mode
    let g:brightest#enable_insert_mode = 1
    " Enable brightest only in go
    let g:brightest#enable_filetypes = { '_': 0, 'go': 1 }
  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('syntastic') "{{{
  function! neobundle#hooks.on_source(bundle)
    " fancy symbols
    let g:syntastic_error_symbol = '✗'
    let g:syntastic_warning_symbol = '‽'
    let g:syntastic_style_error_symbol = '❄'
    let g:syntastic_style_warning_symbol = '❖'

    " no check on quitting vim
    let g:syntastic_check_on_wq = 0
    " error window will be automatically closed
    let g:syntastic_auto_loc_list = 1
    " populate syntastic errors in location list
    let g:syntastic_always_populate_loc_list = 1
    " aggregate errors if multiple checkers enabled
    let g:syntastic_aggregate_errors = 1
    " height of the location lists that syntastic opens
    let g:syntastic_loc_list_height = 5

    " automatic syntax checking
    let g:syntastic_mode_map = {
          \ 'mode': 'active',
          \ 'active_filetypes': ['ruby', 'javascript', 'coffee'],
          \ 'passive_filetypes': ['html', 'css', 'scss', 'c', 'cpp', 'go'] }

    " run multiple syntastic checkers
    let g:syntastic_ruby_checkers = ['mri']
    let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
  endfunction

  " manual syntastic check
  nnoremap <silent> <F7> :SyntasticCheck<CR>

  call neobundle#untap()
endif "}}}

if neobundle#tap('nerdtree') "{{{
  " Size of the NERD tree
  let NERDTreeWinSize = 42
  " Disable 'bookmarks' and 'help'
  let NERDTreeMinimalUI = 1
  " Show hidden files
  let NERDTreeShowHidden = 1
  " Show line numbers
  let NERDTreeShowLineNumbers = 1
  " Highlight the selected entry in the tree
  let NERDTreeHighlightCursorline = 1
  " Use a single click to fold/unfold directories
  let NERDTreeMouseMode = 2
  " Replace the netrw autocommands for exploring local directories
  let NERDTreeHijackNetrw = 1
  " Delete old buffer which is no more valid
  let NERDTreeAutoDeleteBuffer = 1
  " Don't display these kinds of files in NERDTree
  let NERDTreeIgnore = [
        \ '\~$', '\.pyc$', '\.pyo$', '\.class$', '\.aps',
        \ '\.git', '\.hg', '\.svn', '\.sass-cache',
        \ '\.coverage$', '\.tmp$', '\.gitkeep$', '\.idea',
        \ '\.vcxproj', '\.bundle', '\.DS_Store$', '\tags$']
  " The old better arrows
  let g:NERDTreeDirArrowExpandable = '▸'
  let g:NERDTreeDirArrowCollapsible = '▾'

  " Toggle NERDTree
  nnoremap <silent> <F3> :NERDTreeToggle<CR>

  call neobundle#untap()
endif "}}}

if neobundle#tap('unite.vim') "{{{
  function! neobundle#hooks.on_source(bundle) " {{{
    " base profile
    call unite#custom#profile('default', 'context', {
          \   'ignorecase': 1,
          \   'smartcase': 1,
          \   'winheight': 6,
          \   'direction': 'dynamictop',
          \   'prompt': '» ',
          \   'prompt_focus': 1,
          \   'short_source_names' : 1,
          \ })

    " sorter_default
    call unite#filters#sorter_default#use(['sorter_rank'])
    " matcher default
    call unite#filters#matcher_default#use(['matcher_fuzzy'])

    " sorters
    call unite#custom#source(
          \ 'buffer,file,directory,file_rec,file_rec/async,file_rec/git',
          \ 'sorters', ['sorter_selecta'])

    " matchers
    call unite#custom#source(
          \ 'buffer,file,directory,file_rec,file_rec/async,file_rec/git',
          \ 'matchers', ['converter_relative_word', 'matcher_fuzzy'])

    " converters
    call unite#custom#source(
          \ 'file_rec,file_rec/async,file_rec/git,file_mru',
          \ 'converters', ['converter_file_directory'])

    " matchers for neomru
    call unite#custom#source(
          \ 'neomru/file,neomru/directory',
          \ 'matchers', ['converter_relative_word', 'matcher_fuzzy', 'matcher_hide_hidden_files', 'matcher_hide_current_file'])

    " Disable auto select
    let g:unite_enable_auto_select = 0

    " Custom unite menus {{
    let g:unite_source_menu_menus = {}

      " Unite Git Menus {
      let g:unite_source_menu_menus.git = {
                  \   'description' : 'Git Commands',
                  \ }
      let g:unite_source_menu_menus.git.command_candidates = [
                  \   ['Gist', 'Unite -buffer-name=gist gist'],
                  \   ['Grep', 'Unite grep/git:/:--cached:file'],
                  \   ['Gitflow Magit', 'Magit'],
                  \   ['Commit Browser', 'GV'],
                  \   ['Status', 'Gstatus'],
                  \   ['Conflicts', 'Unite git-conflict'],
                  \   ['Previous Hunk', 'GitGutterPrevHunk'],
                  \   ['Next Hunk', 'GitGutterNextHunk'],
                  \   ['Stage Hunk', 'GitGutterStageHunk'],
                  \   ['Revert Hunk', 'GitGutterRevertHunk'],
                  \   ['Stage Current File', 'Gwrite'],
                  \   ['Commit All Changes', 'Gcommit --verbose'],
                  \   ['Amend Last Commit', 'Gcommit --amend --verbose'],
                  \   ['Revert Last Commit', 'Gread'],
                  \   ['Diff', 'Gvdiff'],
                  \   ['Blame', 'Gblame'],
                  \   ['Show Log', 'Gllog'],
                  \   ['Show Current File Log', 'Gllog -- %'],
                  \   ['Browse on GitHub', 'Gbrowse'],
                  \   ['Copy GitHub Path', 'Gbrowse!'],
                  \ ]
      " }

      " Unite Ruby Refactor Menus {
      let g:unite_source_menu_menus.ruby = {
                  \   'description' : 'Ruby Commands',
                  \ }
      let g:unite_source_menu_menus.ruby.command_candidates = [
                  \   ['Inline Temporary Variable', 'RInlineTemp'],
                  \   ['Convert Post Condition', 'RConvertPostConditional'],
                  \   ['Extract Constant', 'RExtractConstant'],
                  \   ['Extract Rspec Let', 'RExtractLet'],
                  \   ['Extract Local Variable', 'RExtractLocalVariable'],
                  \   ['Rename Local Variable', 'RRenameLocalVariable'],
                  \   ['Rename Instance Variable', 'RRenameInstanceVariable'],
                  \   ['Extract Method', 'RExtractMethod'],
                  \ ]
      " }

      " Unite Go Menus {
      let g:unite_source_menu_menus.golang = {
                  \   'description' : 'Golang Commands',
                  \ }
      let g:unite_source_menu_menus.golang.command_candidates = [
                  \   ['Lint Current File', 'GoLint'],
                  \   ['Metalint Current File', 'GoMetaLinter'],
                  \   ['Check Unchecked Errors', 'GoErrCheck'],
                  \   ['Format Current File', 'GoFmt'],
                  \   ['Rename Identifier', 'GoRename'],
                  \   ['Update Imports', 'GoImports'],
                  \   ['Goto Declaration', 'GoDef'],
                  \   ['Lookup Type Info', 'GoInfo'],
                  \   ['Lookup Referrers', 'GoReferrers'],
                  \   ['Open Doc', 'GoDoc'],
                  \   ['Open Doc in Browser', 'GoDocBrowser'],
                  \   ['Test Current File', 'GoTest'],
                  \   ['Test Current Function', 'GoTestFunc'],
                  \   ['Run', 'GoRun'],
                  \   ['Build', 'GoBuild'],
                  \   ['Go Path', 'GoPath'],
                  \   ['Go Install Binaries', 'GoInstallBinaries'],
                  \   ['Go Update Binaries', 'GoUpdateBinaries'],
                  \ ]
      " }

      " Unite System Commands Menus {
      let g:unite_source_menu_menus.common = {
                  \   'description' : 'System Commands',
                  \ }
      let g:unite_source_menu_menus.common.command_candidates = [
                  \   ['Yank Current File', 'Ywd'],
                  \   ['Yank Current File:Line', 'Ycl'],
                  \   ['Cd to buffer directory', 'cd %:p:h'],
                  \   ['Cd to project roor directory', 'Root'],
                  \   ['Generate tags', 'cd %:p:h | Dispatch! ctags .'],
                  \   ['Edit .projections.json', 'cd %:p:h | e .projections.json'],
                  \   ['Show Mappings', 'Unite mapping'],
                  \   ['Source vimrc', 'so $MYVIMRC'],
                  \   ['Edit vimrc', 'e $MYVIMRC'],
                  \ ]
      " }
    " }}

    " Adjust unite-tag format to show more details. :help unite-tag-customize {{
    " Max length of file name field in candidate
    let g:unite_source_tag_max_fname_length = 42

    " Use Ag to Grep
    if executable('ag')
      " Use ag in unite grep source.
      let g:unite_source_grep_command = 'ag'
      let g:unite_source_grep_default_opts =
            \ '-i --vimgrep --line-numbers --hidden ' .
            \ '--ignore ''.git'' --ignore ''.hg'' ' .
            \ '--ignore ''.idea'' --ignore ''node_modules'''
      let g:unite_source_grep_recursive_opt = ''
    endif
  endfunction " }}}

  " Press <C-l> to refresh cached files when new files not appearing
  " Press <C-r> to restart Unite and fix Unite glitches

  " File switching using file_rec
  nnoremap <silent> <D-i> :<C-u>Unite -buffer-name=files file_rec/async:! -start-insert<CR>
  " File switching using git (fast)
  nnoremap <silent> <D-o> :<C-u>Unite -buffer-name=files file_rec/git:--cached:--others:--exclude-standard -start-insert<CR>

  " Grep in current directory
  nnoremap <silent> <D-/> :<C-u>Unite -buffer-name=grep grep:. -auto-preview -no-split -no-empty<CR>
  nnoremap <silent> <D-F> :<C-u>Unite -buffer-name=grep grep:. -auto-preview -no-split -no-empty -no-quit<CR>
  " Grep the word under cursor in visual mode
  vnoremap <silent> <D-/> :<C-u>UniteWithCursorWord -buffer-name=grep grep:. -auto-preview -no-split -no-empty<CR>
  vnoremap <silent> <D-F> :<C-u>UniteWithCursorWord -buffer-name=grep grep:. -auto-preview -no-split -no-empty -no-quit<CR>

  " Unite resume the last unite buffer
  nnoremap <silent> go. :<C-u>UniteResume<CR>
  " Unite grep in current directory
  nnoremap <silent> go/ :<C-u>Unite -buffer-name=grep grep:. -auto-preview -no-split -no-empty<CR>
  vnoremap <silent> go/ :<C-u>UniteWithCursorWord -buffer-name=grep grep:. -auto-preview -no-split -no-empty<CR>
  nnoremap <silent> go? :<C-u>UniteResume grep<CR>
  " Unite junkfile
  nnoremap <silent> goi :<C-u>Unite -buffer-name=junkfile junkfile/new junkfile -start-insert<CR>
  " Unite neomru
  nnoremap <silent> gof :<C-u>Unite -buffer-name=MRU_file neomru/file -start-insert<CR>
  nnoremap <silent> god :<C-u>Unite -buffer-name=MRU_dirs neomru/directory -start-insert -default-action=lcd<CR>
  " Unite menus
  nnoremap <silent> goM :<C-u>Unite -buffer-name=menus menu -start-insert<CR>
  nnoremap <silent> goG :<C-u>Unite -buffer-name=menus menu:git -start-insert<CR>
  " Unite plugins
  nnoremap <silent> gor :<C-u>Unite -buffer-name=register register<CR>
  nnoremap <silent> gom :<C-u>Unite -buffer-name=marks mark<CR>
  nnoremap <silent> goc :<C-u>Unite -buffer-name=colorscheme colorscheme -auto-preview<CR>
  nnoremap <silent> goo :<C-u>Unite -buffer-name=outline outline -start-insert<CR>
  nnoremap <silent> gob :<C-u>Unite -buffer-name=buffers buffer -start-insert<CR>
  nnoremap <silent> gou :<C-u>Unite -buffer-name=tabs tab:no-current -start-insert<CR>
  nnoremap <silent> got :<C-u>Unite -buffer-name=tags tag/include -start-insert<CR>
  nnoremap <silent> goT :<C-u>UniteWithCursorWord -buffer-name=tags tag/include -start-insert<CR>
  nnoremap <silent> goj :<C-u>Unite -buffer-name=files file_rec/git:--cached:--others:--exclude-standard -start-insert<CR>
  nnoremap <silent> goJ :<C-u>Unite -buffer-name=files file_rec/async:! -start-insert<CR>
  nnoremap <silent> gos :<C-u>Unite -buffer-name=session session/new session -start-insert<CR>
  nnoremap <silent> gos :<C-u>Unite -buffer-name=spell spell_suggest<CR>
  nnoremap <silent> go* :<C-u>Unite -buffer-name=search anzu<CR>
  nnoremap <silent> goh :<C-u>Unite -buffer-name=search line:all -start-insert<CR>
  nnoremap <silent> gog :<C-u>Unite -buffer-name=search git-conflict -start-insert<CR>
  nnoremap <silent> gol :<C-u>Unite -buffer-name=quickfix location_list<CR>
  nnoremap <silent> goq :<C-u>Unite -buffer-name=quickfix quickfix<CR>
  nnoremap <silent> goy :<C-u>Unite -buffer-name=yanks yankround<CR>
  " }}

  " Key Mappings in Unite {{
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
    imap <buffer> <C-k>     <Plug>(unite_complete)
    imap <buffer> <C-j>     <Plug>(unite_complete)

    " preview, use p to toggle preview
    nmap <buffer> <C-p>     <Plug>(unite_toggle_auto_preview)

    " path settings
    imap <buffer> <C-y>     <Plug>(unite_narrowing_path)
    nmap <buffer> <C-y>     <Plug>(unite_narrowing_path)

    " change directory
    nnoremap <silent><buffer><expr> cd   unite#do_action('lcd')
    nnoremap <silent><buffer><expr> !    unite#do_action('start')

    " replace/rename
    let unite = unite#get_current_unite()
    if unite.profile_name ==# '^search' || unite.profile_name ==# '^grep'
      nnoremap <silent><buffer><expr> r  unite#do_action('replace')
    else
      nnoremap <silent><buffer><expr> r  unite#do_action('rename')
    endif

    " toggle preview window
    nnoremap <silent><buffer><expr> p
          \ empty(filter(range(1, winnr('$')),
          \ 'getwinvar(v:val, "&previewwindow") != 0')) ?
          \ unite#do_action('preview') : ":\<C-u>pclose!\<CR>"
  endfunction "}}

  call neobundle#untap()
endif "}}}

if neobundle#tap('junkfile.vim') "{{{
  function! neobundle#hooks.on_source(bundle)
    let g:junkfile#directory = expand('~/Documents/Notes')
  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('yankround.vim') "{{{
  function! neobundle#hooks.on_source(bundle)
    " number of yank history to keep
    let g:yankround_max_history = 100
  endfunction

  " yankround mappings
  nmap p  <Plug>(yankround-p)
  xmap p  <Plug>(yankround-p)
  nmap P  <Plug>(yankround-P)

  " loop yanks, <leader>y, <leader>Y
  nmap <leader>y <Plug>(yankround-prev)
  nmap <leader>Y <Plug>(yankround-next)

  " yanks in commandline
  cmap <C-r> <Plug>(yankround-insert-register)
  cmap <C-y> <Plug>(yankround-pop)

  call neobundle#untap()
endif "}}}

if neobundle#tap('vimshell.vim') "{{{
  function! neobundle#hooks.on_source(bundle)
    " Default prompt string
    let g:vimshell_prompt = $USER." $ "
    " Display current dir
    let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
    " Split height for VimShellPop (default 30)
    let g:vimshell_popup_height = 19
  endfunction

  " Send to interpreter
  nnoremap <leader>e :VimShellSendString<CR>
  vnoremap <leader>e :VimShellSendString<CR>

  " VimShellInteractive Commands {{
  command! Pry    :execute "VimShellInteractive --split='split <bar> resize 9' pry"
  command! Irb    :execute "VimShellInteractive --split='split <bar> resize 9' irb --simple-prompt"
  command! Node   :execute "VimShellInteractive --split='split <bar> resize 9' node"
  command! Coffee :execute "VimShellInteractive --split='split <bar> resize 9' coffee"
  " }}

  " VimShell buffer settings {{
  autocmd! FileType vimshell call s:vimshell_settings()
  function! s:vimshell_settings()
    " command alterative
    call vimshell#altercmd#define('g', 'git')
    " alias
    call vimshell#set_alias('l', 'ls -al')
    " autojump
    call vimshell#set_alias('j', ':Unite -buffer-name=files
         \ -default-action=lcd -no-split -input=$$args neomru/directory')
  endfunction " }}

  " VimShellInteractive settings {{
  autocmd! FileType int-* call s:interactive_settings()
  function! s:interactive_settings()
    nunmap <buffer><C-l>
  endfunction " }}

  call neobundle#untap()
endif "}}}

if neobundle#tap('neocomplete.vim') "{{{
  function! neobundle#hooks.on_source(bundle)
    " disable AutoComplPop and use neocomplete
    let g:acp_enableAtStartup = 0

    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#enable_camel_case = 1
    let g:neocomplete#enable_auto_delimiter = 1
    let g:neocomplete#enable_fuzzy_completion = 1

    let g:neocomplete#auto_completion_start_length = 1
    let g:neocomplete#manual_completion_start_length = 1

    let g:neocomplete#max_list = 42
    let g:neocomplete#max_keyword_width = 80
    let g:neocomplete#min_keyword_length = 3

    let g:neocomplete#lock_iminsert = 0
    let g:neocomplete#lock_buffer_name_pattern = '\.log\|\.log\.\|.*quickrun.*\|.jax|\*ku\*'

    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#sources#buffer#max_keyword_width = 42
    let g:neocomplete#sources#buffer#disabled_pattern = '\.log\|\.log\.\|\.jax'

    " Appoints vim source call function when completes custom and customlist command
    let g:neocomplete#sources#vim#complete_functions = {
          \   'Unite' : 'unite#complete_source',
          \   'VimShellExecute' : 'vimshell#vimshell_execute_complete',
          \   'VimShellInteractive' : 'vimshell#vimshell_execute_complete',
          \   'VimShellTerminal' : 'vimshell#vimshell_execute_complete',
          \   'VimShell' : 'vimshell#complete',
          \ }

    " Set to use omnifunc
    if !exists('g:neocomplete#sources#omni#functions')
      let g:neocomplete#sources#omni#functions = {}
    endif
    " Per filetype omnifunc
    let g:neocomplete#sources#omni#functions.go = 'go#complete#Complete'

    " Fallbacks on complete keywords by neocomplete and omnifunc
    " let g:neocomplete#fallback_mappings = ['\<C-x>\<C-o>', '\<C-x>\<C-n>']
  endfunction

  " Plugin key-mappings
  inoremap <expr><C-g> pumvisible() ? neocomplete#undo_completion() : "<ESC>"
  inoremap <expr><C-l> neocomplete#complete_common_string()

  " <CR> close popup and save indent
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return pumvisible() ? neocomplete#close_popup() : "\<CR>"
  endfunction

  " <TAB> completion
  inoremap <expr><TAB> pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ neocomplete#start_manual_complete()
  function! s:check_back_space()
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~ '\s'
  endfunction
  " <S-TAB> completion backward
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
  " <BS> close popup and delete backword char
  inoremap <expr><BS> pumvisible() ?
        \ neocomplete#smart_close_popup()."\<C-h>" :
        \ AutoPairsDelete()
  " <Space> close popup
  inoremap <expr><Space> pumvisible() ?
        \ neocomplete#close_popup()."\<Space>" : "\<Space>"

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-monster') "{{{
  function! neobundle#hooks.on_source(bundle)
    " Set completion method (async_rct_complete not working)
    let g:monster#completion#rcodetools#backend = "rct_complete"
  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('neosnippet.vim') "{{{
  function! neobundle#hooks.on_source(bundle)
    " Default expand with word boundary
    let g:neosnippet#expand_word_boundary = 1
    " Disables standart snippets, use vim-snippets bundle instead
    let g:neosnippet#disable_runtime_snippets = { '_' : 1 }
    " Enable SnipMate compatibility feature.
    let g:neosnippet#enable_snipmate_compatibility = 1
    " Enable complete func type
    let g:neosnippet#enable_completed_snippet = 1
    " Tell Neosnippet about the other snippets
    let g:neosnippet#snippets_directory = '~/.vim/bundle/vim-snippets/snippets'

    " Snippet variables
    let g:snips_author = 'Wang Zhuochun'
    let g:snips_email  = 'zhuochun@hotmail.com'
    let g:snips_github = 'https://github.com/zhuochun'
  endfunction

  " Remove snippet markers after save
  autocmd! BufWritePre * NeoSnippetClearMarkers

  " Plugin jump then expand
  imap <C-j> <Plug>(neosnippet_jump_or_expand)
  smap <C-j> <Plug>(neosnippet_jump_or_expand)
  imap <D-j> <Plug>(neosnippet_jump_or_expand)
  smap <D-j> <Plug>(neosnippet_jump_or_expand)
  " Alternative expand then jump
  imap <C-k> <Plug>(neosnippet_expand_or_jump)
  smap <C-k> <Plug>(neosnippet_expand_or_jump)
  imap <D-k> <Plug>(neosnippet_expand_or_jump)
  smap <D-k> <Plug>(neosnippet_expand_or_jump)
  " Visual expand
  xmap <C-j> <Plug>(neosnippet_expand_target)
  xmap <D-j> <Plug>(neosnippet_expand_target)

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-choosewin') "{{{
  function! neobundle#hooks.on_source(bundle)
    " don't blink at land
    let g:choosewin_blink_on_land = 0
  endfunction

  " choose window
  nmap gow <Plug>(choosewin)

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-multiple-cursors') "{{{
  " Use default mappings for multiple-cursors
  " let g:multi_cursor_use_default_mapping = 1
  " let g:multi_cursor_next_key = '<C-n>'
  " let g:multi_cursor_prev_key = '<C-p>'
  " let g:multi_cursor_skip_key = '<C-x>'
  " let g:multi_cursor_quit_key = '<Esc>'

  function! neobundle#hooks.on_source(bundle)
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
  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-surround') "{{{
  xmap ( S)
  xmap { S{
  xmap [ S]
  xmap " S"
  xmap ' S'
  xmap ` S`
  xmap T St

  call neobundle#untap()
endif "}}}

if neobundle#tap('open-browser.vim') "{{{
  function! neobundle#hooks.on_source(bundle)
    " disable netrw's gx mapping.
    let g:netrw_nogx = 1
  endfunction

  " gx mappings
  nmap gx <Plug>(openbrowser-smart-search)
  vmap gx <Plug>(openbrowser-smart-search)

  call neobundle#untap()
endif "}}}

if neobundle#tap('indentLine') "{{{
  function! neobundle#hooks.on_source(bundle)
    let g:indentLine_faster = 1
    let g:indentLine_char = '┊'
    let g:indentLine_fileTypeExclude = ['markdown', 'text']
  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('goyo.vim') "{{{
  function! neobundle#hooks.on_source(bundle)
    let g:goyo_width = 90
  endfunction

  " Toggle Goyo
  nnoremap <F11> :Goyo<CR>

  call neobundle#untap()
endif "}}}

if neobundle#tap('limelight.vim') "{{{
  function! neobundle#hooks.on_source(bundle)
    let g:limelight_paragraph_span = 1
    let g:limelight_priority = -1
  endfunction

  function! s:goyo_enter()
    set scrolloff=999
    Limelight
  endfunction

  function! s:goyo_leave()
    set scrolloff=6
    Limelight!
  endfunction

  autocmd! User GoyoEnter nested call <SID>goyo_enter()
  autocmd! User GoyoLeave nested call <SID>goyo_leave()

  call neobundle#untap()
endif "}}}

if neobundle#tap('emmet-vim') "{{{
  function! neobundle#hooks.on_source(bundle)
    " enable emmet functions in insert mode only
    let g:user_emmet_mode = 'i'

    " <D-y> to expand input in insert mode
    let g:user_emmet_expandabbr_key = '<D-y>'
    "  <D-Y> to goto next point
    let g:user_emmet_next_key = '<D-Y>'
    " <M-y> to goto prev point
    let g:user_emmet_prev_key = '<M-y>'

    " complete tags using omnifunc
    let g:use_emmet_complete_tag = 1
  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-json') "{{{
  function! neobundle#hooks.on_source(bundle)
    let g:vim_json_syntax_conceal = 0
  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-coffee-script') "{{{
  function! neobundle#hooks.on_source(bundle)
    let coffee_make_options = '--bare'
  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('javascript-libraries-syntax.vim') "{{{
  function! neobundle#hooks.on_source(bundle)
    let g:used_javascript_libs = 'jquery,underscore,angularjs,react,flux,jasmine,chai'
  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('tern_for_vim') "{{{
  function! neobundle#hooks.on_source(bundle)
    let g:tern_show_argument_hints = 'on_hold'
    let g:tern_show_signature_in_pum = 1
  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-ruby') "{{{
  function! neobundle#hooks.on_source(bundle)
    " disable the 'end' keyword colorized
    let g:ruby_no_expensive = 1

    " load/evaluate code in order to provide completions. This may cause some code execution,
    " which may be a concern. This is not enabled by default
    let g:rubycomplete_buffer_loading = 0
    " parse the entire buffer to add a list of classes to the completion results.
    " This feature is turned off by default.
    let g:rubycomplete_classes_in_global = 0
    " detect and load Rails environment for files within a rails project. The feature is disabled by default.
    let g:rubycomplete_rails = 0
    " use Bundler.require instead of parsing the Gemfile
    let g:rubycomplete_use_bundler = 0
  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-i18n') "{{{
  command! I18Translate :call I18nTranslateString()<CR>
  command! I18Display   :call I18nDisplayTranslation()<CR>

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-ruby-refactoring') "{{{
  function! neobundle#hooks.on_source(bundle)
    " :RAddParameter           : Add Method Parameter
    " :RInlineTemp             : Inline Temp
    " :RConvertPostConditional : Convert Post Conditional
    " :RExtractConstant        : Extract Constant
    " :RExtractLet             : Extract to Let (Rspec)
    " :RExtractLocalVariable   : Extract Local Variable
    " :RRenameLocalVariable    : Rename Local Variable
    " :RRenameInstanceVariable : Rename Instance Variable
    " :RExtractMethod          : Extract Method
    let g:ruby_refactoring_map_keys = 0
  endfunction

  call neobundle#untap()
endif "}}}

" https://github.com/fatih/vim-go-tutorial
" https://www.youtube.com/watch?v=7BqJ8dzygtU
if neobundle#tap('vim-go') "{{{
  function! neobundle#hooks.on_source(bundle)
    " Enable goimports to insert import paths instead of gofmt
    let g:go_fmt_command = 'goimports'
    " Disable fmt command errors
    let g:go_fmt_fail_silently = 1
    " Run GoMetaLinter on save
    let g:go_metalinter_autosave = 1
    let g:go_metalinter_autosave_enabled = ['vet', 'errcheck', 'golint', 'ineffassign']
    " Disable auto jump to first error
    let g:go_jump_to_error = 1
    " Reuse buffer when GoDef
    let g:go_def_reuse_buffer = 1
    " Disable show :GoInfo for word under cursor automatically
    let g:go_auto_type_info = 0
    " No auto template when create new file
    let g:go_template_autocreate = 0
    " Use camelcase for tags, :GoAddTags
    let g:go_snippet_case_type = "camelcase"
    " No highlights commonly used library types
    let g:go_highlight_extra_types = 1
    " Highlights go:generate directives
    let g:go_highlight_generate_tags = 1
    " Echoes information about various Go commands
    let g:go_echo_command_info = 1
  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-markdown') "{{{
  function! neobundle#hooks.on_source(bundle)
    let g:markdown_enable_mappings = 0
  endfunction

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-gitgutter') "{{{
  function! neobundle#hooks.on_source(bundle)
    " no need to update in realtime
    let g:gitgutter_realtime = 0
    " update when switch buffer/tab, or focus on gui
    let g:gitgutter_eager = 1
  endfunction

  " vim-gitgutter default mappings
  " nmap [c         <Plug>GitGutterPrevHunk
  " nmap ]c         <Plug>GitGutterNextHunk
  " nmap <leader>hs <Plug>GitGutterStageHunk
  " nmap <leader>hr <Plug>GitGutterRevertHunk

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-tmux-navigator') "{{{
  function! neobundle#hooks.on_source(bundle)
    " disable tmux navigator when zooming the Vim pane
    let g:tmux_navigator_disable_when_zoomed = 1
  endfunction

  call neobundle#untap()
endif "}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim:ft=vim:fdm=marker:sw=2:ts=2
