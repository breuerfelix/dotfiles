# my dotfiles

## installation

### macos

```bash
# install nix
sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume
sudo reboot

nix-channel --add https://github.com/LnL7/nix-darwin/archive/master.tar.gz darwin
nix-channel --update
nix-shell '<darwin>' -A installer
darwin-rebuild switch

# install these dotfiles
git clone https://github.com/breuerfelix/dotfiles.git ~/.nixpkgs
darwin-rebuild switch
```

### remote ssh server with home-manager

```bash
# install nix
curl -L https://nixos.org/nix/install | sh
sudo reboot

nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
home-manager switch

# install these dotfiles
git clone https://github.com/breuerfelix/dotfiles.git ~/.config/nixpkgs
home-manager switch
```

## architecture

* `home.nix` is the home-manager entrypoint for ssh servers 
* `mac.nix` is the home-manager entrypoint for macos
* `felix.nix` is the common entrypoint config for remote and macos version
* `darwin-configuration.nix` is the entrypoint for macos system

## content

- distro: macOS / remote server
- window manager: yabai [WIP]
- bar: spacebar [WIP]
- terminal: alacritty + tmux
- shell: zsh + pretzo
- editor: neovim
