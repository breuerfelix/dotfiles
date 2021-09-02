require'nvim-web-devicons'.setup()
require'colorizer'.setup()

require'gitsigns'.setup {
  signs = {
    -- source: https://en.wikipedia.org/wiki/Box-drawing_character
    add          = {hl = 'GitSignsAdd'   , text = '┃', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '┃', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '┃', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
}

require'nvim-treesitter.configs'.setup {
  -- "all", "maintained" or a list
  ensure_installed = "maintained",
  highlight = { enable = true, },
  indent = { enable = false, },
  rainbow = { enable = true, },
}

require'treesitter-context'.setup{
  enable = true,
  throttle = false,
}

require'bufferline'.setup {
  options = {
    show_close_icon = false,
    show_buffer_close_icons = false,
    separator_style = "thick",
  },
  -- TODO change highlights based on base16
  --highlights = {
    --fill = {
        --guifg = '#3B4252',
        --guibg = '#3B4252',
    --},
  --},
}

require'lualine'.setup {
  options = {
    theme = "nord",
    -- disable powerline
    section_separators = '',
    component_separators = '',
  },
}
