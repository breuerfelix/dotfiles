{ config, pkgs, lib, ... }: {
  # unstable package overrides
  #nixpkgs.config.packageOverrides = pkgs: rec {
    #fzf = unstable.fzf;
    #alacritty = unstable.alacritty;
  #};

  nixpkgs.overlays = [
    (import ./forgit.nix)
  ];
}
