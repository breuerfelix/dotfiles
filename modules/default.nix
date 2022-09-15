{ config, pkgs, lib, inputs, ... }: {
  nixpkgs.overlays = [
    (import ./forgit.nix inputs)
    (self: super: {
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
