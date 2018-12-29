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

" Mappings
nnoremap <silent> <F3> :NERDTreeToggle<CR>
