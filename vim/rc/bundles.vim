" diff two blocks of code {{{
NeoBundleLazy 'AndrewRadev/linediff.vim', {
      \   'autoload' : { 'commands' : ['Linediff', 'LinediffReset'] }
      \ }
" }}}

" switch between words {{{
NeoBundleLazy 'AndrewRadev/switch.vim', {
      \   'autoload' : { 'commands': ['Switch'] },
      \ }
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
NeoBundleLazy 'arecarn/selection.vim'
NeoBundleLazy 'arecarn/crunch.vim', {
      \   'depends' : 'arecarn/selection.vim',
      \   'autoload' : {
      \     'mappings' : ['g=', 'g=='],
      \     'commands' : ['Crunch'],
      \   }
      \ }
" }}}

" bling bundles {{{
NeoBundle 'bling/vim-airline'
NeoBundle 'bling/vim-bufferline'
" }}}

" CamelCaseMotion in W, B, E {{{
NeoBundle 'bkad/CamelCaseMotion', {
      \   'autoload' : { 'mappings' : ['<Plug>CamelCaseMotion'] },
      \ }
" }}}

" buffers {{{
NeoBundleLazy 'mhinz/vim-sayonara', {
      \   'autoload' : { 'commands' : ['Sayonara!', 'Sayonara'] },
      \ }

NeoBundleLazy 'schickling/vim-bufonly', {
      \   'autoload' : { 'commands' : ['BufOnly', 'BOnly'] },
      \ }
" }}}

" NrrwRgn {{{
NeoBundleLazy 'chrisbra/NrrwRgn', {
      \   'autoload' : { 'commands' : ['NarrowRegion', 'NRPrepare', 'NRMulti'], },
      \ }
" }}}

" Enhanced Vimdiff {{{
NeoBundleLazy 'chrisbra/vim-diff-enhanced', {
      \   'autoload' : { 'commands' : ['EnhancedDiff', 'PatienceDiff'], },
      \ }
" }}}

" rest-console {{{
" set filetypes=rest, then use <C-j> to trigger request
NeoBundleLazy 'diepm/vim-rest-console', {
      \   'autoload' : { 'filetypes' : ['rest'] },
      \ }
" }}}

" highlight phrases {{{
NeoBundleLazy 'dimasg/vim-mark', {
      \   'autoload' : {
      \     'commands' : ['Mark', 'MarkLoad', 'MarkClear'],
      \     'mappings' : ['<Plug>IgnoreMark', '<Plug>Mark', ','],
      \   },
      \ }
" }}}

" sequencial numbering with pattern {{{
NeoBundleLazy 'deris/vim-rengbang', {
      \   'autoload' : {
      \     'commands' : ['RengBang', 'RengBangUsePrev', 'RengBangConfirm'],
      \     'mappings' : ['<Plug>(operator-rengbang'],
      \   },
      \ }
" }}}

" vim-asterisk: * and # to search selection {{{
NeoBundleLazy 'haya14busa/vim-asterisk', {
      \   'autoload' : { 'mappings' : ['<Plug>(asterisk-'], },
      \ }
" }}}

" incsearch.vim {{{
NeoBundleLazy 'haya14busa/incsearch.vim', {
      \   'autoload' : { 'mappings' : ['<Plug>(incsearch-'], },
      \ }

NeoBundleLazy 'haya14busa/incsearch-fuzzy.vim', {
      \   'depends'  : 'haya14busa/incsearch.vim',
      \   'autoload' : { 'mappings' : ['<Plug>(incsearch-fuzzy-'], },
      \ }
" }}}

" semantic-highlight {{{
NeoBundleLazy 'jaxbot/semantic-highlight.vim', {
      \   'autoload' : {
      \     'commands' : ['SemanticHighlight'],
      \     'filetypes': ['ruby', 'coffee'],
      \   },
      \ }
" }}}

" trigger tests {{{
NeoBundleLazy 'janko-m/vim-test', {
      \   'depends' : 'tpope/vim-dispatch',
      \   'autoload' : {
      \     'commands' : ['TestLast', 'TestNearest', 'TestFile', 'TestSuite'],
      \     'mappings' : ['<Plug>(operator-rengbang'],
      \   },
      \ }
