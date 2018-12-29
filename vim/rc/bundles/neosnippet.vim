" Default expand with word boundary
let g:neosnippet#expand_word_boundary = 1
" Disables standart snippets, use vim-snippets bundle instead
let g:neosnippet#disable_runtime_snippets = { '_' : 1 }
" Enable SnipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
" Enable complete func type
let g:neosnippet#enable_completed_snippet = 1
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory = g:dotvim_bundles . '/repos/github.com/zhuochun/vim-snippets/snippets'

" Snippet variables
let g:snips_author = 'Wang Zhuochun'
let g:snips_email  = 'zhuochun@hotmail.com'
let g:snips_github = 'https://github.com/zhuochun'

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
