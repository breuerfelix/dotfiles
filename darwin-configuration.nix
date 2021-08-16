{ config, pkgs, ... }:
let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
  };
in {
  imports = [
    (import "${home-manager}/nix-darwin")
  ];

  system.stateVersion = 4;
  environment.systemPackages = with pkgs; [
    vim
    #yabai # TODO fix yabai install with nix
  ];

  nixpkgs.config.allowUnfree = true;
  nix = {
    allowedUsers = [ "felix" ];
    package = pkgs.nixUnstable;

    gc = {
      automatic = true;
      user = "felix";
      options = "--delete-older-than 7d";
    };
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
    users.felix = import ./felix.nix;
  };

  networking = {
    hostName = "alucard";
    knownNetworkServices = [ "Wi-Fi" ];
    dns = [ "1.1.1.1" "8.8.8.8" ];
  };

  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [
      nerdfonts
      #corefonts
      recursive
    ];
  };
}
