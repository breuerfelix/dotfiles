# my dotfiles

## editor

i use a separate repository for my neovim config. it can be found [here](https://github.com/breuerfelix/feovim)!

## installation

the installation instructions are *not* updated for my flake version!!

### macos

```bash
# install nix
sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume --daemon
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

. ~/.nix-profile/etc/profile.d/nix.sh
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
home-manager switch

# install these dotfiles
rm -rf ~/.config/nixpkgs
git clone https://github.com/breuerfelix/dotfiles.git ~/.config/nixpkgs
home-manager switch

# change default shell to zsh
echo $(which zsh) | sudo tee -a /etc/shells
sudo chsh -s $(which zsh) $USER
```

## update

```bash
# all inputs
nix flake update

# single input
nix flake lock --update-input <input>
```

## architecture

- `flake.nix`
  - `darwinConfigurations.alucard` is the entrypoint for macOS
  - `homeConfigurations.solid` is the entrypoint for remote servers
  - `nixosConfigurations.rocky` is the entrypoint for NixOS
- `darwin/` everything mac specific
- `system/` everything NixOS specific
- `shell/` cross-platform shell configuration

- `github.com:breuerfelix/feovim` my neovim configuration

## content

- distro: macOS / NixOS / linux remote server
- window manager: yabai
- bar: spacebar [WIP]
- terminal: alacritty + zellij
- shell: zsh + pretzo
- editor: neovim ([configuration](https://github.com/breuerfelix/feovim))
