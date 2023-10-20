{
  description = "My Machines";

  # solid
  # nix --experimental-features "nix-command flakes" build ".#homeConfigurations.solid.activationPackage"
  # ./result/activate

  # alucard
  # nix --experimental-features "nix-command flakes" build ".#darwinConfigurations.alucard.system"
  # ./result/sw/bin/darwin-rebuild switch --flake ~/.nixpkgs

  # rocky
  # nix --experimental-features "nix-command flakes" build ".#nixosConfigurations.rocky.config.system.build.toplevel"
  # ./result/bin/switch-to-configuration switch
  # or if you want to edit boot entry
  # sudo nixos-rebuild switch --flake ".#rocky"
  # or if you want to install from scratch
  # sudo nixos-install --flake github:breuerfelix/dotfiles#rocky

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

    # my custom neovim
    feovim.url = "github:breuerfelix/feovim";
    calendarsync.url = "github:breuerfelix/calendarsync";
    krewfile.url = "github:brumhard/krewfile";

    forgit = {
      url = "github:wfxr/forgit";
      flake = false;
    };

    # sketchybar config
    sketchybar = {
      url = "github:FelixKratz/dotfiles";
      flake = false;
    };

    # custom cursor
    breeze = {
      url = "github:KDE/breeze";
      flake = false;
    };

    # TODO test without rev
    materia-theme = {
      url = "github:nana-4/materia-theme?ref=76cac96ca7fe45dc9e5b9822b0fbb5f4cad47984";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager, ... }@inputs:
    let
      nixpkgsConfig = {
        allowUnfree = true;
        allowUnsupportedSystem = false;
        vivaldi = {
          proprietaryCodecs = true;
          enableWideVine = true;
        };
      };
      overlays = with inputs; [
        feovim.overlay
        krewfile.overlay
        calendarsync.overlay
      ];
      stateVersion = "22.05";
      user = "felix";
    in
    {
      # nix-darwin with home-manager for macOS
      darwinConfigurations.alucard = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        # makes all inputs availble in imported files
        specialArgs = { inherit inputs; };
        modules = [
          ./modules
          ./machines/alucard.nix
          ./darwin/homebrew.nix
          ({ pkgs, ... }: {
            nixpkgs.config = nixpkgsConfig;
            nixpkgs.overlays = overlays;

            system.stateVersion = 4;

            users.users.${user} = {
              home = "/Users/${user}";
              shell = pkgs.zsh;
            };

            nix = {
              # enable flakes per default
              package = pkgs.nixFlakes;
              settings = {
                allowed-users = [ user ];
                experimental-features = [ "nix-command" "flakes" ];
              };
            };
          })
          home-manager.darwinModule
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              # makes all inputs available in imported files for hm
              extraSpecialArgs = { inherit inputs; };
              users.${user} = { ... }: with inputs; {
                imports = [
                  feovim.ideavim
                  ./home/mac.nix
                  ./darwin
                  ./shell
                  ./desktop/alacritty.nix
                ];
                home.stateVersion = stateVersion;
              };
            };
          }
        ];
      };

      # standalone home-manager installation
      homeConfigurations.solid =
        let
          system = "x86_64-linux";
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
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./modules
            ./home/linux.nix
            ./shell
            ({ ... }: {
              home.stateVersion = stateVersion;
              # home-manager manages itself
              programs.home-manager.enable = true;

              home = {
                username = user;
                homeDirectory = "/home/${user}";
              };
            })
          ];
        };

      # nixos system
      nixosConfigurations.rocky = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        # makes all inputs availble in imported files
        specialArgs = { inherit inputs; inherit user; };
        modules = [
          ./modules
          ./machines/rocky.nix
          ./system
          ({ pkgs, ... }: {
            nixpkgs.config = nixpkgsConfig;
            nixpkgs.overlays = overlays;

            system.stateVersion = stateVersion;

            users.users.${user} = {
              home = "/home/${user}";
              shell = pkgs.zsh;
              isNormalUser = true;
            };

            nix = {
              # enable flakes per default
              package = pkgs.nixFlakes;
              settings = {
                allowed-users = [ user ];
                experimental-features = [ "nix-command" "flakes" ];
              };
            };
          })
          home-manager.nixosModule
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              # makes all inputs available in imported files for hm
              extraSpecialArgs = { inherit inputs; };
              users.${user} = { ... }: {
                imports = [
                  ./home/linux.nix
                  ./modules/base16.nix
                  ./shell
                  ./desktop
                ];
                home.stateVersion = stateVersion;
              };
            };
          }
        ];
      };
    };
}
