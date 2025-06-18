{ ... }: {
  homebrew = {
    enable = true;
    global = { autoUpdate = false; };
    # will not be uninstalled when removed
    # masApps = {
    #   Xcode = 497799835;
    #   Transporter = 1450874784;
    #   VN = 1494451650;
    # };
    onActivation = {
      # "zap" removes manually installed brews and casks
      cleanup = "zap";
      autoUpdate = false;
      upgrade = false;
    };
    brews = [
      "sniffnet" # monitor network traffic
      "aws-iam-authenticator" # eks login
      "bitwarden-cli" # raycast extension does not like nix version
      "borders" # borders for windows
      #"openai-whisper" # transcode audio to text
      "databricks" # databricks cli
      "pkgxdev/made/pkgx" # run anything
      "diffutils" # gnupkg diff binary

      # ios development
      "cocoapods"
      "ios-deploy"

      # work
      "libmagic"
      "ruff" # python linter
      "totp-cli" # for backstage e2e tests
    ];
    casks = [
      # utilities
      "aldente" # battery management
      "macfuse" # file system utilities
      "hiddenbar" # hides menu bar icons
      "meetingbar" # shows upcoming meetings
      "karabiner-elements" # keyboard remap
      "eurkey" # keyboard layout
      "nikitabobko/tap/aerospace" # tiling window manager
      "displaylink" # connect to external dell displays
      "raspberry-pi-imager" # flash images to sd card

      # coding
      "visual-studio-code" # code editor
      "cursor" # ai IDE
      "zed" # vim like editor
      "intellij-idea"
      "postman"
      "android-studio" # needed for react-native

      # virtualization
      "utm" # virtual machines
      "docker" # docker desktop

      # communication
      "microsoft-teams"
      "microsoft-auto-update"
      "microsoft-outlook"
      "zoom"
      "slack"
      "signal"
      "whatsapp"
      "discord"

      # browsers
      "google-chrome" # used for selenium and testing
      "firefox" # because chromium can't be shared in teams...

      # ai
      "chatgpt" # open ai desktop client
      "jan" # local ChatGPT
      "diffusionbee" # local image generation
      "draw-things" # local image generation

      # other
      "bitwarden" # password manager
      "spotify" # music
      "rekordbox" # dj software
      "obs" # stream / recoding software
      "proton-mail-bridge"
      "protonvpn"
      "the-unarchiver"
      "tunnelblick" # vpn client
      "eul" # mac monitoring
      "wireshark" # network sniffer
      "sf-symbols" # patched font for sketchybar
      "prusaslicer" # slicer for my printer
      "autodesk-fusion" # CAD tool
      "openscad" # autodesk alternative
      "time-out" # blurs screen every x mins
      "raycast" # launcher on steroids
      "keycastr" # show keystrokes on screen
      "obsidian" # zettelkasten
      "arc" # mac browser
      "vlc" # media player
      "balenaetcher" # usb flashing
      "steam" # gaming
      "loop" # window manager
      "homerow" # vimium for mac
      "todoist" # better reminders
      "neohtop" # nice htop gui alternative
      "freelens" # kubernetes IDE
    ];
    taps = [
      # default
      "homebrew/bundle"
      "homebrew/cask-fonts"
      "homebrew/services"
      # custom
      "FelixKratz/formulae" # borders
      "databricks/tap" # databricks
      "pkgxdev/made" # pkgx
      "nikitabobko/tap" # aerospace
      "freelensapp/tap" # freelens
    ];
  };
}
