{ config, pkgs, ... }: {
  imports = [
    ./modules
    ./felix.nix
  ];

  nixpkgs.config.allowUnfree = true;
  home = {
    username = "ubuntu";
    homeDirectory = "/home/ubuntu";
    packages = with pkgs; [
      gcc
    ];
  };

  programs = {
    zsh = {
      initExtraBeforeCompInit = ''
        . /home/ubuntu/.nix-profile/etc/profile.d/nix.sh
        eval "$(starship init zsh)"
        eval "$(thefuck --alias)"
      '';
    };
  };
}
