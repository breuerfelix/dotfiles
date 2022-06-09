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
      "yabai" # tiling window manager
    ];
    casks = [
      # utilities
      "aldente" # battery management
      "bartender" # hides mac bar icons
      "browserosaurus" # choose browser on each link
      "karabiner-elements" # remap keyboard
      "macfuse" # file system utilities

      # virtualization
      "docker" # docker desktop
      "utm" # virtual machines

      # communication
      "microsoft-teams"
      "mutify" # one click mute button
      "zoom"
      "slack"
      "mumble" # teamspeak alternative
      "krisp" # micro noise reduction
      "signal" # messenger

      "adobe-creative-cloud"
      "android-studio"
      "balenaetcher"
      "blender"
      "calibre" # ebook management
      "chromium"
      "firefox"
      "google-chrome"
      "google-drive"
      "lens" # visual k9s
      "meld" # folder differ
      "mixxx" # dj software
      "obs" # stream / recoding software
      "postman"
      "bloomrpc"
      "protonmail-bridge"
      "raspberry-pi-imager"
      "shottr" # screenshot tool
      "the-unarchiver"
      "tunnelblick" # vpn client
      "ubersicht"
      "unity-hub"
      "visual-studio-code"
      "vscodium" # unbranded vscode
      "vlc" # media player
      "eul" # mac monitoring
      "qmk-toolbox" # flashing keyboard
      "kindavim" # vim keys for everything
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
