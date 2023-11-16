{ config, pkgs, lib, inputs, ... }: {
  nixpkgs.overlays = [
    (import ./breeze-cursor.nix inputs)
    (import ./gtk-theme.nix inputs)
  ];
}
