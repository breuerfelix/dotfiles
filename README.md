# my dotfiles

i currently only use macos as my daily driver so this repository is really system specific. everything inside `shell/` also works on linux.

## programs

- distro: macOS
- window manager: yabai
- bar: spacebar
- terminal: alacritty + zellij
- shell: zsh + pretzo
- editor: helix / neovim ([configuration](https://github.com/breuerfelix/feovim))

## architecture

- `flake.nix`
  - `darwinConfigurations.brummi` is the entrypoint for macOS
- `darwin/` nix-darwin configuration
- `home-manager/` home-manager configuration
- `shell/` cross-platform shell configuration
- `github.com:breuerfelix/feovim` neovim configuration

## macos

```bash
# installation
sh <(curl -L https://nixos.org/nix/install)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
git clone git@github.com:breuerfelix/dotfiles.git ~/.nixpkgs
# make sure your hostname is set to "brummi"
sudo reboot

# build the system
cd ~/.nixpkgs
nix --experimental-features "nix-command flakes" build ".#darwinConfigurations.brummi.system"
# switch to new system
./result/sw/bin/darwin-rebuild switch --flake ~/.nixpkgs

# all in one command
nix run nix-darwin -- switch --flake ~/.nixpkgs
```

manual steps:
- enable brew services
  - `brew services start borders`
- update secrets from secrets manager
- change macOS keybindings
  - disable spotlight search
  - alt + q | w | e | r | t to space 1-5
  - disable input source swap keybindings
  - mission control to alt + b
- import `Nix Managed` complex modification in Karabiner
- login to arc and sync settings
- use EURKey as keyboard layout
  - remove default keyboard layout
  - https://superuser.com/questions/712306/remove-keyboard-layout-from-os-x-leaving-custom-layouts-only
- set universalaccess until fixed in darwin
  - reduceMotion
  - recuceTransparency - decide
- configure applications
  - raycast (use import / export)
  - aldente
  - meetingbar
  - hiddenbar
  - time-out
  - apple calender / mail
  - slack / teams / signal
  - arc
- enable icloud sync
- `npm install -g aws-azure-login`
  - enable rosetta
- login to vscode for settings sync
- enable key repeat for vim extension in intellij and vscode
  - `defaults write -g ApplePressAndHoldEnabled -bool false`
- connect bluetooth keyboard and select `disable internal keyboard`

## update

```bash
# all inputs
nix flake update

# single input
nix flake lock --update-input <input>
```
