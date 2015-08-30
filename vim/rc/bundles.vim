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

" buffers {{{
NeoBundleLazy 'qpkorr/vim-bufkill'

NeoBundleLazy 'schickling/vim-bufonly', {
      \   'autoload' : { 'commands' : ['BufOnly', 'BOnly'] },
      \ }
" }}}

" NrrwRgn {{{
NeoBundleLazy 'chrisbra/NrrwRgn', {
      \   'autoload' : {
      \     'commands' : ['NarrowRegion', 'NRPrepare', 'NRMulti'],
      \   },
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
      \     'mappings' : ['<Plug>', ','],
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

" display markers {{{
NeoBundleLazy 'jeetsukumaran/vim-markology', {
      \   'autoload' : { 'mappings' : ['m'] },
      \ }
" }}}

" open documentation {{{
NeoBundleLazy 'keith/investigate.vim', {
      \   'autoload' : { 'mappings' : ['gK'] },
      \ }
" }}}

" multiple cursors {{{
NeoBundleLazy 'terryma/vim-multiple-cursors', {
      \   'autoload' : { 'mappings' : ['<Plug>'] }
      \ }
" }}}

" easymotion {{{
NeoBundleLazy 'Lokaltog/vim-easymotion', {
      \   'autoload' : { 'mappings' : ['<Plug>(easymotion-'] },
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

" Unite {{
NeoBundle 'Shougo/unite.vim'

NeoBundle 'Shougo/neomru.vim', {
      \   'depends' : ['Shougo/unite.vim'],
      \   'autoload': {'unite_sources': ['neomru/file', 'neomru/directory']}
      \ }

NeoBundle 'Shougo/unite-outline', {
      \   'depends' : ['Shougo/unite.vim'],
      \   'autoload': {'unite_sources': 'outline'}
      \ }

NeoBundle 'Shougo/junkfile.vim', {
      \   'depends' : ['Shougo/unite.vim'],
      \   'autoload': {'unite_sources' : ['junkfile', 'junkfile/new']}
      \ }

NeoBundle 'kopischke/unite-spell-suggest', {
      \   'depends' : ['Shougo/unite.vim'],
      \   'autoload': {'unite_sources': 'spell_suggest'}
      \ }

NeoBundle 'ujihisa/unite-colorscheme', {
      \   'depends' : ['Shougo/unite.vim'],
      \   'autoload': {'unite_sources': 'colorscheme'}
      \ }

NeoBundle 'osyo-manga/unite-quickfix', {
      \   'depends' : ['Shougo/unite.vim'],
      \   'autoload': {'unite_sources': ['quickfix', 'location_list']}
      \ }

NeoBundle 'tsukkee/unite-tag', {
      \   'depends' : ['Shougo/unite.vim'],
      \   'autoload': {'unite_sources': 'tag'}
      \ }

NeoBundle 'LeafCage/yankround.vim', {
      \   'depends': ['Shougo/unite.vim'],
      \   'autoload': {'unite_sources': 'yankround'}
      \ }
" }}

" VimShell {{
NeoBundleLazy 'Shougo/vimshell.vim', {
      \   'depends' : 'Shougo/vimproc',
      \   'autoload' : {
      \     'commands' : ['VimShellPop', 'VimShellTab'],
      \     'mappings' : ['<Plug>(vimshell_'],
      \   },
      \ }
" }}

" NeoComplete {{
NeoBundle 'Shougo/neocomplete.vim'

" Complete words in English
NeoBundle 'ujihisa/neco-look', {
      \   'depends'  : ['Shougo/neocomplete.vim'],
      \   'autoload' : {'insert': 1}
      \ }

" Complete with syntax source
NeoBundle 'Shougo/neco-syntax', {
      \   'depends'  : ['Shougo/neocomplete.vim'],
      \   'autoload' : {'insert': 1}
      \ }

" Complete vimscript
NeoBundle 'Shougo/neco-vim', {
      \   'depends'  : ['Shougo/neocomplete.vim'],
      \   'autoload' : {'filetypes': 'vim'}
      \ }

" Complete Ruby with RSense
NeoBundle 'supermomonga/neocomplete-rsense.vim', {
      \   'depends'  : ['Shougo/neocomplete.vim'],
      \   'autoload' : {'filetypes': 'ruby'}
      \ }

" Complete Ruby with rcodetools
" NeoBundle 'osyo-manga/vim-monster', {
"       \   'depends'  : ['Shougo/vimproc', 'Shougo/neocomplete.vim'],
"       \   'autoload' : {'filetypes': 'ruby'}
"       \ }
" }}

" NeoSnippet {{
NeoBundle 'Shougo/neosnippet.vim', {
      \   'depends'  : ['Shougo/context_filetype.vim'],
      \   'autoload' : {'insert': 1}
      \ }

NeoBundleLazy 'zhuochun/vim-snippets'
NeoBundleLazy 'zhuochun/vim-dicts'
" }}
" }}}

" accelerated-jk {{{
NeoBundle 'rhysd/accelerated-jk', {
      \   'autoload' : { 'mappings' : ['<Plug>(accelerated_'] }
      \ }
" }}}

" improve blockwise visual mode {{{
NeoBundle 'kana/vim-niceblock'
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

NeoBundle 'tpope/vim-projectionist'

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
      \   'autoload' : {'mappings' : ['[', ']']}
      \ }

NeoBundleLazy 'tpope/vim-vinegar', {
      \   'depends'  : 'scrooloose/nerdtree',
      \   'autoload' : {'mappings' : ['-']}
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
      \   'autoload' : {'mappings' : ['<Plug>(expand_region']}
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
NeoBundle 'kana/vim-textobj-entire'             " ae | ie
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
" }}}

" JavaScript {{{
NeoBundle 'elzr/vim-json'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'moll/vim-node'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'mxw/vim-jsx'
NeoBundle 'othree/yajs.vim'
NeoBundle 'othree/javascript-libraries-syntax.vim'
NeoBundle 'marijnh/tern_for_vim', {
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
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-endwise'
NeoBundleLazy 'tpope/vim-rbenv'
NeoBundleLazy 'tpope/vim-bundler'
NeoBundleLazy 'tpope/vim-rake'
NeoBundleLazy 'tpope/vim-liquid'
NeoBundle 'keith/rspec.vim'
NeoBundleLazy 'ecomba/vim-ruby-refactoring', {
      \   'autoload' : {
      \     'commands' : [
      \       'RInlineTemp', 'RConvertPostConditional', 'RExtractConstant',
      \       'RExtractLet', 'RExtractLocalVariable', 'RRenameLocalVariable',
      \       'RRenameInstanceVariable', 'RExtractMethod',
      \     ]
      \   },
      \ }
NeoBundleLazy 'duwanis/tomdoc.vim'
" }}}

" Clojure {{{
NeoBundle 'guns/vim-clojure-highlight'
NeoBundle 'guns/vim-clojure-static'
NeoBundle 'tpope/vim-classpath'
NeoBundle 'tpope/vim-fireplace'
NeoBundle 'tpope/vim-leiningen'
" }}}

" C/Cpp {{{
NeoBundle 'vim-jp/cpp-vim'
NeoBundle 'octol/vim-cpp-enhanced-highlight'
" }}}

" Go {{{
NeoBundle 'fatih/vim-go'
" }}}

" Markdown {{{
NeoBundle 'gabrielelana/vim-markdown'
NeoBundle 'farseer90718/vim-regionsyntax', {
      \   'autoload': {'filetypes': 'markdown'}
      \ }
NeoBundle 'kannokanno/previm', {
      \   'depends' : ['tyru/open-browser.vim'],
      \   'autoload': {'commands': 'PrevimOpen'}
      \ }
" }}}

" Git {{{
NeoBundle 'tpope/vim-git'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'mhinz/vim-signify'
NeoBundle 'chrisbra/vim-diff-enhanced'
NeoBundle 'gregsexton/gitv', {
      \   'depends' : ['tpope/vim-fugitive'],
      \   'autoload': {'commands': 'Gitv'}
      \ }
" }}}

" Others {{{
NeoBundle 'chase/vim-ansible-yaml'
" }}}

" Colorschemes {{{
NeoBundle 'ajh17/Spacegray.vim'
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'morhetz/gruvbox'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'NLKNguyen/papercolor-theme'
NeoBundle 'sjl/badwolf'
NeoBundle 'w0ng/vim-hybrid'
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim:ft=vim:fdm=marker:sw=2:ts=2
