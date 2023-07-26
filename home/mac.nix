{ config, pkgs, lib, ... }: {
  programs = {
    zsh = {
      initExtraBeforeCompInit = ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
        eval "$(starship init zsh)"
        eval "$(thefuck --alias)"
      '';
    };

    # override mac font settings
    alacritty.settings.font.size = lib.mkForce 18;
  };

  ideavim.enable = true;
}
