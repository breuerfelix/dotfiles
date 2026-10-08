{ config, ... }: {
  imports = [
    ./alacritty.nix
    ./ghostty.nix
    ./borders.nix
    ./karabiner.nix
    #./sketchybar.nix
    ./aerospace.nix
  ];
}