" }}}

" auto-pairs {{{
NeoBundle 'jiangmiao/auto-pairs'
" }}}

" vim-easy-align {{{
NeoBundleLazy 'junegunn/vim-easy-align', {
      \   'autoload' : { 'mappings' : ['<Plug>(EasyAlign)'] },
      \ }
" }}}

" rainbow_parentheses {{{
NeoBundleLazy 'junegunn/rainbow_parentheses.vim', {
      \   'autoload' : { 'commands' : ['RainbowParentheses'] },
      \ }
" }}}

" open documentation {{{
NeoBundleLazy 'keith/investigate.vim', {
      \   'autoload' : { 'mappings' : ['gK'] },
      \ }
" }}}

" multiple cursors {{{
NeoBundleLazy 'terryma/vim-multiple-cursors', {
      \   'autoload' : { 'mappings' : ['<C-n>'] }
      \ }
" }}}

" easymotion {{{
NeoBundleLazy 'easymotion/vim-easymotion', {
      \   'autoload' : { 'mappings' : ['<Plug>(easymotion-'] },
      \ }
" }}}

" Yank ring {{{
NeoBundle 'LeafCage/yankround.vim', {
      \   'depends' : ['Shougo/unite.vim'],
      \   'autoload': {'unite_sources': 'yankround'}
      \ }
" }}}

" Tagbar {{{
NeoBundleLazy 'majutsushi/tagbar', {
      \   'autoload' : { 'commands' : ['TagbarToggle'] },
      \ }
" }}}

" match open/close {{{
NeoBundle 'matchit.zip'
" }}}

" undotree {{{
NeoBundleLazy 'mbbill/undotree', {
      \   'autoload' : { 'commands': ['UndotreeToggle'] },
      \ }
" }}}

" osyo-manga bundles {{{
NeoBundleLazy 'osyo-manga/vim-anzu', {
      \   'autoload' : { 'mappings' : ['<Plug>(anzu-'] },
      \ }

NeoBundleLazy 'osyo-manga/vim-over', {
      \   'autoload' : { 'commands' : ['OverCommandLine'] },
      \ }
" }}}

" Syntastic {{{
NeoBundle 'scrooloose/syntastic'
" }}}

" NERDTree {{{
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'jistr/vim-nerdtree-tabs', {
      \   'depends' : 'scrooloose/nerdtree',
      \   'autoload' : { 'mappings' : ['<Plug>(NERDTree'] },
      \ }
" }}}

" Shougo bundles {{{
NeoBundle 'Shougo/context_filetype.vim'

" Async execution library {{
NeoBundle 'Shougo/vimproc.vim', {
      \   'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'linux' : 'make',
      \     'unix' : 'gmake',
      \   }
      \ }
" }}

NeoBundleLazy 'Shougo/neoinclude.vim'
" }}

" Unite {{
NeoBundle 'Shougo/unite.vim', {
      \   'depends' : ['Shougo/vimproc.vim'],
      \ }

NeoBundleLazy 'Shougo/neomru.vim', {
      \   'depends' : ['Shougo/unite.vim'],
      \   'autoload': {'unite_sources': ['neomru/file', 'neomru/directory']}
      \ }

NeoBundleLazy 'Shougo/unite-outline', {
      \   'depends' : ['Shougo/unite.vim'],
      \   'autoload': {'unite_sources': 'outline'}
      \ }

NeoBundleLazy 'Shougo/junkfile.vim', {
      \   'depends' : ['Shougo/unite.vim'],
      \   'autoload': {'unite_sources' : ['junkfile', 'junkfile/new']}
      \ }

NeoBundleLazy 'kopischke/unite-spell-suggest', {
      \   'depends' : ['Shougo/unite.vim'],
      \   'autoload': {'unite_sources': 'spell_suggest'}
      \ }

NeoBundleLazy 'ujihisa/unite-colorscheme', {
      \   'depends' : ['Shougo/unite.vim'],
      \   'autoload': {'unite_sources': 'colorscheme'}
      \ }

NeoBundleLazy 'osyo-manga/unite-quickfix', {
      \   'depends' : ['Shougo/unite.vim'],
      \   'autoload': {'unite_sources': ['quickfix', 'location_list']}
      \ }

