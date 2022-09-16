{ config, pkgs, lib, ... }: {
  imports = [
    ./modules
    ./homebrew.nix
  ];

  environment = {
    systemPackages = with pkgs; [ ];
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
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
}
