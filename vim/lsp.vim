"compe
"inoremap <silent><expr> <C-Space> compe#complete()
"works with delimitMate
"inoremap <silent><expr> <CR>      compe#confirm({ 'keys': "\<Plug>delimitMateCR", 'mode': '' })
"inoremap <silent><expr> <C-e>     compe#close('<C-e>')
