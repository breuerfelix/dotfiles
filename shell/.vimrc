"automated installation of vimplug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

call plug#begin('~/.config/nvim/plugged')
"PlugInstall, PlugUpdate, PlugClean,
"PlugUpgrade (upgrade vim plug), PlugStatus

"games
Plug 'ThePrimeagen/vim-be-good', { 'on': 'VimBeGood' }

"git
Plug 'tpope/vim-fugitive'

"syntax
Plug 'dense-analysis/ale'
Plug 'sheerun/vim-polyglot'
Plug 'editorconfig/editorconfig-vim'
"Plug 'rhysd/vim-grammarous'
Plug 'mboughaba/i3config.vim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'wellle/context.vim'

"fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

"autopair
Plug 'jiangmiao/auto-pairs'
Plug 'machakann/vim-sandwich'
Plug 'AndrewRadev/splitjoin.vim'

"commenting
Plug 'preservim/nerdcommenter'

"autocomplete
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'OmniSharp/omnisharp-vim'
Plug 'liuchengxu/vista.vim'
"expands command bar with suggetions
Plug 'gelguy/wilder.nvim'

"files
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-sleuth'

"status bar
Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

"themes
"Plug 'sonph/onehalf', { 'rtp': 'vim/' }
Plug 'joshdick/onedark.vim'
"Plug 'chriskempson/base16-vim'
"Plug 'junegunn/seoul256.vim'
"Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
Plug 'sainnhe/gruvbox-material'
"Plug 'drewtempelmeyer/palenight.vim'
"Plug 'ayu-theme/ayu-vim'
"Plug 'hardcoreplayers/oceanic-material'

"organizing
Plug 'wsdjeg/vim-todo', { 'on': 'OpenTodo' }
Plug 'breuerfelix/vim-todo-lists'
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

"other
Plug 'mattn/emmet-vim'
"Plug 'mg979/vim-visual-multi', { 'branch': 'master' }
Plug 'easymotion/vim-easymotion'
Plug 'rhysd/clever-f.vim'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on': 'Goyo' }

"load as last plugin
Plug 'ryanoasis/vim-devicons'

call plug#end()

"
" NATIVE CONFIG
"

"plugin configurations
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

"mappings
let mapleader = ','
inoremap jk <Esc>
vnoremap <C-j> <Esc>

"trailing
noremap <C-c> <S-j>

"faster scrolling
noremap <S-j> 4jzz
noremap <S-k> 4kzz
"nnoremap <S-j> <C-d>zz
"nnoremap <S-k> <C-u>zz

"buffer
map <C-n> :bnext<CR>
map <C-p> :bprevious<CR>
"map <C-t> :tabnew<CR>


"finder
map ; :Files<CR>
map <C-f> :Rg<CR>
map <C-b> :NERDTreeToggle<CR>

"editing
map <leader>r :s/"/'/g<bar>:noh<CR>
map <leader>q :ALEFix<CR>
map <leader>n :noh<CR>
map <leader>t :OpenTodo<CR>

"inserts blank line below
noremap <C-[> :set paste<CR>o<Esc>:set nopaste<CR>
noremap gl $
noremap gh 0

"save
noremap <silent> <C-i> :w<CR>

"quit
noremap <C-u> :q<CR>
inoremap <C-u> <Esc>:q<CR>

"git
map <leader>ad :Gdiffsplit<CR>
map <leader>ab :Gblame<CR>

"edit files
map <leader>ee :e ~/.vimrc<CR>
map <leader>et :e ~/.tmux.conf<CR>
map <leader>er :e ~/.bashrc<CR>
map <leader>es :e ~/.zshrc<CR>
map <leader>ea :e ~/.config/alacritty/alacritty.yml<CR>
map <leader>ei :e ~/.i3/config<CR>
map <leader>ed :e ~/cloud/default.todo<CR>
map <leader>ef :e ~/cloud/temp.md<CR>

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
autocmd filetype python map <C-m> :below split <bar> :terminal python %<CR>
autocmd filetype javascript,typescript map <C-m> :below split <bar> :terminal node %<CR>

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

set clipboard=unnamedplus

"disable pre rendering of some things like ```
set conceallevel=0

"toggle invisible characters
set list
set listchars=tab:→\ ,eol:¬,trail:~,extends:❯,precedes:❮,space:␣
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

augroup save_when_leave
    au BufLeave * silent! wall
augroup END

set hidden
set nobackup
set nowritebackup
set noswapfile
set noshowmode

"
" PLUGIN CONFIG
"

"needs manual activation with <C-e>
let g:firenvim_config = {
\  'localSettings': {
\    '.*': {
\      'takeover': 'never',
\      'priority': 1,
\    },
\  },
\}


let g:spacevim_todo_labels = [
\  'FIXME',
\  'TODO',
\]

nmap m <Plug>(easymotion-prefix)

" fuzzy finder for wilder menu
call wilder#set_option('pipeline', [
\  wilder#branch(
\    wilder#cmdline_pipeline({
\      'fuzzy': 1,
\      'use_python': 1,
\    }),
\    wilder#python_search_pipeline({
\      'regex': 'fuzzy',
\      'engine': 're',
\      'sort': function('wilder#python_sort_difflib'),
\    }),
\  ),
\])

