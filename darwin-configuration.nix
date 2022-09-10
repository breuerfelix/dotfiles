{ config, pkgs, lib, ... }:
let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
  };
in {
  imports = [
    (import "${home-manager}/nix-darwin")
    ./modules
    ./homebrew.nix
  ];

  system.stateVersion = 4;
  environment = {
    systemPackages = with pkgs; [];
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  nixpkgs.config.allowUnfree = true;
  nix = {
    settings = {
      allowed-users = [ "felix" ];
    };
    package = pkgs.nix;
    #autoOptimiseStore = true; # TODO doesnt work on mac

    #gc = {
      #automatic = true;
      #user = "felix";
      #options = "--delete-older-than 7d";
    #};
  };

  users.users.felix = {
    home = "/Users/felix";
    shell = pkgs.zsh;
  };

  programs = {
    zsh.enable = true;
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.felix = import ./mac.nix;
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
}
