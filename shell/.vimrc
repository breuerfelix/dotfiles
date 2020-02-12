"plugins
call plug#begin('~/.config/nvim/plugged')
"PlugInstall, PlugUpdate, PlugClean, PlugUpgrade (upgrade vim plug),
"PlugStatus

"git
Plug 'tpope/vim-fugitive'

"linting
Plug 'dense-analysis/ale'
Plug 'sheerun/vim-polyglot'

"fuzzy finder
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"autopair
Plug 'jiangmiao/auto-pairs'

"autocomplete
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all --clangd-completer' }
"Plug 'zxqfl/tabnine-vim'

"files
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-sleuth'

"status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"themes
Plug 'joshdick/onedark.vim'
Plug 'chriskempson/base16-vim'
Plug 'junegunn/seoul256.vim'
Plug 'sonph/onehalf', { 'rtp': 'vim/' }
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'

"writing
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'

"emmet
Plug 'mattn/emmet-vim'

call plug#end()

"make tsserver works for typescriptreact
autocmd BufEnter *.tsx set filetype=typescript

source /usr/share/doc/fzf/examples/fzf.vim

"plugin configurations
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

let g:ycm_autoclose_preview_window_after_insertion = 1

"prettier
let g:ale_completion_enabled = 0
let g:ale_fixers = [ 'eslint', 'prettier' ]
let g:ale_fix_on_save = 1

let g:ale_fixers = {
\	'*': [ 'remove_trailing_lines', 'trim_whitespace' ],
\	'javascript': [ 'eslint', 'prettier' ],
\	'python': [ 'black' ],
\	'rust': [ 'rustfmt' ],
\}

"emmet uses single quotes
let g:user_emmet_settings = { 'html': { 'quote_char': "'", }, }

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

map <C-n> zz

"finder
map ; :Files<CR>
map <C-b> :NERDTreeToggle<CR>

"editing
map <leader>r :s/"/'/g<bar>:noh<CR>

"save
map <C-i> :w<CR>
imap <C-i> <Esc>:w<CR>i

"quit
map <C-u> :q<CR>
imap <C-u> <Esc>:q<CR>

"edit files
map <leader>ee :e ~/.vimrc<CR>
map <leader>et :e ~/.tmux.conf<CR>
map <leader>er :e ~/.bashrc<CR>
map <leader>es :e ~/.zshrc<CR>
map <leader>ea :e ~/.config/alacritty/alacritty.yml<CR>

"completer
map <leader>f :YcmCompleter GoTo<CR>
map <leader>g <C-o>

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
map <C-e> :below 10 split <bar> :terminal<CR>i npm start<CR>

"wrtiing
map <leader>w :Goyo<CR>
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

"disable mouse
set mouse=

"syntax
syntax enable
set number relativenumber
"set ttyfast
set autoread

set clipboard=unnamedplus

"toggle invisible characters
set list
set listchars=tab:→\ ,eol:¬,trail:~,extends:❯,precedes:❮,space:␣
set showbreak=↪

"indent
"disabled because of plugin sleuth
"filetype plugin indent on
set tabstop=4
"set shiftwidth=2
"set softtabstop=2
"set smartindent

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
"set lazyredraw
"set noshowcmd
"set noruler
"set nocompatible

set cursorline

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

let g:user_emmet_leader_key = '<C-d>'
let g:airline_powerline_fonts = 1

"let g:gruvbox_contrast_dark = 'hard'
"let g:airline_theme = 'onehalfdark'
"let g:onedark_terminal_italics = 1

colorscheme onehalfdark

"override colorscheme

"for onehalfdark
highlight NonText ctermfg=grey guifg=grey25
highlight Comment ctermfg=grey guifg=grey50
