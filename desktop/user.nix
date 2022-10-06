{ config, pkgs, lib, ... }:
let
  vars = import ./constants.nix;
in
{
  # manage itself
  programs.home-manager.enable = true;
  manual.manpages.enable = true;
  # allow installation of fonts
  fonts.fontconfig.enable = true;

  home = {
    keyboard.layout = "eu";

    packages = with pkgs; [
      # system
      nerdfonts
      corefonts
      recursive # fonts
      pavucontrol
      pasystray # pulseaudio
      pcmanfm # filebrowser
      libnotify # used for notifications
      translate-shell # used for rofi-translate
      #bind # dns utils
      #telnet
      #nmap
      #qmk_firmware # flash keyboard marked as broken TODO fix
      betterlockscreen
      #gotop # htop alternative
      #nvtop # gpu monitor
      #unstable.bottom # htop alternative
      #grc # colored log output TODO fix this
      #sshfs # mount folders over ssh
      paprefs # allows multiple output sources
      #unstable.zenmonitor
      playerctl

      #unstable.esptool

      # compiler
      #gnumake
      #openssl

      # Stdenv links libstdc++ to lib path
      #gcc
      #gccStdenv

      # c#
      #dotnet-sdk

      # terminal
      #fd
      #ripgrep
      xclip
      #gitAndTools.delta
      #unstable.starship # cross-shell prompt
      #cht-sh
      #tealdeer # interactive terminal cheat sheet

      # rust
      #rustup
      #pkg-config

      # node tools
      #nodejs
      #yarn # npm is built into nodejs
      #unstable.nodePackages.expo-cli
      # TODO preact-cli global installation

      # python tool
      #unstable.python38Full
      #unstable.poetry # python
      #python38Packages.pip # TODO make pip work

      #tmate
      #ranger
      #nnn
      # TODO fix taskell
      #taskell

      # useful terminal tools
      #termdown # terminal countdown
      #hyperfine # performance test tool
      #tectonic # latex compiler
      #plantuml # generates plantuml diagrams
      #python38Packages.pygments # latex syntac highlighting

      # k8s
      #kubectl
      #kubernetes-helm
      #kubie
      #kubectx # TODO kubectx not working
      #thefuck # TODO integration into shell via module
      #universal-ctags
      #docker-compose
      #podman-compose

      # programs
      xournalpp # annotate pdf files
      nitrogen # wallpaper manager
      firefox # TODO replace with programs.firefox
      #ferdi # messenger all-in-one
      #insync # google drive sync
      #blender
      #veracrypt # cross-platform drive encryption
      vlc # media player

      #unstable.unityhub
      vscode # needed to generate project files

      #zotero # latex bib manager
      #android-studio
      #zoom-us
      #teamviewer
      #quicksynergy # share mouse and keyboard events TODO configure
      #synergy
      screenkey
      signal-desktop
      spotify
      #lutris # gaming on linux

      #obsidian # gui for knowledge base
      #yuzu-ea # nintendo switch emulator
      # TODO asesprite calibre lossless-cut noisetorch wireshark
    ];
  };

  programs.base16 = {
    enable = true;
    colors = vars.colors;

    xresources = true;
    i3 = true;
    dunst = true;

    alacritty = false;
    fzf = false;
    neovim = false;
    neovim_airline = false;
    tmux = false;
  };
}
