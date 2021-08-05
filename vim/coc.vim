"completion
"use tab and shift tab
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"use control-j and control+k to naviate menu aswell
inoremap <silent><expr> <C-j>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<C-j>" :
      \ coc#refresh()
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-h>"

" make CR auto-select the first completion
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

set cmdheight=1
"turn off completion menu messages
set shortmess+=c
set signcolumn=yes

"TODO implement coc-snippets
let g:coc_global_extensions = [
"\  'coc-git',
\  'coc-pairs',
\  'coc-vimlsp',
\  'coc-pyright',
\  'coc-lua',
\  'coc-sh',
\  'coc-yaml',
\  'coc-toml',
"\  'coc-spell-checker',
\  'coc-tsserver',
\  'coc-json',
\  'coc-jest',
\  'coc-html',
\  'coc-css',
\  'coc-eslint',
\  'coc-svelte',
\  'coc-rls',
\  'coc-go',
"\  'coc-java',
\  'coc-vimtex',
\  'coc-emmet',
\]

inoremap <silent><expr> <C-space> coc#refresh()

"GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)zz
nmap <silent> gt <Plug>(coc-type-definition)zz
nmap <silent> gi <Plug>(coc-implementation)zz
nmap <silent> gr <Plug>(coc-references)zz

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

nmap <leader>f <Plug>(coc-format)
xmap <leader>f <Plug>(coc-format-selected)

"remap keys for applying codeAction to the current line.
nmap <leader>ac <Plug>(coc-codeaction)
xmap <leader>ac <Plug>(coc-codeaction-selected)

"apply AutoFix to problem on the current line.
nmap <leader>af <Plug>(coc-fix-current)
nmap <leader>ar <Plug>(coc-rename)
nmap <silent> <leader>ad :call <SID>show_documentation()<CR>

nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

"Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)
nmap <leader>ao :Fold<CR>

let g:which_key_map['a'] = { 'name': 'coc actions' }
