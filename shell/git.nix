{ ... }: {
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  programs.git = {
    enable = true;
    signing = {
      key = null; # gnupg decides by mail
      signByDefault = false;
    };
    includes = [
      {
        condition = "gitdir:~/code/stackit/";
        contents.user.email = "felix.breuer@stackit.cloud";
      }
      {
        condition = "gitdir:~/code/controlf/";
        contents = {
          commit.gpgSign = false;
          user.email = "felix@controlf.io";
        };
      }
    ];
    # hooks = { prepare-commit-msg = ./rtl-hook.sh; };
    ignores = [
      # ide
      ".idea"
      ".vs"
      ".vsc"
      ".vscode"
      # npm
      "node_modules"
      "npm-debug.log"
      # python
      "__pycache__"
      "*.pyc"

      ".ipynb_checkpoints" # jupyter
      "__sapper__" # svelte
      ".DS_Store" # mac
      "kls_database.db" # kotlin lsp
    ];
    settings = {
      user = {
        name = "Felix Breuer";
        email = "f.breuer94@gmail.com";
      };
      alias = {
        cm = "commit";
        ca = "commit --amend --no-edit";
        co = "checkout";
        si = "switch";
        cp = "cherry-pick";

        di = "diff";
        dh = "diff HEAD";

        pu = "pull";
        ps = "push";
        pf = "push --force-with-lease";

        st = "status -sb";
        fe = "fetch";
        gr = "grep -in";

        ri = "rebase -i";
        rc = "rebase --continue";
      };
      init.defaultBranch = "main";
      pull = {
        ff = false;
        commit = false;
        rebase = true;
      };
      fetch = { prune = true; };
      push.autoSetupRemote = true;
      delta = { line-numbers = true; };
      url = {
        "git@ssh.dev.azure.com:v3" = {
          insteadOf = "https://dev.azure.com";
        };
      };
    };
  };
}
