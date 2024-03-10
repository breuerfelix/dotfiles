{ config, pkgs, lib, ... }: {
  homebrew = {
    enable = true;
    global = {
      autoUpdate = false;
    };
    # will not be uninstalled when removed
    #masApps = [
      #{
        #"1Password for Safari" = 1569813296;
        #Xcode = 497799835;
      #}
    #];
    onActivation = {
      # "zap" removes manually installed brews and casks
      cleanup = "zap";
      autoUpdate = false;
      upgrade = false;
    };
    brews = [
      "sniffnet" # monitor network traffic
      "aws-iam-authenticator" # eks login
      "colima" # docker desktop alternative
      "bitwarden-cli" # raycast extension does not like nix version
      "borders" # borders for windows
      # FIXME: not present in recent nixpkgs
      "tabby" # ai coding assistant

      # ios development
      "cocoapods"
      "ios-deploy"
    ];
    casks = [
      # utilities
      "aldente" # battery management
      "macfuse" # file system utilities
      "hiddenbar" # hides menu bar icons
      "karabiner-elements" # keyboard remap

      # coding
      "intellij-idea"
      "postman"

      # virtualization
      "utm" # virtual machines

      # communication
      "microsoft-teams"
      "microsoft-outlook"
      "zoom"
      "slack"
      "signal"
      "discord"

      "android-studio" # needed for react-native
      "rekordbox" # dj software
      "obs" # stream / recoding software
      "protonmail-bridge"
      "shottr" # screenshot tool
      "the-unarchiver"
      "tunnelblick" # vpn client
      "eul" # mac monitoring
      "wireshark" # network sniffer
      "sf-symbols" # patched font for sketchybar
      "prusaslicer" # slicer for my printer
      "autodesk-fusion" # CAD tool
      "time-out" # blurs screen every x mins
      "firefox" # needed for my uploadpy profiles
      "raycast" # launcher on steroids
      "keycastr" # show keystrokes on screen
      "obsidian" # zettelkasten
    ];
    taps = [
      # default
      "homebrew/bundle"
      "homebrew/cask-fonts"
      "homebrew/services"
      # custom
      "FelixKratz/formulae" # sketchybar | jankyborders
      "tabbyml/tabby" # ai coding assistant
    ];
  };
}
