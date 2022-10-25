{ config, pkgs, lib, inputs, ... }: {
  nixpkgs.overlays = [
    (import ./forgit.nix inputs)
    (import ./breeze-cursor.nix inputs)
    (import ./gtk-theme.nix inputs)
  ];
}
