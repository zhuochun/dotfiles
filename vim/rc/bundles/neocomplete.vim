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

" <TAB> completion
inoremap <expr><TAB> pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ neocomplete#start_manual_complete()
function! s:check_back_space() abort
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
" <CR> close popup and save indent
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction

" <C-g> Undo completion
inoremap <expr><C-g> pumvisible() ? neocomplete#undo_completion() : "<ESC>"
inoremap <expr><C-l> neocomplete#complete_common_string()
