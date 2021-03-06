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
Plug 'rhysd/vim-grammarous'
Plug 'mboughaba/i3config.vim'
"displays css colors in vim
Plug 'norcalli/nvim-colorizer.lua'
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'wellle/context.vim'
"highlights same keywords
Plug 'RRethy/vim-illuminate'
"renders leading whitespace as red
Plug 'ntpeters/vim-better-whitespace'

"fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release', 'do': ':UpdateRemotePlugins' }

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
Plug 'sainnhe/gruvbox-material'
"Plug 'gruvbox-community/gruvbox'
"Plug 'drewtempelmeyer/palenight.vim'
"Plug 'ayu-theme/ayu-vim'
"Plug 'hardcoreplayers/oceanic-material'
"Plug 'arzg/vim-colors-xcode'

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
Plug 'dstein64/vim-startuptime', { 'on': 'StartupTime' }

"load as last plugin
Plug 'ryanoasis/vim-devicons'

call plug#end()

"
" NATIVE CONFIG
"

let g:which_key_map = {}
autocmd! User vim-which-key call which_key#register('<Space>', 'g:which_key_map')

"plugin configurations
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

"mappings
let mapleader = ' '
inoremap jk <Esc>
vnoremap u <Esc>

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
map <leader>b :NERDTreeToggle<CR>

"inserts blank line below
noremap <C-[> :set paste<CR>o<Esc>:set nopaste<CR>
noremap gl $
noremap gh 0

"save
noremap <silent> <C-i> :w<CR>

"quit
noremap <C-u> :q<CR>
inoremap <C-u> <Esc>:q<CR>

"edit files
map <leader>ee :e ~/.vimrc<CR>
map <leader>et :e ~/.tmux.conf<CR>
map <leader>er :e ~/.bashrc<CR>
map <leader>es :e ~/.zshrc<CR>
map <leader>ea :e ~/.config/alacritty/alacritty.yml<CR>
map <leader>ei :e ~/.i3/config<CR>
map <leader>ed :e ~/cloud/default.todo<CR>
map <leader>ef :e ~/cloud/temp.md<CR>
let g:which_key_map['e'] = { 'name': 'file shortcuts' }

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
autocmd filetype python noremap <CR> :below split <bar> :terminal python %<CR>
autocmd filetype javascript,typescript noremap <CR> :below split <bar> :terminal node %<CR>

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

"
" PLUGIN CONFIG
"

nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :WhichKeyVisual '<Space>'<CR>
set timeoutlen=500

let g:Illuminate_delay = 500

"needs manual activation with <C-e>
let g:firenvim_config = {
\  'localSettings': {
\    '.*': {
\      'takeover': 'never',
\      'priority': 1,
\    },
\  },
\}

"git
map <leader>hd :Gdiffsplit<CR>
map <leader>hb :Gblame<CR>
let g:which_key_map['h'] = { 'name': 'git' }

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

"linting
map <leader>ln :noh<CR>
map <leader>ls :s/"/'/g<bar>:noh<CR>
map <leader>lf :ALEFix<CR>
map <leader>lg :GrammarousCheck<CR>
map <leader>lr :GrammarousReset<CR>
map <leader>lt :OpenTodo<CR>
let g:which_key_map['l'] = { 'name': 'linting / syntax' }

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
\  'coc-java',
\  'coc-svelte',
\  'coc-vimtex',
\]

inoremap <silent><expr> <C-space> coc#refresh()

"jump back to and forth
noremap <leader>o <C-o>zz
noremap <leader>i <C-i>zz

"GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)zz
nmap <silent> gt <Plug>(coc-type-definition)zz
nmap <silent> gi <Plug>(coc-implementation)zz
nmap <silent> gr <Plug>(coc-references)zz
let g:which_key_map['g'] = { 'name': 'goto' }

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

"highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

vmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format)

"remap keys for applying codeAction to the current line.
nmap <leader>ac <Plug>(coc-codeaction)
"apply AutoFix to problem on the current line.
nmap <leader>af <Plug>(coc-fix-current)
nmap <leader>ar <Plug>(coc-rename)
nmap <silent> <leader>ad :call <SID>show_documentation()<CR>

"Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)
nmap <leader>ao :Fold<CR>
let g:which_key_map['a'] = { 'name': 'coc actions' }

let g:which_key_map['c'] = { 'name': 'commenter' }

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

let g:gruvbox_material_better_performance = 1
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
