{ config, pkgs, lib, ... }: {
  imports = [
    ./skhd.nix
    ./yabai.nix
  ];

  services = {
    # FIXME: driver issues
    karabiner-elements.enable = false;
    sketchybar = {
      enable = true;
      extraPackages = with pkgs; [ jq gh ];
    };
  };
}
