require('which-key').setup()
require('nvim-web-devicons').setup()
require('colorizer').setup()
-- :DiffviewOpen / DiffviewClose
require('diffview').setup()

require('nvim-tree').setup {
  --open_on_setup = true,
}

require('fzf-lua').setup {
  winopts = {
    border = 'single',
  },
  fzf_opts = {
    ['--border'] = 'none',
  },
  files = {
    cmd = 'fd --type f --hidden --follow --exclude .git --exclude .vim --exclude .cache --exclude vendor',
  },
  grep = {
    rg_opts = "--hidden --column --line-number --no-heading " ..
              "--color=always --smart-case " ..
              "-g '!{.git,node_modules,vendor}/*'",
  },
}

require('gitsigns').setup {
  signs = {
    -- source: https://en.wikipedia.org/wiki/Box-drawing_character
    add          = {hl = 'GitSignsAdd'   , text = '┃', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '┃', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '┃', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
}

require('nvim-treesitter.configs').setup {
  -- "all", or a list
  -- TODO maybe use all?
  ensure_installed = {
    "bash", "c", "c_sharp",
    "cpp", "css", "dart", "dockerfile",
    "go", "gomod", "gowork",
    "graphql", "hcl", "html", "http",
    "java", "javascript", "jsdoc", "json",
    "json5", "kotlin", "latex", "lua", "make",
    "markdown", "nix", "proto", "python", "rust",
    "ruby", "scss", "svelte", "toml", "tsx",
    "typescript", "vim", "vue", "yaml",
  },
  -- the default path is read only due to nix
  parser_install_dir = "~/.local/share/nvim/site",
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
  rainbow = {
    enable = true,
    extended_mode = true,
    -- prevents lagging in large files
    max_file_lines = 1000,
  },
}
vim.opt.runtimepath:append("~/.local/share/nvim/site")

-- TODO fix
--require('treesitter-context').setup {
  --enable = true,
  --throttle = true,
--}

require('bufferline').setup {
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

require('nvim-gps').setup({
  icons = {
    ["class-name"] = ' ',
    ["function-name"] = ' ',
    ["method-name"] = ' '
  },
  separator = ' > ',
})

local gps = require('nvim-gps')
require('lualine').setup {
  options = {
    theme = "nord",
    -- disable powerline
    section_separators = '',
    component_separators = '',
  },
  sections = {
    lualine_c = {
      { gps.get_location, condition = gps.is_available },
    },
  },
}

require('indent_blankline').setup {
  show_current_context = true,
}

require('spellsitter').setup()
