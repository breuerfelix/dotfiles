{ config, pkgs, lib, ... }: {
  homebrew = {
    enable = true;
    autoUpdate = true;
    cleanup = "zap"; # "zap" removes manually installed brews and casks
    brews = [
      "helm"
      "kubebuilder" # generating k8s controller
      "lima" # docker alternative
      "spacebar" # macos bar alternative
      "skhd" # keybinding manager
      "openstackclient"
      # broken nix builds
      "starship"
      "yabai" # tiling window manager
    ];
    casks = [
      # utilities
      "aldente" # battery management
      "bartender" # hides mac bar icons
      "browserosaurus" # choose browser on each link
      "karabiner-elements" # remap keyboard
      "macfuse" # file system utilities

      "adobe-creative-cloud"
      "android-studio"
      "balenaetcher"
      "blender"
      "calibre" # ebook management
      "darktable" # adobe lightroom
      "chromium"
      "firefox"
      "google-chrome"
      "google-drive"
      "krisp" # micro noise reduction
      "lens" # visual k9s
      "meld" # folder differ
      "mixxx" # dj software
      "obs" # stream / recoding software
      "postman"
      "bloomrpc"
      "protonmail-bridge"
      "raspberry-pi-imager"
      "shottr" # screenshot tool
      "signal" # messenger
      "the-unarchiver"
      "tunnelblick" # vpn client
      "ubersicht"
      "unity-hub"
      "visual-studio-code"
      "vlc" # media player
      "vscodium"
      "mutify" # one click mute button
      "microsoft-teams"
      "zoom"
      "mumble"
      "eul" # mac monitoring
    ];
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