NeoBundleLazy 'tsukkee/unite-tag', {
      \   'depends' : ['Shougo/unite.vim', 'Shougo/neoinclude.vim'],
      \   'autoload': {'unite_sources': 'tag'}
      \ }
" }}

" VimShell {{
NeoBundleLazy 'Shougo/vimshell.vim', {
      \   'depends' : 'Shougo/vimproc.vim',
      \   'autoload' : {
      \     'commands' : ['VimShellPop', 'VimShellTab'],
      \     'mappings' : ['<Plug>(vimshell_'],
      \   },
      \ }
" }}

" NeoComplete {{
NeoBundleLazy 'Shougo/neocomplete.vim', {
      \   'depends'  : ['Shougo/context_filetype.vim', 'Shougo/neoinclude.vim'],
      \   'autoload' : {'insert': 1}
      \ }

" Complete words in English
NeoBundleLazy 'ujihisa/neco-look', {
      \   'depends'  : ['Shougo/neocomplete.vim'],
      \   'autoload' : {'insert': 1}
      \ }

" Complete with syntax source
NeoBundleLazy 'Shougo/neco-syntax', {
      \   'depends'  : ['Shougo/neocomplete.vim'],
      \   'autoload' : {'insert': 1}
      \ }

" Complete vimscript
NeoBundleLazy 'Shougo/neco-vim', {
      \   'depends'  : ['Shougo/neocomplete.vim'],
      \   'autoload' : {'filetypes': 'vim'}
      \ }

" Complete Ruby with RSense
" NeoBundleLazy 'supermomonga/neocomplete-rsense.vim', {
"       \   'depends'  : ['Shougo/neocomplete.vim'],
"       \   'autoload' : {'filetypes': 'ruby'}
"       \ }

" Complete Ruby with rcodetools
" NeoBundleLazy 'osyo-manga/vim-monster', {
"       \   'depends'  : ['Shougo/vimproc.vim', 'Shougo/neocomplete.vim'],
"       \   'autoload' : {'filetypes': 'ruby'}
"       \ }
" }}

" NeoSnippet {{
NeoBundleLazy 'Shougo/neosnippet.vim', {
      \   'depends'  : ['Shougo/context_filetype.vim'],
      \   'autoload' : {
      \     'insert': 1,
      \     'filetypes' : ['snippet', 'neosnippet'],
      \     'unite_sources': ['neosnippet', 'neosnippet/user', 'neosnippet/runtime'],
      \   }
      \ }

NeoBundleLazy 'zhuochun/vim-snippets'
NeoBundleLazy 'zhuochun/vim-dicts'
" }}
" }}}

" accelerated-jk {{{
NeoBundleLazy 'rhysd/accelerated-jk', {
      \   'autoload' : { 'mappings' : ['<Plug>(accelerated_'] }
      \ }
" }}}

" improve blockwise visual mode {{{
NeoBundleLazy 'kana/vim-niceblock', {
      \   'autoload' : { 'mappings' : ['<Plug>(niceblock', 'v'] }
      \ }
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
" MixedCase (crm), camelCase (crc) snake_case (crs), UPPER_CASE (cru)
NeoBundleLazy 'tpope/vim-abolish', {
      \   'autoload' : {
      \     'mappings' : ['crm', 'crc', 'crs', 'cru'],
      \     'commands' : ['Abolish']
      \   }
      \ }

" Comments (gcc), Uncomment (gcu), Toggle visual block (gc)
NeoBundleLazy 'tpope/vim-commentary', {
      \   'autoload' : {'mappings' : ['gc', 'gcc', 'gcu']}
      \ }

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

NeoBundleLazy 'tpope/vim-projectionist', {
      \   'autoload' : { 'explorer' : 1 }
      \ }

NeoBundle 'tpope/vim-repeat'

NeoBundle 'tpope/vim-surround'

NeoBundleLazy 'tpope/vim-scriptease', {
      \   'autoload' : { 'commands' : ['PP', 'Runtime', 'Disarm', 'Verbose'] },
      \ }

