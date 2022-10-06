{ config, pkgs, lib, inputs, ... }: {
  nixpkgs.overlays = [
    (import ./forgit.nix inputs)
    (import ./breeze-cursor.nix inputs)
    (import ./gtk-theme.nix inputs)
    (self: super: {
      neovim = inputs.feovim.packages.${self.system}.default;
      krewfile = inputs.krewfile.packages.${self.system}.default;
    })
  ];
}
