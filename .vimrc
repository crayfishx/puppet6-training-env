call plug#begin('~/.vim/plugged')
 Plug 'junegunn/vim-easy-align'
call plug#end()

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

execute pathogen#infect()
set tabstop=2 shiftwidth=2 expandtab
syntax on

filetype plugin indent on
