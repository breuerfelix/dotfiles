{ ... }: {
  programs.zellij = { enable = true; };

  # NOTE: the module only supports YAML config which is deprecated
  home.file.zellij = {
    target = ".config/zellij/config.kdl";
    text = ''
      simplified_ui true
      default_layout "compact"
      keybinds clear-defaults=true {
        normal {
          bind "Ctrl o" { SwitchToMode "tmux"; }
        }
        tmux {
          bind "Ctrl o" { SwitchToMode "Normal"; }
          bind "Esc" { SwitchToMode "Normal"; }

          bind "Ctrl e" { WriteChars "vi ."; Write 13; SwitchToMode "Normal"; }
          bind "Ctrl r" { WriteChars "kubie ctx"; Write 13; SwitchToMode "Normal"; }

          bind "Ctrl u" { CloseFocus; SwitchToMode "Normal"; }
          bind "z" { ToggleFocusFullscreen; SwitchToMode "Normal"; }
          bind "d" { Detach; }
          bind "s" { ToggleActiveSyncTab; SwitchToMode "Normal"; }

          bind "h" { MoveFocus "Left"; SwitchToMode "Normal"; }
          bind "l" { MoveFocus "Right"; SwitchToMode "Normal"; }
          bind "j" { MoveFocus "Down"; SwitchToMode "Normal"; }
          bind "k" { MoveFocus "Up"; SwitchToMode "Normal"; }

          bind "y" { NewPane "Down"; SwitchToMode "Normal"; }
          bind "n" { NewPane "Right"; SwitchToMode "Normal"; }

          bind "c" { NewTab; SwitchToMode "Normal"; }
          bind "Ctrl l" { GoToNextTab; SwitchToMode "Normal"; }
          bind "Ctrl h" { GoToPreviousTab; SwitchToMode "Normal"; }
        }
      }

      theme "catppuccin-mocha"

      themes {
        tokyo-night-dark {
          fg 169 177 214
          bg 26 27 38
          black 56 62 90
          red 249 51 87
          green 158 206 106
          yellow 224 175 104
          blue 122 162 247
          magenta 187 154 247
          cyan 42 195 222
          white 192 202 245
          orange 255 158 100
        }

        catppuccin-mocha {
          bg "#585b70" // Surface2
          fg "#cdd6f4" // Text
          red "#f38ba8"
          green "#a6e3a1"
          blue "#89b4fa"
          yellow "#f9e2af"
          magenta "#f5c2e7" // Pink
          orange "#fab387" // Peach
          cyan "#89dceb" // Sky
          black "#181825" // Mantle
          white "#cdd6f4" // Text
        }
      }
    '';
  };
}
