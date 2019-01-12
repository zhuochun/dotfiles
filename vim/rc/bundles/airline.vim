" use plain ascii symbols,
let g:airline_symbols_ascii = 1
" cache highlighting groups
let g:airline_highlighting_cache = 1
" clear default separator symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
" exclude preview window statusline
let g:airline_exclude_preview = 1
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

" modify airline symbols
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" modify/clear symbols
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''

" disable some plugin integrations
let g:airline#extensions#tagbar#enabled = 0
" disable summary of changed hunks under source control (gitgutter)
let g:airline#extensions#hunks#enabled = 0
" disable word count
let g:airline#extensions#wordcount#enabled = 0

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
