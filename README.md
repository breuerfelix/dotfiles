# my dotfiles

## installation

* install nix for macOS
  * `sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume`
  * reboot
  * `nix-channel --add https://github.com/LnL7/nix-darwin/archive/master.tar.gz darwin`
  * `nix-channel --update`
  * `nix-shell '<darwin>' -A installer`
  * `darwin-rebuild switch`

* install these dotfiles
  * `git clone https://github.com/breuerfelix/dotfiles.git ~/.nixpkgs`
  * `darwin-rebuild switch`

## content

- distro: macOS
- window manager: yabai
- bar: spacebar
- terminal: alacritty + tmux
- shell: zsh + pretzo
- editor: neovim
