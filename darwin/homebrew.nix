{ config, pkgs, lib, ... }: {
  homebrew = {
    enable = true;
    onActivation = {
      # "zap" removes manually installed brews and casks
      cleanup = "zap";
      autoUpdate = false;
      upgrade = false;
    };
    brews = [
      "helm"
      "kubebuilder" # generating k8s controller
      "sonobuoy" # k8s e2e tests
      "skhd" # keybinding manager
      "restish" # httpie alternative
      "sniffnet" # monitor network traffic
      "aws-iam-authenticator" # eks login
      "colima" # docker desktop alternative
      "bitwarden-cli" # raycast extension does not like nix version

      # ios development
      "cocoapods"
      "ios-deploy"

      # broken nix builds
      "yabai" # tiling window manager

      # sketchybar
      "sketchybar" # macos bar alternative
      "jq" # json parser
      "gh" # github-cli

      "borders" # borders for windows
    ];
    casks = [
      # utilities
      "aldente" # battery management
      "karabiner-elements" # remap keyboard
      "macfuse" # file system utilities
      "hiddenbar" # hides menu bar icons

      # coding
      "intellij-idea"
      "postman"
      "unity-hub"
      "visual-studio-code"

      # virtualization
      "utm" # virtual machines

      # communication
      "microsoft-teams"
      "microsoft-outlook"
      "zoom"
      "slack"
      "signal" # messenger
      "teamviewer"
      "discord"

      "adobe-creative-cloud"
      "android-studio"
      "balenaetcher"
      #"blender"
      "calibre" # ebook management
      "lens" # visual k9s
      "mixxx" # dj software
      "rekordbox" # dj software
      "obs" # stream / recoding software
      "protonmail-bridge"
      "raspberry-pi-imager"
      "shottr" # screenshot tool
      "the-unarchiver"
      "tunnelblick" # vpn client
      "vlc" # media player
      "eul" # mac monitoring
      "kap" # screen recorder software
      "wireshark" # network sniffer
      "sf-symbols" # patched font for sketchybar
      "prusaslicer" # slicer for my printer
      "ultimaker-cura" # slicer for my printer
      "autodesk-fusion" # CAD tool
      "time-out" # blurs screen every x mins
      "firefox" # needed for my uploadpy profiles
      "raycast" # launcher on steroids
      "vnc-viewer" # vnc application
      "darktable" # adobe lightroom alternative
      "mongodb-compass" # mongodb native
      "keycastr" # show keystrokes on screen
      "notion" # organizing app
      "obsidian" # zettelkaste
    ];
    taps = [
      # default
      "homebrew/bundle"
      "homebrew/cask-fonts"
      "homebrew/services"
      # custom
      "cmacrae/formulae" # spacebar
      "koekeishiya/formulae" # yabai
      "FelixKratz/formulae" # sketchybar | jankyborders
      "earthly/earthly"
      "danielgtaylor/restish"
    ];
  };
}
