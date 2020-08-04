" Python configuration
"
" Refer to help provider-python
" Refer to https://github.com/deoplete-plugins/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
"
" Create a separate virtualenv: python3 -m venv ~/vim-py
"

" Disable Python 2 support:
let g:loaded_python_provider = 0

" Set Python Host in a dedicated env
let g:python3_host_prog = expand('~/vim-py/bin/python')
