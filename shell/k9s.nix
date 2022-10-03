{ config, pkgs, lib, ... }: {
  home.file.k9s = {
    target = ".config/k9s/plugin.yml";
    text = ''
      plugin:
        edit-secret:
          shortCut: Ctrl-X
          confirm: false
          description: "Edit Decoded Secret"
          scopes:
            - secrets
          command: kubectl
          background: false
          args:
            - modify-secret
            - --namespace
            - $NAMESPACE
            - --context
            - $CONTEXT
            - $NAME

        reconcile:
          shortCut: r
          confirm: false
          description: "Reconcile resource"
          scopes:
            - shoots
            # all resources in extensions.gardener.cloud/v1alpha1
            - backupbuckets
            - backupentries
            - bastions
            - clusters
            - containerruntimes
            - controlplanes
            - dnsrecords
            - extensions
            - infrastructures
            - networks
            - operatingsystemconfigs
            - workers
          command: kubectl
          background: true
          args:
            - --namespace
            - $NAMESPACE
            - --context
            - $CONTEXT
            - annotate
            - $RESOURCE_NAME
            - $NAME
            - gardener.cloud/operation=reconcile

        reconcile-seed:
          shortCut: r
          confirm: false
          description: "Reconcile seed"
          scopes:
            - managedseeds
          command: kubectl
          background: true
          args:
            - --context
            - $CONTEXT
            - annotate
            - $RESOURCE_NAME
            - $NAME
            - gardener.cloud/operation=reconcile

        retry-shoot:
          shortCut: t
          confirm: false
          description: "Retry shoot operation"
          scopes:
            - shoots
          command: kubectl
          background: true
          args:
            - --namespace
            - $NAMESPACE
            - --context
            - $CONTEXT
            - annotate
            - $RESOURCE_NAME
            - $NAME
            - gardener.cloud/operation=retry
    '';
  };
}
