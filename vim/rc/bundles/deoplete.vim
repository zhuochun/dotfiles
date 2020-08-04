" <TAB> completion
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ deoplete#manual_complete()
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~ '\s'
endfunction
" <S-TAB> completion backward
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" <BS> close popup and delete backword char
inoremap <expr><BS> pumvisible() ?
    \ deoplete#smart_close_popup()."\<C-h>" :
    \ AutoPairsDelete()
" <Space> close popup
inoremap <expr><Space> pumvisible() ?
    \ deoplete#close_popup()."\<Space>" : "\<Space>"
" <CR> close popup and save indent
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
    return deoplete#cancel_popup() . "\<CR>"
endfunction

" <C-g> Undo completion
inoremap <expr><C-g> deoplete#undo_completion()
" <C-l>: redraw candidates
inoremap <expr><C-l> deoplete#refresh()

" Use partial fuzzy matches like YouCompleteMe
call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])

" Use vim-go for omni-completion
call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })
