set number
set relativenumber
set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4
set autoindent
nnoremap <\> :noh <Return>
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
map <C-n> :NERDTreeToggle<CR>

call plug#begin()

Plug 'preservim/nerdtree'
Plug 'mhinz/vim-startify'
Plug 'ap/vim-css-color'
Plug 'itchyny/lightline.vim'

call plug#end()

set t_Co=256
