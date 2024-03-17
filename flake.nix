{
  description = "my dotfiles";

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

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-zsh-fzf-tab.url =
      "github:nixos/nixpkgs/8193e46376fdc6a13e8075ad263b4b5ca2592c03";

    # my custom neovim
    feovim.url = "github:breuerfelix/feovim";
    krewfile.url = "github:brumhard/krewfile";

    # sketchybar config
    sketchybar = {
      url = "github:FelixKratz/dotfiles";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager, ... }@inputs:
    let
      nixpkgsConfig = {
        allowUnfree = true;
        allowUnsupportedSystem = false;
      };
      overlays = with inputs; [ feovim.overlay krewfile.overlay ];
      user = "felix";
      hostname = "brummi";
      system = "aarch64-darwin";
    in {
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt;
      # nix-darwin with home-manager for macOS
      darwinConfigurations.${hostname} = darwin.lib.darwinSystem {
        inherit system;
        # makes all inputs availble in imported files
        specialArgs = { inherit inputs; };
        modules = [
          inputs.nix-index-database.darwinModules.nix-index
          ./darwin
          ({ pkgs, inputs, ... }: {
            nixpkgs.config = nixpkgsConfig;
            nixpkgs.overlays = overlays;

            system = {
              stateVersion = 4;
              configurationRevision = self.rev or self.dirtyRev or null;
            };

            users.users.${user} = {
              home = "/Users/${user}";
              shell = pkgs.zsh;
            };

            networking = {
              computerName = hostname;
              hostName = hostname;
              localHostName = hostname;
            };

            nix = {
              # enable flakes per default
              package = pkgs.nixFlakes;
              gc = {
                automatic = true;
                user = user;
              };
              settings = {
                allowed-users = [ user ];
                experimental-features = [ "nix-command" "flakes" ];
                warn-dirty = false;
                auto-optimise-store = true;
              };
            };
          })
          home-manager.darwinModule
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              # makes all inputs available in imported files for hm
              extraSpecialArgs = {
                inherit inputs;
                pkgs-zsh-fzf-tab =
                  import inputs.nixpkgs-zsh-fzf-tab { inherit system; };
              };
              users.${user} = { ... }:
                with inputs; {
                  imports = [ feovim.ideavim ./home-manager ./shell ];
                  home.stateVersion = "23.11";
                  # from feovim
                  ideavim.enable = true;
                };
            };
          }
        ];
      };
    };
}
