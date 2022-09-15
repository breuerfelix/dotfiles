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
      rocky = darwin.lib.darwinSystem {
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
              users.felix = { pkgs, ... }: {
                imports = [ ./mac.nix ];
                config = {
                  _module.args.inputs = inputs;
                  home.stateVersion = stateVersion;
                };
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
          modules = [
            ({ pkgs, ... }: {
              nixpkgs.config = nixpkgsConfig;
              home.stateVersion = stateVersion;
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
