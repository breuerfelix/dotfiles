inputs: self: super:
let
  vars = import ../desktop/constants.nix;
  materia_colors = self.pkgs.writeTextFile {
    name = "gtk-generated-colors";
    text = with vars.colors; ''
      BTN_BG=${base02}
      BTN_FG=${base06}

      FG=${base05}
      BG=${base00}

      HDR_BTN_BG=${base01}
      HDR_BTN_FG=${base05}

      ACCENT_BG=${base0B}
      ACCENT_FG=${base00}

      HDR_FG=${base05}
      HDR_BG=${base02}

      MATERIA_SURFACE=${base02}
      MATERIA_VIEW=${base01}

      MENU_BG=${base02}
      MENU_FG=${base06}

      SEL_BG=${base0D}
      SEL_FG=${base0E}

      TXT_BG=${base02}
      TXT_FG=${base06}

      WM_BORDER_FOCUS=${base05}
      WM_BORDER_UNFOCUS=${base03}

      UNITY_DEFAULT_LAUNCHER_STYLE=False
      NAME=generated
      MATERIA_COLOR_VARIANT=dark
      MATERIA_STYLE_COMPACT=True
    '';
  };
in
{
  rendersvg = self.runCommand "rendersvg" { } ''
    mkdir -p $out/bin
    ln -s ${self.resvg}/bin/resvg $out/bin/rendersvg
  '';

  generated-gtk-theme = self.stdenv.mkDerivation rec {
    name = "generated-gtk-theme";
    src = inputs.materia-theme;
    buildInputs = with self; [
      sassc
      bc
      which
      rendersvg
      meson
      ninja
      nodePackages.sass
      gtk4.dev
      optipng
    ];
    MATERIA_COLORS = materia_colors;
    phases = [ "unpackPhase" "installPhase" ];
    installPhase = ''
      HOME=/build
      chmod 777 -R .
      patchShebangs .
      mkdir -p $out/share/themes
      mkdir bin
      sed -e 's/handle-horz-.*//' -e 's/handle-vert-.*//' -i ./src/gtk-2.0/assets.txt
      echo "Changing colours:"
      ./change_color.sh -o Generated "$MATERIA_COLORS" -i False -t "$out/share/themes"
      chmod 555 -R .
    '';
  };
}