"command completion
call wilder#enable_cmdline_enter()
set wildcharm=<Tab>
cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"

" only / and ? is enabled by default
call wilder#set_option('modes', ['/', '?', ':'])

"improve writing
function! s:goyo_enter()
  set nolist
  Limelight
endfunction

function! s:goyo_leave()
  set list
  Limelight!
endfunction

noremap <silent> <leader>w :Goyo<CR>
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

noremap <C-t> :Vista!!<CR>

"removes flickering in neovim for context plugin
let g:context_nvim_no_redraw = 1

let g:tex_flavor = 'latex'
let g:vimtex_compiler_method = 'tectonic'
nmap <leader>v <Plug>(vimtex-compile)

lua require'colorizer'.setup()

let g:EditorConfig_exclude_patterns = ['fugitive://.*']

let g:OmniSharp_server_stdio = 1
let g:OmniSharp_highlighting = 2

"mono only for unity projects
"let g:OmniSharp_server_use_mono = 1
"let g:OmniSharp_start_without_solution = 1

let g:OmniSharp_highlight_groups = {
\  'LocalName': 'Text',
\  'FieldName': 'Text',
\  'ParameterName': 'Text',
\}

"linter
let g:ale_completion_enabled = 0
let g:ale_fix_on_save = 0

let g:ale_fixers = {
\  '*': [ 'remove_trailing_lines', 'trim_whitespace' ],
\  'javascript': [ 'eslint' ],
\  'python': [ 'black' ],
\  'rust': [ 'rustfmt' ],
\}

let g:ale_linters = {
\  'cs': [ 'OmniSharp' ],
\}

"use single quotes in emmet
let g:user_emmet_settings = { 'html': { 'quote_char': "'", }, }
let g:user_emmet_leader_key = '<C-d>'

"completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

set cmdheight=1
"turn off completion menu messages
set shortmess+=c
set signcolumn=yes

let g:coc_global_extensions = [
\  'coc-git',
\  'coc-json',
\  'coc-tsserver',
\  'coc-jest',
\  'coc-python',
\  'coc-rls',
\  'coc-go',
\  'coc-svelte',
\  'coc-vimtex',
\]

inoremap <silent><expr> <C-space> coc#refresh()

"jump back to and forth
noremap <space>o <C-o>zz
noremap <space>i <C-i>zz

"GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)zz
nmap <silent> gt <Plug>(coc-type-definition)zz
nmap <silent> gi <Plug>(coc-implementation)zz
nmap <silent> gr <Plug>(coc-references)zz

noremap <silent> <leader>d :call <SID>show_documentation()<CR>

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
noremap <silent> <space>d :<C-u>CocList diagnostics<cr>
"manage extensions.
noremap <silent> <space>e :<C-u>CocList extensions<cr>

"
" THEMING
"

"disable all extensions for a minimal setup
let g:airline_extensions = ['tabline']
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

set background=dark

"let g:onedark_terminal_italics = 1
"let g:palenight_terminal_italics = 1

"let g:gruvbox_contrast_light='soft'
"let g:gruvbox_contrast_dark='soft'
"colorscheme gruvbox

let g:gruvbox_material_enable_bold = 1
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_transparent_background = 0
colorscheme gruvbox-material

"override colorscheme

"enable transparent background
"highlight Normal ctermbg=NONE guibg=NONE

"whitespace rendering
highlight NonText guifg=grey22
highlight Whitespace guifg=grey22
highlight SpecialKey guifg=grey22

"highlight only one character when line too long
highlight ColorColumn ctermbg=grey guibg=grey25
call matchadd('ColorColumn', '\%88v', 100)

"
" OVERRIDING DIFFERENT ENVIRONMENTS
"

if exists('g:started_by_firenvim')
  let g:loaded_airline = 1
  set laststatus=0
  set nolist
  set nonumber
  set norelativenumber
  set signcolumn=no
  colorscheme onedark
  startinsert
endif
