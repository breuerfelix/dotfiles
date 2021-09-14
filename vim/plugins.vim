"whichkey
let g:which_key_map = {}
"autocmd! User vim-which-key call which_key#register('<Space>', 'g:which_key_map')
call which_key#register('<Space>', 'g:which_key_map')

nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :WhichKeyVisual '<Space>'<CR>
let g:which_key_map['c'] = { 'name': 'commenter' }

set timeoutlen=500
set signcolumn=yes

map <leader>b :NERDTreeToggle<CR>
nmap <leader>s :Rg<CR>
nmap <leader>ln :noh<CR>
nmap <leader>ls :s/"/'/g<bar>:noh<CR>
nmap <leader>lc :%s/\t/  /g<CR>
nmap <leader>lg :GrammarousCheck<CR>
nmap <leader>lr :GrammarousReset<CR>
nmap <leader>lt :OpenTodo<CR>
"TODO doesn't work
let g:which_key_map['l'] = { 'name': 'linting / syntax' }

let g:spacevim_todo_labels = [
\  'FIXME',
\  'TODO',
\]

"let g:indentLine_char = '|'
let g:indentLine_char = '│'

highlight IndentBlanklineChar guifg=grey25 gui=nocombine

"improve writing
function! s:goyo_enter()
  set nolist
  Limelight
endfunction

function! s:goyo_leave()
  set nolist
  Limelight!
endfunction

noremap <silent> <leader>g :Goyo<CR>
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

"inline hints for rust
autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}

" fuzzy finder for wilder menu
"call wilder#set_option('pipeline', [
"\  wilder#branch(
"\    wilder#cmdline_pipeline({
"\      'fuzzy': 1,
"\      'use_python': 1,
"\    }),
"\    wilder#python_search_pipeline({
"\      'regex': 'fuzzy',
"\      'engine': 're',
"\      'sort': function('wilder#python_sort_difflib'),
"\    }),
"\  ),
"\])

""command completion
"call wilder#enable_cmdline_enter()
"set wildcharm=<Tab>
"cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
"cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"
" only / and ? is enabled by default
"call wilder#set_option('modes', ['/', '?', ':'])

"better wildmenu
set wildmenu
set wildmode=longest:list,full

"vimwiki
let g:vimwiki_list = [{
      \'path': '~/vimwiki/',
      \'syntax': 'markdown',
      \'ext': '.md'
      \}]
"otherwhise vimwiki considers every .md file as vimwiki
let g:vimwiki_global_ext = 0

nmap <leader>wj <Plug>VimwikiNextLink
nmap <leader>wk <Plug>VimwikiPrevLink
let g:which_key_map['w'] = { 'name': 'vimwiki' }";

"vim smoothie
nmap <C-d> <Plug>(SmoothieDownwards)
nmap <C-f> <Plug>(SmoothieUpwards)
let g:smoothie_no_default_mappings = 1

"use single quotes in emmet
"let g:user_emmet_settings = { 'html': { 'quote_char': "'", }, }
let g:user_emmet_leader_key = '<C-e>'

"fzf
let g:fzf_layout = { 'window': { 'border': 'sharp', 'width': 0.9, 'height': 0.6 } }

let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_method = 'generic'
let g:vimtex_compiler_generic = {
  \ 'cmd' : 'bash run.sh',
  \ 'build_dir' : '',
  \}

nmap <leader>el :VimtexCompile<CR>
nmap <leader>ec :Codi!!<CR>
nmap <leader>eh <Plug>RestNvim
let g:which_key_map['e'] = { 'name': 'exec' }

"disable all extensions for a minimal setup
let g:airline_extensions = []
let g:airline_powerline_fonts = 0

"debugging
nnoremap <silent> <leader>dr :lua require'dap'.continue()<CR>
nnoremap <silent> <leader>dk :lua require'dap'.step_over()<CR>
nnoremap <silent> <leader>dj :lua require'dap'.step_into()<CR>
nnoremap <silent> <leader>dl :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>dt :lua require'dap'.toggle_breakpoint()<CR>
"nnoremap <silent> <leader>db :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
"nnoremap <silent> <leader>dp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>do :lua require'dap'.repl.open()<CR>
"nnoremap <silent> <leader>dh :lua require'dap'.run_last()<CR>
nnoremap <silent> <leader>dh :lua :lua require('dap.ui.widgets').hover()<CR>
