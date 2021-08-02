{ config, pkgs, lib, ... }: {
  imports = [
    ../../nixos/shell/vim/init.nix
  ];
  # Let Home Manager install and manage itself.
  #nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    packages = with pkgs; [
      htop
      alacritty
    ];
  };

  # Install MacOS applications to the user environment if the targetPlatform is Darwin
  #home.file."Applications/home-manager".source = let
  #apps = pkgs.buildEnv {
    #name = "home-manager-applications";
    #paths = config.home.packages;
    #pathsToLink = "/Applications";
  #};
  #in lib.mkIf pkgs.stdenv.targetPlatform.isDarwin "${apps}/Applications";

  #home.username = "felix";
  #home.homeDirectory = "/Users/felix";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";
}
