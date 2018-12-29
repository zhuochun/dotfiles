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
" call unite#custom#source(
"       \ 'buffer,file,directory,file_rec,file_rec/async,file_rec/git',
"       \ 'sorters', ['sorter_rank'])

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
nnoremap <silent> goC :<C-u>Unite -buffer-name=colorscheme font -auto-preview<CR>
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
