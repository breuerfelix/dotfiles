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
      # fonts
      nerdfonts
      corefonts
      recursive

      # shell helper tools
      pcmanfm # filebrowser
      libnotify # used for notifications
      translate-shell # used for rofi-translate
      # TODO marked as broken
      #qmk_firmware # flash keyboard
      playerctl # media keys
      xclip # clipboard
      #esptool

      # pulseaudio
      pavucontrol
      pasystray 

      xournalpp # annotate pdf files
      nitrogen # wallpaper manager
      vivaldi # browser
      vivaldi-ffmpeg-codecs # proprietary codecs
      vlc # media player
      vscode # for debugging

      zoom-us
      screenkey
      signal-desktop
      spotify
      postman

      # blender
      # asesprite
      losslesscut-bin # audio / video editing
    ];
  };

  programs.base16 = {
    enable = true;
    colors = vars.colors;

    xresources = true;
    i3 = true;
    dunst = true;

    # TODO
    alacritty = false;
    fzf = false;
    neovim = false;
    neovim_airline = false;
    tmux = false;
  };
}