" bprevious: [b, bnext: ]b, bfirst: [B
" lprevious: [l, lnext: ]l, lfirst: [L
" cprevious: [q, cnext: ]q, cfirst: [Q
" tprevious: [t, tnext: ]t
NeoBundleLazy 'tpope/vim-unimpaired', {
      \   'autoload' : { 'mappings' : ['[', ']'] }
      \ }

NeoBundleLazy 'tpope/vim-vinegar', {
      \   'depends'  : 'scrooloose/nerdtree',
      \   'autoload' : { 'mappings' : ['-'] }
      \ }
" }}}

" text replacement in quickfix {{{
NeoBundleLazy 'thinca/vim-qfreplace', {
      \   'autoload' : {
      \     'commands'  : ['Qfreplace'],
      \     'filetypes' : ['unite', 'quickfix'],
      \   }
      \ }
" }}}

" vim-expand-region {{{
NeoBundleLazy 'terryma/vim-expand-region', {
      \   'depends'  : ['kana/vim-textobj-user'],
      \   'autoload' : { 'mappings' : ['<Plug>(expand_region_'] }
      \ }
" }}}

" open-browser.vim {{{
NeoBundleLazy 'tyru/open-browser.vim', {
      \   'autoload' : {
      \     'commands' : ['OpenBrowser', 'OpenBrowserSearch', 'OpenBrowserSmartSearch'],
      \     'mappings' : '<Plug>(openbrowser-',
      \   }
      \ }
" }}}

" draw text boxes {{{
NeoBundleLazy 'vim-scripts/DrawIt', {
      \   'autoload' : { 'commands' : ['DIstart', 'DIstop', 'DrawIt'], }
      \ }
" }}}

" targets additional text objects {{{
NeoBundle 'wellle/targets.vim'
" }}}

" indent line indicator {{{
NeoBundle 'Yggdroot/indentLine'
" }}}

" window operations {{{
NeoBundleLazy 't9md/vim-choosewin', {
      \   'autoload' : {
      \     'commands' : ['ChooseWin'],
      \     'mappings' : ['<Plug>(choosewin)'],
      \   }
      \ }
" }}}

" Text Objects {{{
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-line'               " al | il
NeoBundle 'kana/vim-textobj-syntax'             " ay | iy
NeoBundle 'kana/vim-textobj-indent'             " ai | ii
NeoBundle 'kana/vim-textobj-lastpat'            " a/ | i/
NeoBundle 'deris/vim-textobj-enclosedsyntax'    " aq | iq
NeoBundle 'idbrii/textobj-word-column.vim'      " ac | ic
NeoBundle 'Julian/vim-textobj-variable-segment' " av | iv
NeoBundle 'nelstrom/vim-textobj-rubyblock'      " ar | ir
NeoBundle 'osyo-manga/vim-textobj-multiblock'   " ab | ib
NeoBundle 'whatyouhide/vim-textobj-xmlattr'     " ax | ix
" }}}

" Writing {{{
NeoBundleLazy 'junegunn/goyo.vim', {
      \   'autoload' : { 'commands' : ['Goyo'] },
      \ }

NeoBundleLazy 'junegunn/limelight.vim', {
      \   'autoload' : { 'commands' : ['Limelight', 'Limelight!'] },
      \ }
" }}}

" HTML/XML {{{
NeoBundle 'othree/html5.vim'
NeoBundle 'gregsexton/MatchTag'
NeoBundle 'mattn/emmet-vim'
" }}}

" Template Engines {{{
NeoBundleLazy 'digitaltoad/vim-jade'
NeoBundleLazy 'nono/vim-handlebars'
NeoBundleLazy 'slim-template/vim-slim'
NeoBundleLazy 'tpope/vim-haml'
NeoBundleLazy 'tpope/vim-liquid'
" }}}

" CSS {{{
NeoBundle 'ap/vim-css-color'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundleLazy 'cakebaker/scss-syntax.vim', {'autoload': {'filetypes': ['sass', 'scss']}}
NeoBundleLazy 'groenewege/vim-less', {'autoload': {'filetypes': 'less'}}
" }}}

" JSON {{{
NeoBundleLazy 'elzr/vim-json', {'autoload': {'filetypes': 'json'}}
" }}}

