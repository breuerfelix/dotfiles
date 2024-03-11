# my dotfiles

## editor

i use a separate repository for my neovim config. it can be found [here](https://github.com/breuerfelix/feovim)!

## installation

### macos

```bash
# install nix
sh <(curl -L https://nixos.org/nix/install)
sudo reboot

nix --experimental-features "nix-command flakes" build ".#darwinConfigurations.brummi.system"
# make sure your hostname is set to "brummi"
./result/sw/bin/darwin-rebuild switch --flake ~/.nixpkgs
```

### linux

i currently only use macos for my daily driver. linux configurations are not up-to-date.

## update

```bash
# all inputs
nix flake update

# single input
nix flake lock --update-input <input>
```

## architecture

- `flake.nix`
  - `darwinConfigurations.brummi` is the entrypoint for macOS
  - `homeConfigurations.solid` is the entrypoint for remote servers
  - `nixosConfigurations.rocky` is the entrypoint for NixOS
- `darwin/` everything mac specific
- `system/` everything NixOS specific
- `shell/` cross-platform shell configuration

- `github.com:breuerfelix/feovim` my neovim configuration

## content

- distro: macOS / NixOS / linux remote server
- window manager: yabai / i3
- bar: spacebar / rofi
- terminal: alacritty + zellij
- shell: zsh + pretzo
- editor: neovim ([configuration](https://github.com/breuerfelix/feovim))
