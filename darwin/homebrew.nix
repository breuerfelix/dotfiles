{ ... }: {
  homebrew = {
    enable = true;
    global = {
      autoUpdate = false;
    };
    # will not be uninstalled when removed
    masApps = {
      Xcode = 497799835;
      Transporter = 1450874784;
    };
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

      # ios development
      "cocoapods"
      "ios-deploy"
    ];
    casks = [
      # utilities
      "aldente" # battery management
      "macfuse" # file system utilities
      "hiddenbar" # hides menu bar icons
      "meetingbar" # shows upcoming meetings
      "karabiner-elements" # keyboard remap
      "eurkey" # keyboard layout

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

      "bitwarden" # password manager
      "spotify" # music
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
      #"autodesk-fusion" # CAD tool
      "time-out" # blurs screen every x mins
      "raycast" # launcher on steroids
      "keycastr" # show keystrokes on screen
      "obsidian" # zettelkasten
      "firefox" # browser
      "arc" # mac browser
    ];
    taps = [
      # default
      "homebrew/bundle"
      "homebrew/cask-fonts"
      "homebrew/services"
      # custom
      "FelixKratz/formulae" # borders
    ];
  };
}
