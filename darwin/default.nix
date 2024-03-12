{ pkgs, ... }: {
  imports = [
    ./homebrew.nix
    ./skhd.nix
    ./yabai.nix
  ];

  services = {
    # FIXME: driver issues
    karabiner-elements.enable = false;
    nix-daemon.enable = true;
    sketchybar = {
      enable = true;
      extraPackages = with pkgs; [ jq gh ];
    };
  };

  fonts.fonts = with pkgs; [ sketchybar-app-font ];
}
