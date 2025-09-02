{ ... }: {
  # otherwhise k9s is not able to locate the config
  programs.zsh.shellAliases.ks = "k9s";
  programs.k9s = {
    enable = true;
    settings.k9s = {
      ui = {
        headless = true;
        logoless = true;
        noIcons = true;
        skin = "catppuccin-mocha";
      };
      skipLatestRevCheck = true;
    };

    skins = {
      catppuccin-mocha = ./k9s-catppuccin-mocha.yaml;
    };

    plugins = {
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

      fblog-pod = {
        shortCut = "Shift-L";
        confirm = false;
        description = "fblog";
        scopes = [ "pods" ];
        command = "sh";
        background = false;
        args = [ "-c" "kubectl logs --follow -n $NAMESPACE $NAME | fblog" ];
      };

      fblog-container = {
        shortCut = "Shift-L";
        confirm = false;
        description = "fblog";
        scopes = [ "containers" ];
        command = "sh";
        background = false;
        args = [ "-c" "kubectl logs --follow -n $NAMESPACE $POD -c $NAME | fblog" ];
      };

      fblog-pod-all = {
        shortCut = "Shift-K";
        confirm = false;
        description = "fblog -d";
        scopes = [ "pods" ];
        command = "sh";
        background = false;
        args = [ "-c" "kubectl logs --follow -n $NAMESPACE $NAME | fblog -d" ];
      };

      fblog-container-all = {
        shortCut = "Shift-K";
        confirm = false;
        description = "fblog -d";
        scopes = [ "containers" ];
        command = "sh";
        background = false;
        args = [ "-c" "kubectl logs --follow -n $NAMESPACE $POD -c $NAME | fblog -d" ];
      };
    };
  };
}
