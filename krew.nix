{ config, pkgs, lib, ... }:
let
  krewPkgs = [
    "modify-secret"
    "neat"
    "oidc-login"
    "pv-migrate"
    "stern"
    "explore" # fuzzy finder kubectl explain
  ];
in {
  home.activation.krew = lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD ${pkgs.krew}/bin/krew install ${builtins.toString krewPkgs}
    $DRY_RUN_CMD ${pkgs.krew}/bin/krew upgrade
  '';
}
