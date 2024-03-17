{ pkgs, lib, ... }:
with pkgs;
let
  plugins = writeText "plugins" ''
    krew
    modify-secret
    neat
    oidc-login
    pv-migrate
    stern
    explore
    sniff
  '';
in {
  home.activation.krew = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD ${krewfile}/bin/krewfile -command ${krew}/bin/krew -file ${plugins}
  '';
}
