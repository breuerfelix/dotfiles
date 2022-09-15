{
  description = "My Machines";

  # build the configuration
  # nix --experimental-features "nix-command flakes" build ".#solid.activationPackage"
  # nix --experimental-features "nix-command flakes" build ".#rocky.system"

  # activate configuration
  # ./result/activate

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    forgit = {
      url = "github:wfxr/forgit";
      flake = false;
    };

    # TODO move to a seperate repo
    # neovim plugins
    "folke/which-key.nvim" = { url = "github:folke/which-key.nvim"; flake = false; };

    # lsp
    "neovim/nvim-lspconfig" = { url = "github:neovim/nvim-lspconfig"; flake = false; };

    # completion
    "hrsh7th/nvim-cmp" = { url = "github:hrsh7th/nvim-cmp"; flake = false; };
    "hrsh7th/cmp-nvim-lsp" = { url = "github:hrsh7th/cmp-nvim-lsp"; flake = false; };
    "hrsh7th/cmp-path" = { url = "github:hrsh7th/cmp-path"; flake = false; };
    #(plugin "hrsh7th/cmp-buffer")
    #(plugin "hrsh7th/cmp-nvim-lsp-document-symbol") # TODO fix it
    "petertriho/cmp-git" = { url = "github:petertriho/cmp-git"; flake = false; };

    # snippets are needed for many language servers
    "hrsh7th/cmp-vsnip" = { url = "github:hrsh7th/cmp-vsnip"; flake = false; };
    "hrsh7th/vim-vsnip" = { url = "github:hrsh7th/vim-vsnip"; flake = false; };
    "rafamadriz/friendly-snippets" = { url = "github:rafamadriz/friendly-snippets"; flake = false; }; # snippet collection for all languages

    "raimondi/delimitMate" = { url = "github:Raimondi/delimitMate"; flake = false; }; # auto bracket
    # TODO fix this
    #(plugin "nvim-lua/lsp_extensions.nvim") # rust inline hints
    "ray-x/lsp_signature.nvim" = { url = "github:ray-x/lsp_signature.nvim"; flake = false; };

    # syntax highlighting
    "nvim-treesitter/nvim-treesitter" = { url = "github:nvim-treesitter/nvim-treesitter"; flake = false; };
    "p00f/nvim-ts-rainbow" = { url = "github:p00f/nvim-ts-rainbow"; flake = false; }; # bracket highlighting
    #(plugin "romgrk/nvim-treesitter-context") # TODO fix this
    "editorconfig/editorconfig-vim" = { url = "github:editorconfig/editorconfig-vim"; flake = false; };
    "earthly/earthly.vim" = { url = "github:earthly/earthly.vim"; flake = false; };
    "towolf/vim-helm" = { url = "github:towolf/vim-helm"; flake = false; };
    "lewis6991/spellsitter.nvim" = { url = "github:lewis6991/spellsitter.nvim"; flake = false; }; # spellchecker for comments

    # utilities
    #(plugin "nvim-lua/popup.nvim")
    "nvim-lua/plenary.nvim" = { url = "github:nvim-lua/plenary.nvim"; flake = false; };
    #(plugin "nvim-telescope" "nvim-telescope/telescope.nvim")
    "kyazdani42/nvim-web-devicons" = { url = "github:kyazdani42/nvim-web-devicons"; flake = false; };

    # navigation
    "easymotion/vim-easymotion" = { url = "github:easymotion/vim-easymotion"; flake = false; };
    "rhysd/clever-f.vim" = { url = "github:rhysd/clever-f.vim"; flake = false; };
    "kyazdani42/nvim-tree.lua" = { url = "github:kyazdani42/nvim-tree.lua"; flake = false; };
    "liuchengxu/vista.vim" = { url = "github:liuchengxu/vista.vim"; flake = false; };

    # highlights current variable with underline
    "yamatsum/nvim-cursorline" = { url = "github:yamatsum/nvim-cursorline"; flake = false; };
    "lewis6991/gitsigns.nvim" = { url = "github:lewis6991/gitsigns.nvim"; flake = false; };
    "apzelos/blamer.nvim" = { url = "github:APZelos/blamer.nvim"; flake = false; };
    "lukas-reineke/indent-blankline.nvim" = { url = "github:lukas-reineke/indent-blankline.nvim"; flake = false; };

    # bars
    "hoob3rt/lualine.nvim" = { url = "github:hoob3rt/lualine.nvim"; flake = false; };
    "smiteshp/nvim-gps" = { url = "github:SmiteshP/nvim-gps"; flake = false; }; # shows code context
    "akinsho/nvim-bufferline.lua" = { url = "github:akinsho/nvim-bufferline.lua"; flake = false; };
    "qpkorr/vim-bufkill" = { url = "github:qpkorr/vim-bufkill"; flake = false; };

    # fzf
    "ibhagwan/fzf-lua" = { url = "github:ibhagwan/fzf-lua"; flake = false; };
    "vijaymarupudi/nvim-fzf" = { url = "github:vijaymarupudi/nvim-fzf"; flake = false; };

    "preservim/vimux" = { url = "github:preservim/vimux"; flake = false; };

    "norcalli/nvim-colorizer.lua" = { url = "github:norcalli/nvim-colorizer.lua"; flake = false; };
    "tpope/vim-fugitive" = { url = "github:tpope/vim-fugitive"; flake = false; };
    "sindrets/diffview.nvim" = { url = "github:sindrets/diffview.nvim"; flake = false; };

    # wildmenu for commands
    "gelguy/wilder.nvim" = { url = "github:gelguy/wilder.nvim"; flake = false; };

    "tpope/vim-sleuth" = { url = "github:tpope/vim-sleuth"; flake = false; };
    "psliwka/vim-smoothie" = { url = "github:psliwka/vim-smoothie"; flake = false; };
    "preservim/nerdcommenter" = { url = "github:preservim/nerdcommenter"; flake = false; };
    "mattn/emmet-vim" = { url = "github:mattn/emmet-vim"; flake = false; };

    "andrewradev/tagalong.vim" = { url = "github:AndrewRadev/tagalong.vim"; flake = false; };
    "metakirby5/codi.vim" = { url = "github:metakirby5/codi.vim"; flake = false; };

    # formatters
    # TODO fix this
    #(plugin "psf/black")

    # debugging
    "mfussenegger/nvim-dap" = { url = "github:mfussenegger/nvim-dap"; flake = false; };

    #(plugin "github/copilot.vim")

    # TODO lazyload
    "vimwiki/vimwiki" = { url = "github:vimwiki/vimwiki"; flake = false; };
    #vim-grammarous
    #(plugin "dstein64/vim-startuptime")
    #(plugin "wsdjeg/vim-todo")
    #goyo-vim
    #limelight-vim
    #(plugin "NTBBloodbath/rest.nvim") # http client

    # colorschemes
    "folke/tokyonight.nvim" = { url = "github:folke/tokyonight.nvim"; flake = false; };
    "rebelot/kanagawa.nvim" = { url = "github:rebelot/kanagawa.nvim"; flake = false; };
    "ayu-theme/ayu-vim" = { url = "github:ayu-theme/ayu-vim"; flake = false; };
  };

  outputs = { self, nixpkgs, darwin, home-manager, ... }@inputs:
    let
      nixpkgsConfig = {
        allowUnfree = true;
        allowUnsupportedSystem = false;
      };
      stateVersion = "21.11";
    in
    {
      # nix-darwin with home-manager for macOS
      alucard = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs; };
        modules = [
          ({ pkgs, lib, ... }:
            {
              imports = [
                ./modules
                ./homebrew.nix
              ];
              nixpkgs.config = nixpkgsConfig;
              system.stateVersion = 4;

              environment = {
                variables = {
                  EDITOR = "nvim";
                  VISUAL = "nvim";
                };
              };

              nix = {
                settings = {
                  allowed-users = [ "felix" ];
                };
                package = pkgs.nix;
              };

              users.users.felix = {
                home = "/Users/felix";
                shell = pkgs.zsh;
              };

              programs = {
                zsh.enable = true;
              };

              networking = {
                hostName = "alucard";
                knownNetworkServices = [ "Wi-Fi" ];
                # disabled in favor of my pi-hole at home
                #dns = [ "1.1.1.1" "8.8.8.8" ];
              };

              fonts = {
                fontDir.enable = true;
                fonts = with pkgs; [
                  nerdfonts
                  #corefonts # TODO fix
                  recursive
                ];
              };
            })
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.felix = { pkgs, ... }: {
                imports = [ ./mac.nix ];
                home.stateVersion = stateVersion;
              };
            };
          }
        ];
      };

      # standalone home-manager installation
      solid =
        let
          system = "x86_64-linux";
          pkgs = import nixpkgs {
            inherit system;
            config = nixpkgsConfig;
          };
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          # make inputs available in all files
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ({ pkgs, ... }: {
              # TODO check if this works without this line
              #nixpkgs.config = nixpkgsConfig;
              home.stateVersion = stateVersion;
              # home-manager manages itself
              programs.home-manager.enable = true;

              home.packages = with pkgs; [
                zsh
                sublime
              ];
              home.homeDirectory = "/home/felix";
              home.username = "felix";
            })
          ];
        };
    };
}