" JavaScript {{{
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'othree/yajs.vim'
NeoBundleLazy 'othree/javascript-libraries-syntax.vim', {'autoload': {'filetypes': 'javascript'}}
NeoBundleLazy 'moll/vim-node', {'autoload': {'filetypes': 'javascript'}}
NeoBundle 'mxw/vim-jsx'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundleLazy 'marijnh/tern_for_vim', {
      \   'autoload': { 'filetypes': 'javascript' },
      \   'build': {
      \     'windows': 'npm install',
      \     'cygwin': 'npm install',
      \     'mac': 'npm install',
      \     'unix': 'npm install',
      \   },
      \ }
" }}}

" Ruby/Rails {{{
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'keith/rspec.vim'
NeoBundle 'tpope/vim-rails', {'depends': ['tpope/vim-projectionist']}
NeoBundleLazy 'tpope/vim-endwise', {'autoload': {'filetypes': ['ruby', 'eruby']}}
NeoBundleLazy 'tpope/vim-rbenv', {'autoload': {'filetypes': ['ruby', 'eruby']}}
NeoBundleLazy 'tpope/vim-bundler'
NeoBundleLazy 'tpope/vim-rake'
NeoBundleLazy 'duwanis/tomdoc.vim'
NeoBundleLazy 'stefanoverna/vim-i18n', {'autoload': {'filetypes': ['ruby', 'eruby']}}
NeoBundleLazy 'ecomba/vim-ruby-refactoring', {
      \   'autoload' : {
      \     'commands' : [
      \       'RInlineTemp', 'RConvertPostConditional', 'RExtractConstant',
      \       'RExtractLet', 'RExtractLocalVariable', 'RRenameLocalVariable',
      \       'RRenameInstanceVariable', 'RExtractMethod',
      \     ]
      \   },
      \ }
" }}}

" Clojure {{{
NeoBundleLazy 'guns/vim-clojure-static', {'autoload': {'filetypes': 'clojure'}}
NeoBundleLazy 'guns/vim-clojure-highlight', {'autoload': {'filetypes': 'clojure'}}
NeoBundleLazy 'tpope/vim-classpath', {'autoload': {'filetypes': 'clojure'}}
NeoBundleLazy 'tpope/vim-fireplace', {'autoload': {'filetypes': 'clojure'}}
NeoBundleLazy 'tpope/vim-leiningen', {'autoload': {'filetypes': 'clojure'}}
" }}}

" Elixir {{{
NeoBundle 'elixir-lang/vim-elixir'
" }}}

" C/Cpp {{{
NeoBundleLazy 'vim-jp/cpp-vim', {'autoload': {'filetypes': ['c', 'cpp']}}
NeoBundleLazy 'octol/vim-cpp-enhanced-highlight', {'autoload': {'filetypes': ['c', 'cpp']}}
" }}}

" Go {{{
NeoBundle 'fatih/vim-go'
" }}}

" Markdown {{{
NeoBundle 'gabrielelana/vim-markdown'

" Highlight code in Markdown
NeoBundleLazy 'farseer90718/vim-regionsyntax', {
      \   'autoload': {'filetypes': 'markdown'}
      \ }

" Preview Markdown Result in Browser
NeoBundleLazy 'kannokanno/previm', {
      \   'depends' : ['tyru/open-browser.vim'],
      \   'autoload': {'commands': 'PrevimOpen'}
      \ }
" }}}

" Git {{{
NeoBundle 'tpope/vim-git'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'
NeoBundleLazy 'gregsexton/gitv', {
      \   'depends' : ['tpope/vim-fugitive'],
      \   'autoload': {'commands': 'Gitv'}
      \ }
" }}}

" Others {{{
NeoBundleLazy 'chase/vim-ansible-yaml', {'autoload': {'filetypes': 'ansible'}}
" }}}

" Colorschemes {{{
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'KabbAmine/yowish.vim'
NeoBundle 'morhetz/gruvbox'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'NLKNguyen/papercolor-theme'
NeoBundle 'sjl/badwolf'
NeoBundle 'w0ng/vim-hybrid'
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim:ft=vim:fdm=marker:sw=2:ts=2
