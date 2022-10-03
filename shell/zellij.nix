{ config, pkgs, lib, ... }: {
  programs.zellij = {
    enable = true;
    settings = {
      theme = "tokyo-night";
    };
  };
}
