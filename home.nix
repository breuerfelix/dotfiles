{ config, pkgs, ... }: {
  imports = [
    ./modules
    ./felix.nix
  ];

  programs = {
    zsh = {
      initExtraBeforeCompInit = ''
        eval "$(starship init zsh)"
        eval "$(thefuck --alias)"
      '';
    };
  };
}
