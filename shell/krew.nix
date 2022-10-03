{ config, pkgs, lib, ... }:
let
  krewfile = pkgs.writeText "krewfile" ''
    modify-secret
    neat
    oidc-login
    pv-migrate
    stern
    explore
    krew
  '';
in {
  home.activation.krew = lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD ${pkgs.krewfile}/bin/krewfile -command ${pkgs.krew}/bin/krew -file ${krewfile}
  '';
}
