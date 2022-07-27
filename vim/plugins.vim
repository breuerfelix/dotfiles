"BufKill
let g:BufKillCreateMappings = 0

lua require('which-key').register({ ['<leader>c'] = { name = 'commenter' } })
lua require('which-key').register({ ['<leader>d'] = { name = 'debugging' } })

set timeoutlen=500
set signcolumn=yes

map <leader>b :NvimTreeToggle<CR>
nmap <leader>t :Vista!!<CR>
nmap <leader>s :FzfLua grep search=""<CR>
nmap <leader>ln :noh<CR>
nmap <leader>ls :s/"/'/g<bar>:noh<CR>
nmap <leader>lc :%s/\t/  /g<CR>
nmap <leader>lg :GrammarousCheck<CR>
nmap <leader>lr :GrammarousReset<CR>
nmap <leader>lt :OpenTodo<CR>
nmap <leader>lp :echo expand('%:p')<CR>
lua require('which-key').register({ ['<leader>l'] = { name = 'linting / syntax' } })

let g:spacevim_todo_labels = [
\  'FIXME',
\  'TODO',
\]

"let g:indentLine_char = '|'
"let g:indentLine_char = '│'
"let g:indent_blankline_use_treesitter = v:true

highlight IndentBlanklineChar guifg=grey25 gui=nocombine

"copilot
"imap <silent><script><expr> <C-Space> copilot#Accept("\<CR>")
"let g:copilot_no_tab_map = v:true

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
"TODO get this going
"autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require('lsp_extensions').inlay_hints{}

"vsnip
imap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

call wilder#setup({
  \ 'modes': [':', '/', '?'],
  \ 'next_key': '<C-j>',
  \ 'previous_key': '<C-k>',
  \ 'accept_key': '<Down>',
  \ 'reject_key': '<Up>',
  \ })

call wilder#set_option('pipeline', [
  \   wilder#branch(
  \     wilder#cmdline_pipeline({
  \       'language': 'python',
  \       'fuzzy': 1,
  \     }),
  \     wilder#python_search_pipeline({
  \       'pattern': wilder#python_fuzzy_pattern(),
  \       'sorter': wilder#python_difflib_sorter(),
  \       'engine': 're',
  \     }),
  \   ),
  \ ])

call wilder#set_option('renderer', wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
  \ 'highlighter': wilder#basic_highlighter(),
  \ 'border': 'single',
  \ 'left': [
  \   ' ', wilder#popupmenu_devicons()
  \ ],
  \ })))

"git blamer
let g:blamer_enabled = 1
let g:blamer_delay = 1000
let g:blamer_prefix = ' > '
let g:blamer_relative_time = 1
let g:blamer_show_in_insert_modes = 0

"better wildmenu
set wildmenu
set wildmode=longest:list,full

"vimwiki
let g:vimwiki_list = [{
  \ 'path': '~/vimwiki/',
  \ 'syntax': 'markdown',
  \ 'ext': '.md'
  \ }]
"otherwhise vimwiki considers every .md file as vimwiki
let g:vimwiki_global_ext = 0

nmap <leader>wj <Plug>VimwikiNextLink
nmap <leader>wk <Plug>VimwikiPrevLink
"let g:which_key_map['w'] = { 'name': 'vimwiki' }";
lua require('which-key').register({ ['<leader>w'] = { name = 'vimwiki' } })

"vim smoothie
nmap <C-d> <Plug>(SmoothieDownwards)
nmap <C-f> <Plug>(SmoothieUpwards)
let g:smoothie_no_default_mappings = 1

"use single quotes in emmet
"let g:user_emmet_settings = { 'html': { 'quote_char': "'", }, }
let g:user_emmet_leader_key = '<C-e>'

"fzf
let g:fzf_layout = { 'window': { 'border': 'sharp', 'width': 0.9, 'height': 0.6 } }

"editor config
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_method = 'generic'
let g:vimtex_compiler_generic = {
  \ 'cmd' : 'bash run.sh',
  \ 'build_dir' : '',
  \ }

nmap <leader>el :VimtexCompile<CR>
nmap <leader>ec :Codi!!<CR>
nmap <leader>eh <Plug>RestNvim
lua require('which-key').register({ ['<leader>e'] = { name = 'exec' } })

let g:codi#interpreters = {
     \ 'python': {
         \ 'bin': '/opt/homebrew/bin/python3',
         \ 'prompt': '^\(>>>\|\.\.\.\) ',
         \ },
     \ }

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
