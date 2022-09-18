{ config, pkgs, lib, ... }: {
  imports = [
    ./karabiner.nix
    ./yabai.nix
    ./spacebar.nix
    ./alacritty.nix
    ./felix.nix
  ];

  programs = {
    zsh = {
      initExtraBeforeCompInit = ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
        eval "$(starship init zsh)"
        eval "$(thefuck --alias)"
      '';

      sessionVariables = {
        # for kubebuilder
        ETCD_UNSUPPORTED_ARCH = "arm64";
        KUBEBUILDER_ASSETS = "/Users/felix/code/programs/kubebuilder-assets";
      };
    };
  };
}
