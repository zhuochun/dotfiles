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
        \ 'sorters', ['sorter_rank'])

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
        \ 'matchers', [
        \   'converter_relative_word', 'matcher_fuzzy',
        \   'matcher_hide_hidden_files', 'matcher_hide_current_file',
        \ ])

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
        \ '--ignore ''.git'' --ignore ''.hg'' --ignore ''vendor'' ' .
        \ '--ignore ''.idea'' --ignore ''node_modules'''
    let g:unite_source_grep_recursive_opt = ''
endif

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
endfunction " }}
