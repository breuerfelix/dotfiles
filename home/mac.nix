{ lib, ... }: {
  programs = {
    zsh = {
      initExtraBeforeCompInit = ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
      '';
    };

    # override mac font settings
    alacritty.settings.font.size = lib.mkForce 17;
  };

  ideavim.enable = true;
}
