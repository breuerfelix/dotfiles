{ config, pkgs, lib, ... }: {
  imports = [
    ../shell
    ../darwin/karabiner.nix
    ../darwin/yabai.nix
    ../darwin/spacebar.nix
    ../desktop/alacritty.nix
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
