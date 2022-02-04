"compe
"inoremap <silent><expr> <C-Space> compe#complete()
"works with delimitMate
"inoremap <silent><expr> <CR>      compe#confirm({ 'keys': "\<Plug>delimitMateCR", 'mode': '' })
"inoremap <silent><expr> <C-e>     compe#close('<C-e>')

"inline hints for rust
"autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}

