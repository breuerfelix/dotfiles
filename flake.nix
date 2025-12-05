{
  description = "my dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
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

      unstable = import inputs.nixpkgs-unstable { inherit system; };
      overlays = with inputs; [ feovim.overlay krewfile.overlay ];
      system = "aarch64-darwin";
    in {
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt;

      # nix-darwin with home-manager for macOS
      darwinConfigurations.brummi = let
        user = "felix";
      in
      darwin.lib.darwinSystem {
        inherit system;
        # makes all inputs availble in imported files
        specialArgs = { inherit inputs; inherit unstable; };
        modules = [
          inputs.nix-index-database.darwinModules.nix-index
          ./darwin
          ({ pkgs, inputs, ... }: {
            nixpkgs.config = nixpkgsConfig;
            nixpkgs.overlays = overlays;

            system = {
              stateVersion = 6;
              primaryUser = user;
              configurationRevision = self.rev or self.dirtyRev or null;
            };

            users.users.${user} = {
              home = "/Users/${user}";
              shell = pkgs.zsh;
            };

            networking = let hostname = "brummi"; in {
              computerName = hostname;
              hostName = hostname;
              localHostName = hostname;
            };

            nix = {
              # enable flakes per default
              package = pkgs.nixVersions.stable;
              enable = true;
              gc.automatic = false;
              settings = {
                allowed-users = [ user ];
                experimental-features = [ "nix-command" "flakes" ];
                warn-dirty = false;
                # produces linking issues when updating on macOS
                # https://github.com/NixOS/nix/issues/7273
                auto-optimise-store = false;
              };
            };
          })
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              # makes all inputs available in imported files for hm
              extraSpecialArgs = {
                inherit inputs;
                inherit unstable;
                inherit user;
              };
              users.${user} = { ... }:
                with inputs; {
                  imports = [ feovim.feovim ./home-manager ./shell ];
                  home.stateVersion = "25.11";
                  # from feovim
                  feovim = {
                    ideavim.enable = true;
                    vscode.enable = true;
                  };
                };
            };
          }
        ];
      };

      # standalone home-manager installation
      homeConfigurations."SIT-SMBP-446M7F" =
        let
          user = "breuer";
          # modifies pkgs to allow unfree packages
          pkgs = import nixpkgs {
            inherit system;
            config = nixpkgsConfig;
            overlays = overlays;
          };
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          # makes all inputs available in imported files
          extraSpecialArgs = { inherit inputs; inherit unstable; inherit user; };
          modules = [
            inputs.feovim.feovim
            ./home-manager
            ./shell
            ({ ... }: {
              home.stateVersion = "25.11";
              feovim = {
                ideavim.enable = true;
                vscode.enable = true;
              };
              
              fonts.fontconfig.enable = true;
              home = {
                username = user;
                homeDirectory = "/Users/${user}";
                packages = with pkgs; [
                  nerd-fonts.jetbrains-mono
                ];
              };
            })
          ];
        };

    };
}
