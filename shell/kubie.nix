{ ... }: {
  home.file.kubie = {
    target = ".kube/kubie.yaml";
    text = ''
      prompt:
        zsh_use_rps1: true
    '';
  };
}
