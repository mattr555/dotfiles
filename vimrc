"vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'gmarik/vundle'
Plugin 'jplaut/vim-arduino-ino'
Plugin 'tpope/vim-fugitive'
Plugin 'garbas/vim-snipmate'
Plugin 'tpope/vim-vinegar'
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'
Plugin 'mattr555/vim-instacode'
Plugin 'Shougo/unite.vim'
Plugin 'marcweber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'freitass/todo.txt-vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'Townk/vim-autoclose'
Plugin 'dockyard/vim-easydir'
Plugin 'jaxbot/github-issues.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'Arduino-syntax-file'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'TwitVim'

set nu
syntax on
filetype on
filetype plugin indent on

colorscheme molokai

autocmd BufRead,BufNewFile *.tpp set filetype=tpp
autocmd BufRead,BufNewFile *.ino set filetype=arduino
autocmd BufRead,BufNewFile *.pde set filetype=arduino

set wildmode=longest,list,full
set wildmenu

"powerline
set rtp+=/home/matt/.local/lib/python2.7/site-packages/powerline/bindings/vim
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
set laststatus=2
set noshowmode
"update powerline quicker when leaving insert mode
if ! has('gui_running')
	set ttimeoutlen=10
	augroup FastEscape
			autocmd!
			au InsertEnter * set timeoutlen=0
			au InsertLeave * set timeoutlen=1000
	augroup END
endif

"window movement
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

"arduino
let g:vim_arduino_library_path = "/usr/share/arduino"
let g:vim_arduino_serial_port = "/dev/ttyACM0"

"fold html tag
nnoremap <leader>ft Vatzf

"brace expansion
inoremap {<CR> {<CR>}<Esc>O

"unite
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <C-p> :Unite file_rec/async<cr>
nnoremap <leader>b :Unite buffer<cr>

source ~/.vimrc-private
let g:github_upstream_issues = 1

let twitvim_enable_python = 1
