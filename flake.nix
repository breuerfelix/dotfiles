{
  description = "My Machines";

  # solid
  # nix --experimental-features "nix-command flakes" build ".#homeConfigurations.solid.activationPackage"
  # ./result/activate

  # rocky
  # nix --experimental-features "nix-command flakes" build ".#darwinConfigurations.alucard.system"
  # ./result/sw/bin/darwin-rebuild switch --flake ~/.nixpkgs

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
      user = "felix";
    in
    {
      # nix-darwin with home-manager for macOS
      darwinConfigurations.alucard = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        # makes all inputs availble in imported files
        specialArgs = { inherit inputs; };
        modules = [
          (import ./darwin-configuration.nix)
          ({ pkgs, ... }:
            {
              nixpkgs.config = nixpkgsConfig;
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
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              # makes all inputs available in imported files for hm
              extraSpecialArgs = { inherit inputs; };
              users.${user} = { pkgs, ... }: {
                imports = [ ./mac.nix ];
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
          };
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          # makes all inputs available in imported files
          extraSpecialArgs = { inherit inputs; };
          modules = [
            (import ./home.nix)
            ({ pkgs, ... }: {
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
    };
}
