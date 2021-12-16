"
" NATIVE CONFIG
"

"mappings
let mapleader = ' '
inoremap jk <Esc>
vnoremap u <Esc>
imap <C-j> <C-n>
imap <C-k> <C-p>

"trailing
noremap <C-c> <S-j>

"faster scrolling
noremap <S-j> 3jzz
noremap <S-k> 3kzz
"nmap <C-d> <C-d>
"nmap <C-f> <C-u>

"buffer
nmap <C-n> :bnext<CR>
nmap <C-p> :bprevious<CR>
"nmap <C-y> :bdelete<CR>
nmap <C-y> :BD<CR>
"map <C-t> :tabnew<CR>

"finder
nmap ; :FzfLua files<CR>

"inserts blank line below
noremap <C-[> :set paste<CR>o<Esc>:set nopaste<CR>
noremap gl $
noremap gh 0

"save
noremap <silent> <C-i> :w<CR>
"sudo tee hack, write as root
cmap w!! w !sudo tee > /dev/null %

"save undo / redo across sessions
set undofile
set undodir=~/.vim/undo

"quit
nmap <C-u> :q<CR>
imap <C-u> <Esc>:q<CR>

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

noremap <silent> <C-h> :call WinMove('h')<CR>
noremap <silent> <C-j> :call WinMove('j')<CR>
noremap <silent> <C-k> :call WinMove('k')<CR>
noremap <silent> <C-l> :call WinMove('l')<CR>

"terminal
tnoremap jk <C-\><C-n>
tnoremap <C-u> <C-\><C-n>:q<CR>

"run current buffer
autocmd filetype python nnoremap <leader>er :VimuxRunCommand("python %")<CR>
autocmd filetype javascript,typescript nnoremap <leader>er :VimuxRunCommand("node %")<CR>
autocmd filetype go noremap <leader>er :VimuxRunCommand("go run .")<CR>

"formatter
"autocmd filetype python noremap <leader>f :silent execute \"!black -q %\" | edit!<CR>

"true colors
set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

"vim update delay in ms
set updatetime=300

"disable mouse
set mouse=

"syntax
syntax enable
set number
set relativenumber
set autoread
set encoding=UTF-8
"set foldmethod=syntax

set clipboard=unnamedplus

"disable pre rendering of some things like ```
set conceallevel=0

"toggle invisible characters
set list
set listchars=tab:→\ ,eol:¬,trail:~,extends:❯,precedes:❮,space:␣
"set listchars=eol:¬,trail:~,extends:❯,precedes:❮
set showbreak=↪

"default for vim sleuth
set expandtab
set tabstop=2
set shiftwidth=2

"split
set splitbelow
set splitright

"in house fuzzy finder
set path+=**
set wildmenu

"searching
set ignorecase
set smartcase

set cursorline
set laststatus=2
set scrolloff=8
set startofline

augroup save_when_leave
    au BufLeave * silent! wall
augroup END

set hidden
set nobackup
set nowritebackup
set noswapfile
set noshowmode
"automatically source .vimrc from project folder
set exrc
set secure

"jump back to and forth
noremap <leader>o <C-o>zz
noremap <leader>i <C-i>zz

"filetypes
au BufRead,BufNewFile *.nix set filetype=nix

set background=dark
"let g:tokyonight_style = "night"
colorscheme tokyonight

"
" THEMING
"

"override colorscheme
"enable transparent background
"highlight Normal ctermbg=NONE guibg=NONE

"render whitespace softer than comments
highlight NonText guifg=grey22
highlight Whitespace guifg=grey22
highlight SpecialKey guifg=grey22
"TODO choose a good color for comments
highlight Comment guifg=grey

"highlight only one character when line too long
highlight ColorColumn ctermbg=grey guibg=grey25
call matchadd('ColorColumn', '\%88v', 100)
