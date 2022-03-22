{ config, pkgs, lib, ... }: {
  homebrew = {
    enable = true;
    autoUpdate = true;
    cleanup = "none"; # "zap" removes manually installed brews and casks
    brews = [
      "helm"
      "kubebuilder" # generating k8s controller
      "podman" # docker alternative
      "spacebar" # macos bar alternative
      "skhd" # keybinding manager
      "openstackclient"
      # broken nix builds
      "starship"
      "yabai" # tiling window manager
    ];
    # TODO port
    casks = [];
    taps = [
      "cmacrae/formulae" # spacebar
      "koekeishiya/formulae" # yabai
      # default
      "homebrew/bundle"
      "homebrew/cask"
      "homebrew/cask-drivers"
      "homebrew/core"
      "homebrew/services"
    ];
  };
}
