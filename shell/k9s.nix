{ ... }: {
  programs.zsh.shellAliases.ks =
    "XDG_CONFIG_HOME=~/.config XDG_DATA_HOME=~/.config k9s";
  programs.k9s = {
    enable = true;
    settings.k9s = {
      ui = {
        headless = true;
        logoless = true;
        noIcons = true;
      };
      skipLatestRevCheck = true;
    };

    plugin.plugin = {
      modify-secret = {
        shortCut = "Ctrl-X";
        description = "Edit Decoded Secret";
        confirm = false;
        scopes = [ "secrets" ];
        command = "kubectl";
        background = false;
        args = [
          "modify-secret"
          "--context"
          "$CONTEXT"
          "--namespace"
          "$NAMESPACE"
          "$NAME"
        ];
      };

      flux-disable-reconcile = {
        shortCut = "Ctrl-F";
        description = "Disable Flux Reconcile";
        confirm = false;
        scopes = [ "all" ];
        command = "kubectl";
        background = false;
        args = [
          "annotate"
          "--context"
          "$CONTEXT"
          "--namespace"
          "$NAMESPACE"
          "$RESOURCE_NAME"
          "$NAME"
          "kustomize.toolkit.fluxcd.io/reconcile=disabled"
        ];
      };

      flux-enable-reconcile = {
        shortCut = "Ctrl-B";
        description = "Enable Flux Reconcile";
        confirm = false;
        scopes = [ "all" ];
        command = "kubectl";
        background = false;
        args = [
          "annotate"
          "--context"
          "$CONTEXT"
          "--namespace"
          "$NAMESPACE"
          "$RESOURCE_NAME"
          "$NAME"
          "kustomize.toolkit.fluxcd.io/reconcile-"
        ];
      };

    };
  };
}
