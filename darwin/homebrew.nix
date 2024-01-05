{ config, pkgs, lib, ... }: {
  homebrew = {
    enable = true;
    onActivation = {
      # "zap" removes manually installed brews and casks
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    brews = [
      "helm"
      "kubebuilder" # generating k8s controller
      "sonobuoy" # k8s e2e tests
      "lima" # docker alternative
      "skhd" # keybinding manager
      "restish" # httpie alternative
      "sniffnet" # monitor network traffic
      "spacer" # outputs spacers after command paused
      "aws-iam-authenticator" # eks login
      "czkawka" # cleaner app

      # ios development
      "cocoapods"
      "ios-deploy"

      # broken nix builds
      "openstackclient"
      "yabai" # tiling window manager
      "earthly" # makefile alternative

      # gardener
      "openvpn"
      "iproute2mac"
      "parallel"
      "gardenctl-v2"
      "gardenlogin"

      # sketchybar
      "sketchybar" # macos bar alternative
      "jq" # json parser
      "gh" # github-cli

      "borders" # borders for windows
    ];
    casks = [
      # utilities
      "aldente" # battery management
      "bartender" # hides mac bar icons
      "karabiner-elements" # remap keyboard
      "macfuse" # file system utilities
      "hammerspoon" # lua scripting engine
      "fly" # concourse ci

      # coding
      "intellij-idea"
      "postman"
      "bloomrpc" # postman for grpc
      "unity-hub"
      "visual-studio-code"
      "vscodium" # unbranded vscode

      # virtualization
      "docker" # docker desktop
      "utm" # virtual machines
      "kui" # UI for kubectl

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
      "chromium"
      "google-chrome"
      "lens" # visual k9s
      "meld" # folder differ
      "mixxx" # dj software
      "obs" # stream / recoding software
      "protonmail-bridge"
      "raspberry-pi-imager"
      "shottr" # screenshot tool
      "the-unarchiver"
      "tunnelblick" # vpn client
      "ubersicht"
      "vlc" # media player
      "eul" # mac monitoring
      "kindavim" # vim keys for everything
      "kap" # screen recorder software
      "wireshark" # network sniffer
      "sf-symbols" # patched font for sketchybar
      "rekordbox" # dj software
      "prusaslicer" # slicer for my printer
      "ultimaker-cura" # slicer for my printer
      "autodesk-fusion360" # CAD tool
      "min" # minimal browser
      "time-out" # blurs screen every x mins
      "firefox" # needed for my uploadpy profiles
      "raycast" # launcher on steroids
      "vnc-viewer" # vnc application
      "darktable" # adobe lightroom alternative
      "mongodb-compass" # mongodb native
      "keycastr" # show keystrokes on screen
      "notion" # organizing app
    ];
    taps = [
      # default
      "homebrew/bundle"
      "homebrew/cask"
      "homebrew/cask-drivers"
      "homebrew/cask-fonts"
      "homebrew/core"
      "homebrew/services"
      # custom
      "cmacrae/formulae" # spacebar
      "koekeishiya/formulae" # yabai
      "FelixKratz/formulae" # sketchybar | jankyborders
      "earthly/earthly"
      "gardener/tap"
      "danielgtaylor/restish"
      "samwho/spacer"
    ];
  };
}
