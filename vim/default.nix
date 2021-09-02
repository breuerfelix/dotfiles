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
      #(lib.strings.fileContents ./coc.vim)
      ''
        lua << EOF
        ${lib.strings.fileContents ./config.lua}
        ${lib.strings.fileContents ./lsp.lua}
        EOF
      ''
    ];
    extraPackages = with pkgs; [
      tree-sitter
      #luajit # for nvim colorizer

      jq curl # rest.nvim

      # for telescope
      # TODO add telescope
      #bat ripgrep fd

      # extra language servers
      #rnix-lsp TODO fix slow closing time of neovim
      terraform-lsp
      nodePackages.typescript nodePackages.typescript-language-server
      gopls
      texlab
      nodePackages.pyright
      rust-analyzer
    ];
    plugins = with pkgs.vimPlugins; [
      vim-which-key

      # lsp
      (plugin "neovim/nvim-lspconfig")
      #vim-vsnip
      (plugin "hrsh7th/nvim-compe") # TODO switch to nvim cmp
      (plugin "Raimondi/delimitMate") # auto bracket
      (plugin "nvim-lua/lsp_extensions.nvim") # rust inline hints

      #vimtex

      # syntax highlighting
      (plugin "nvim-treesitter/nvim-treesitter")
      (plugin "p00f/nvim-ts-rainbow") # bracket highlighting
      (plugin "romgrk/nvim-treesitter-context")

      # utilities
      #(plugin "nvim-lua/popup.nvim")
      (plugin "nvim-lua/plenary.nvim")
      #(plugin "nvim-telescope" "nvim-telescope/telescope.nvim")
      (plugin "kyazdani42/nvim-web-devicons")

      # TODO get this going
      #(plugin "nvim-nonicons" "yamatsum/nvim-nonicons")

      # highlights current variable with underline
      (plugin "yamatsum/nvim-cursorline")
      (plugin "lewis6991/gitsigns.nvim")
      (plugin "lukas-reineke/indent-blankline.nvim")

      (plugin "hoob3rt/lualine.nvim")
      (plugin "akinsho/nvim-bufferline.lua")

      fzfWrapper
      fzf-vim
      (plugin "norcalli/nvim-colorizer.lua")
      (plugin "rhysd/clever-f.vim")
      # TODO fix wilder (:UpdateRemotePlugins does not work)
      #(plugin "wilder" "gelguy/wilder.nvim")
      vim-sleuth
      vim-smoothie
      nerdcommenter

      emmet-vim
      (plugin "AndrewRadev/tagalong.vim")
      #(plugin "metakirby5/codi.vim")

      # TODO lazyload
      #vimwiki
      #vim-grammarous
      #(plugin "dstein64/vim-startuptime")
      #(plugin "wsdjeg/vim-todo")
      #goyo-vim
      #limelight-vim
      #(plugin "NTBBloodbath/rest.nvim") # http client

      # TODO configure nvim tree lua
      nerdtree
      #nvim-tree-lua

      # TODO maybe replace with nvim web devicons
      vim-devicons

      # colorschemes
      (plugin "folke/tokyonight.nvim")
    ];
  };
}
