{ ... }: {
  homebrew = {
    enable = true;
    global = { autoUpdate = false; };
    onActivation = {
      # "zap" removes manually installed brews and casks
      cleanup = "zap";
      autoUpdate = false;
      upgrade = false;
    };
    brews = [
      "sniffnet" # monitor network traffic
      "bitwarden-cli" # raycast extension does not like nix version
      "borders" # borders for windows
      #"openai-whisper" # transcode audio to text
      "databricks" # databricks cli
      "hey" # http load testing tool
      "qcachegrind" # view callgrinds
      "jsonnet"

      # ai
      "yt-dlp" # youtube downloader cli
      # "charmbracelet/tap/crush"
      # "sst/tap/opencode"
    ];
    casks = [
      # utilities
      "blackhole-2ch" # virtual audio driver
      "aldente" # battery management
      "macfuse" # file system utilities
      "hiddenbar" # hides menu bar icons
      # "meetingbar" # shows upcoming meetings
      "karabiner-elements" # keyboard remap
      "eurkey" # keyboard layout
      "nikitabobko/tap/aerospace" # tiling window manager
      "raspberry-pi-imager" # flash images to sd card
      "steam" # gaming

      # coding
      "visual-studio-code" # code editor
      "postman"
      "godot" # game engine

      # virtualization
      # "utm" # virtual machines
      "docker-desktop" # docker desktop

      # communication
      "microsoft-teams"
      "microsoft-auto-update"
      "signal"
      "whatsapp"
      "discord"

      # browsers
      "google-chrome" # used for selenium and testing
      "firefox" # because chromium can't be shared in teams...

      # other
      "bitwarden" # password manager
      "spotify" # music
      "rekordbox" # dj software
      "obs" # stream / recoding software
      "proton-mail-bridge"
      "the-unarchiver"
      "eul" # mac monitoring
      "wireshark-app" # network sniffer
      "sf-symbols" # patched font for sketchybar
      "prusaslicer" # slicer for my printer
      "ultimaker-cura" # better prusaslicer
      "autodesk-fusion" # CAD tool
      "time-out" # blurs screen every x mins
      "raycast" # launcher on steroids
      "keycastr" # show keystrokes on screen
      "obsidian" # zettelkasten
      "vlc" # media player
      "balenaetcher" # usb flashing
      "loop" # window manager
      "homerow" # vimium for mac
    ];
    taps = [
      # custom
      "FelixKratz/formulae" # borders
      "databricks/tap" # databricks
      "nikitabobko/tap" # aerospace
      # "lindell/multi-gitter" # multi-gitter
      "charmbracelet/tap" # crush
      "sst/tap" # opencode
    ];
  };
}
