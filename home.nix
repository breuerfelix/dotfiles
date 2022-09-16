{ config, pkgs, ... }: {
  imports = [
    ./modules
    ./felix.nix
  ];

  programs = {
    zsh = {
      initExtraBeforeCompInit = ''
        . /home/ubuntu/.nix-profile/etc/profile.d/nix.sh
        #eval "$(starship init zsh)"
        eval "$(thefuck --alias)"
      '';
    };
  };
}
