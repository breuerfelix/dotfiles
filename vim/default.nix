{ config, pkgs, lib, ... }:
let
  # installs a vim plugin from git with a given tag / branch
  pluginGit = ref: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
    };
  };
  # always installs latest version
  plugin = pluginGit "HEAD";
in {
  programs.neovim = {
    enable = true;
    #package = pkgs.neovim-nightly;
    viAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
    # decided to move the config into files
    # to get syntaxhighlighting (had config in plugins before)
    extraConfig = builtins.concatStringsSep "\n" [
      (lib.strings.fileContents ./base.vim)
      (lib.strings.fileContents ./plugins.vim)
      (lib.strings.fileContents ./lsp.vim)
      ''
        lua << EOF
        ${lib.strings.fileContents ./config.lua}
        ${lib.strings.fileContents ./lsp.lua}
        ${lib.strings.fileContents ./debug.lua}
        EOF
      ''
    ];
    extraPackages = with pkgs; [
      tree-sitter
      jq curl # rest.nvim

      # for fzf
      bat ripgrep fd fzf

      # extra language servers
      rnix-lsp
      terraform-lsp
      nodePackages.typescript nodePackages.typescript-language-server
      gopls
      texlab
      nodePackages.pyright
      rust-analyzer

      # debugging
      delve # golang
    ];
    plugins = with pkgs.vimPlugins; [
      (plugin "folke/which-key.nvim")

      # lsp
      (plugin "neovim/nvim-lspconfig")

      # completion
      (plugin "hrsh7th/cmp-nvim-lsp")
      (plugin "hrsh7th/cmp-path")
      #(plugin "hrsh7th/cmp-buffer")
      (plugin "hrsh7th/nvim-cmp")

      # snippets are needed for many language servers
      (plugin "hrsh7th/cmp-vsnip")
      (plugin "hrsh7th/vim-vsnip")
      (plugin "rafamadriz/friendly-snippets")

      (plugin "Raimondi/delimitMate") # auto bracket
      (plugin "nvim-lua/lsp_extensions.nvim") # rust inline hints

      # syntax highlighting
      (plugin "nvim-treesitter/nvim-treesitter")
      (plugin "p00f/nvim-ts-rainbow") # bracket highlighting
      (plugin "romgrk/nvim-treesitter-context")
      (plugin "editorconfig/editorconfig-vim")

      # utilities
      #(plugin "nvim-lua/popup.nvim")
      (plugin "nvim-lua/plenary.nvim")
      #(plugin "nvim-telescope" "nvim-telescope/telescope.nvim")
      (plugin "kyazdani42/nvim-web-devicons")

      # navigation
      (plugin "easymotion/vim-easymotion")
      (plugin "rhysd/clever-f.vim")
      (plugin "kyazdani42/nvim-tree.lua")

      # highlights current variable with underline
      (plugin "yamatsum/nvim-cursorline")
      (plugin "lewis6991/gitsigns.nvim")
      #(plugin "lukas-reineke/indent-blankline.nvim") # TODO only load on files < 1k lines

      # bars
      (plugin "hoob3rt/lualine.nvim")
      (plugin "SmiteshP/nvim-gps") # shows code context
      (plugin "akinsho/nvim-bufferline.lua")
      (plugin "qpkorr/vim-bufkill")

      # fzf
      (plugin "ibhagwan/fzf-lua")
      (plugin "vijaymarupudi/nvim-fzf")

      (plugin "preservim/vimux")

      (plugin "norcalli/nvim-colorizer.lua")
      (plugin "tpope/vim-fugitive")
      (plugin "sindrets/diffview.nvim")

      # wildmenu for commands
      (plugin "gelguy/wilder.nvim")

      (plugin "tpope/vim-sleuth")
      (plugin "psliwka/vim-smoothie")
      (plugin "preservim/nerdcommenter")
      (plugin "mattn/emmet-vim")

      (plugin "AndrewRadev/tagalong.vim")
      #(plugin "metakirby5/codi.vim")

      # debugging
      (plugin "mfussenegger/nvim-dap")

      # TODO lazyload
      #vimwiki
      #vim-grammarous
      #(plugin "dstein64/vim-startuptime")
      #(plugin "wsdjeg/vim-todo")
      #goyo-vim
      #limelight-vim
      #(plugin "NTBBloodbath/rest.nvim") # http client

      # colorschemes
      (plugin "folke/tokyonight.nvim")
    ];
  };
}
