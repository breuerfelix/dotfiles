{ config, pkgs, ... }: {
  imports = [ <home-manager/nix-darwin> ];

  environment.systemPackages = with pkgs; [
    vim
    alacritty
  ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # auto upgrade nix
  nix.package = pkgs.nix;
  nix.allowedUsers = [ "felix" ];
  nixpkgs.config.allowUnfree = true;
  users.users.felix = {
    home = "/Users/felix";
    shell = pkgs.zsh;
  };

  home-manager = {
    users.felix = import ../.config/nixpkgs/home.nix;
    useUserPackages = true;
    useGlobalPkgs = true;
  };

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  system.stateVersion = 4;
}
