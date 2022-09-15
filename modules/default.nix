{ config, pkgs, lib, inputs, ... }: {
  # unstable package overrides
  #nixpkgs.config.packageOverrides = pkgs: rec {
  #fzf = unstable.fzf;
  #alacritty = unstable.alacritty;
  #};

  nixpkgs.overlays = [
    (import ./forgit.nix inputs)
    # TODO remove after alacritty fix
    (self: super: {
      alacritty = super.alacritty.overrideAttrs (
        o: rec {
          doCheck = false;
        }
      );
      krewfile = self.callPackage
        (
          self.fetchFromGitHub {
            owner = "brumhard";
            repo = "krewfile";
            rev = "v0.1.0";
            sha256 = "sha256-3OWpZTwx8knVkiMAgASavDbKDeOszXfWbKHBHWMkNkU=";
          })
        { };
    })
  ];
}
