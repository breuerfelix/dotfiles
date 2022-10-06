inputs: self: super: {
  forgit = self.stdenvNoCC.mkDerivation rec {
    name = "forgit";
    src = inputs.forgit;

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      plugindir="$out/share/forgit"
      mkdir -p "$plugindir"
      cp -r * "$plugindir"/
    '';

    meta = with self.lib; {
      description =
        "A utility tool powered by fzf for using git interactively.";
      homepage = "https://github.com/wfxr/forgit";
      license = licenses.mit;
      platforms = platforms.unix;
    };
  };
}
