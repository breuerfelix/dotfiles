{ config, pkgs, ... }: {
  imports = [
    ../shell
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
