"plugins
call plug#begin('~/.config/nvim/plugged')
"PlugInstall, PlugUpdate, PlugClean, PlugUpgrade (upgrade vim plug),
"PlugStatus

"git
Plug 'tpope/vim-fugitive'

"linting
Plug 'w0rp/ale'
Plug 'leafgarland/typescript-vim'

"fuzzy finder
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

"autopair
Plug 'jiangmiao/auto-pairs'

"autocomplete
"Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all' }
"Plug 'zxqfl/tabnine-vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

"files
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'ciaranm/detectindent'

Plug 'itchyny/lightline.vim'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

"language pack
Plug 'sheerun/vim-polyglot'

"themes
Plug 'joshdick/onedark.vim'
Plug 'chriskempson/base16-vim'
Plug 'junegunn/seoul256.vim'

"writing
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'

"emmet
Plug 'mattn/emmet-vim'

call plug#end()

"plugin configurations
"let g:python3_host_prog = '/usr/bin/python'
"let g:loaded_python3_provider = 0
let g:jedi#force_py_version = 3

let g:deoplete#enable_at_startup = 1

let g:airline_powerline_fonts = 1

let g:ycm_autoclose_preview_window_after_insertion = 1

"prettier
let g:ale_completion_enabled = 0
let g:ale_fixers = [ 'eslint', 'prettier' ]
let g:ale_fix_on_save = 0

let g:ale_linters = {
			\ 'javascript': [ 'eslint', 'prettier' ],
			\ 'python': [ 'vulture' ]
			\ }

"emmet uses single quotes
let g:user_emmet_settings = {'html':{'quote_char': "'",},}

"disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

"mappings
let mapleader = ','
imap jk <Esc>
vmap <C-j> <Esc>

"faster scrolling
map <S-j> 3j
map <S-k> 3k

"finder
map ; :Files<CR>
map <C-b> :NERDTreeToggle<CR>

"editing
map <leader>r :s/"/'/g<bar>:noh<CR>

"save and quit
map <C-i> :w<CR>
imap <C-i> <Esc>:w<CR>i
imap <C-u> <Esc>:q!<CR>
map <C-u> :q<CR>

"edit files
map <leader>ee :e ~/.vimrc<CR>
map <leader>et :e ~/.tmux.conf<CR>
map <leader>er :e ~/.bashrc<CR>
map <leader>ea :e ~/.config/alacritty/alacritty.yml<CR>
map <leader>e3 :e ~/.i3/config<CR>

"splits
function! WinMove(key)
	let t:curwin = winnr()
	exec "wincmd ".a:key
	if (t:curwin == winnr())
		if (match(a:key,'[jk]'))
			wincmd v
		else
			wincmd s
		endif
		exec "wincmd ".a:key
	endif
endfunction

nnoremap <silent> <C-h> :call WinMove('h')<CR>
nnoremap <silent> <C-j> :call WinMove('j')<CR>
nnoremap <silent> <C-k> :call WinMove('k')<CR>
nnoremap <silent> <C-l> :call WinMove('l')<CR>

"autocomplete
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"terminal
tnoremap jk <C-\><C-n>
tnoremap <C-u> <C-\><C-n>:q<CR>
map <C-m> :below 10 split <bar> :terminal<CR>i
map <C-e> :below 10 split <bar> :terminal<CR>i npm start <CR>

"wrtiing
map <leader>w :Goyo<CR>
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

if has('mouse')
	set mouse=a
endif

"disable mouse
set mouse=

"syntax
syntax enable
set number relativenumber
set ttyfast
set autoread

set clipboard=unnamed

"toggle invisible characters
set list
set listchars=tab:→\ ,eol:¬,trail:~,extends:❯,precedes:❮,space:␣
set showbreak=↪

"indent
filetype plugin indent on
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smartindent
"auto detect indention
autocmd BufReadPost * :DetectIndent

"split
set splitbelow
set splitright

"in house fuzzy finder
set path+=**
set wildmenu

"searching
set ignorecase
set smartcase

"performance
set lazyredraw
set noshowcmd
set noruler
set nocompatible

set cursorline
set synmaxcol=128
syntax sync minlines=256	

augroup save_when_leave
	au BufLeave * silent! wall
augroup END

set hidden
set nobackup
set noswapfile

"set true colors
if (has('nvim'))
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has('termguicolors'))
	set termguicolors
endif

let g:lightline = {
			\ 'colorscheme': 'onedark',
			\ }

let g:user_emmet_leader_key='<C-d>'
let g:onedark_terminal_italics=1
set background=dark
colorscheme onedark
