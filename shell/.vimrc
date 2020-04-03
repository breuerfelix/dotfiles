"automated installation of vimplug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

call plug#begin('~/.config/nvim/plugged')
"PlugInstall, PlugUpdate, PlugClean,
"PlugUpgrade (upgrade vim plug), PlugStatus

"git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

"linting
Plug 'dense-analysis/ale'
Plug 'sheerun/vim-polyglot'
Plug 'editorconfig/editorconfig-vim'
Plug 'rhysd/vim-grammarous'
Plug 'mboughaba/i3config.vim'

"fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"autopair
Plug 'jiangmiao/auto-pairs'
Plug 'machakann/vim-sandwich'

"commenting
Plug 'preservim/nerdcommenter'

"autocomplete
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

"files
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-sleuth'

"status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"themes
Plug 'sonph/onehalf', { 'rtp': 'vim/' }
"Plug 'joshdick/onedark.vim'
"Plug 'chriskempson/base16-vim'
"Plug 'junegunn/seoul256.vim'
"Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
Plug 'sainnhe/gruvbox-material'

"emmet
Plug 'mattn/emmet-vim'

call plug#end()

"plugin configurations
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

let g:EditorConfig_exclude_patterns = ['fugitive://.*']

"linter
let g:ale_completion_enabled = 0
let g:ale_fix_on_save = 0

let g:ale_fixers = {
\    '*': [ 'remove_trailing_lines', 'trim_whitespace' ],
\    'javascript': [ 'eslint' ],
\    'python': [ 'black' ],
\    'rust': [ 'rustfmt' ],
\}

"emmet uses single quotes
let g:user_emmet_settings = { 'html': { 'quote_char': "'", }, }

"mappings
let mapleader = ','
imap jk <Esc>
vmap <C-j> <Esc>

"faster scrolling
map <S-j> 4jzz
map <S-k> 4kzz
"nnoremap <S-j> <C-d>
"nnoremap <S-k> <C-u>

"tabs
map <C-n> :tabn<CR>
map <C-p> :tabp<CR>
map <C-t> :tabnew<CR>

"finder
map ; :Files<CR>
map <C-b> :NERDTreeToggle<CR>

"editing
map <leader>r :s/"/'/g<bar>:noh<CR>
map <leader>q :ALEFix<CR>
map <leader>n :noh<CR>

"save
map <C-i> :w<CR>
imap <C-i> <Esc>:w<CR>i

"quit
map <C-u> :q<CR>
imap <C-u> <Esc>:q<CR>

"git
map <leader>ad :Gdiffsplit<CR>
map <leader>ab :Gblame<CR>

"edit files
map <leader>ee :e ~/.vimrc<CR>
map <leader>et :e ~/.tmux.conf<CR>
map <leader>er :e ~/.bashrc<CR>
map <leader>es :e ~/.zshrc<CR>
map <leader>ea :e ~/.config/alacritty/alacritty.yml<CR>

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

"terminal
tnoremap jk <C-\><C-n>
tnoremap <C-u> <C-\><C-n>:q<CR>
autocmd filetype python map <C-m> :below split <bar> :terminal python %<CR>
autocmd filetype javascript,typescript map <C-m> :below split <bar> :terminal npm run dev<CR>

"vim update delay in ms
set updatetime=300

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
"set tabstop=4
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
set nowritebackup
set noswapfile

"completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

set cmdheight=2
set shortmess+=c
set signcolumn=yes

inoremap <silent><expr> <C-space> coc#refresh()

"GoTo code navigation
nmap <leader>g <C-o>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> <leader>d :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

"highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>rn <Plug>(coc-rename)

xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

"remap keys for applying codeAction to the current line.
nmap <leader>ac <Plug>(coc-codeaction)
"apply AutoFix to problem on the current line.
nmap <leader>qf <Plug>(coc-fix-current)

"Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

"show all diagnostics.
nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>
"manage extensions.
nnoremap <silent> <space>e :<C-u>CocList extensions<cr>

"set true colors
if (has('nvim'))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has('termguicolors'))
    set termguicolors
endif

let g:user_emmet_leader_key = '<C-d>'
let g:airline_powerline_fonts = 1

"let g:airline_theme = 'onehalfdark'
"let g:onedark_terminal_italics = 1
"let g:gruvbox_contrast_light='soft'
"let g:gruvbox_contrast_dark='soft'
set background=dark
let g:airline_theme = 'gruvbox_material'
colorscheme gruvbox-material

"override colorscheme

"changes for onehalfdark
highlight NonText ctermfg=grey guifg=grey25
highlight Comment ctermfg=grey guifg=grey50

"enable transparent background
"hi Normal guibg=NONE ctermbg=NONE
