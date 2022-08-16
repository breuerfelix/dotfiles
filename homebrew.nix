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
      "sketchybar" # alternative spacebar
      "skhd" # keybinding manager
      "cocoapods" "ios-deploy" # for ios development
      # broken nix builds
      "openstackclient"
      "yabai" # tiling window manager
      "earthly" # makefile alternative
      "openvpn" "iproute2mac" "parallel" # gardener
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
      "kui" # UI for kubectl

      # communication
      "microsoft-teams"
      "mutify" # one click mute button
      "zoom"
      "slack"
      "mumble" # teamspeak alternative
      "signal" # messenger
      "teamviewer"
      "discord"

      "adobe-creative-cloud"
      "android-studio"
      "balenaetcher"
      "blender"
      "calibre" # ebook management
      "chromium"
      "firefox"
      "google-chrome"
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
      # default
      "homebrew/bundle"
      "homebrew/cask"
      "homebrew/cask-drivers"
      "homebrew/core"
      "homebrew/services"
      # custom
      "cmacrae/formulae" # spacebar
      "koekeishiya/formulae" # yabai
      "earthly/earthly" # earthly
      "FelixKratz/formulae" # sketchybar
    ];
  };
}
