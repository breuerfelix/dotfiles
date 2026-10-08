{ pkgs, unstable, user, ... }: {
  imports = [
    ./zsh.nix
    ./zellij.nix
    ./tmux.nix
    ./git.nix
    ./k9s.nix
    ./kubie.nix
    #./krew.nix
  ];

  home = {
    packages = with pkgs; [
      neovim # customized by overlay

      # net tools
      bind
      nmap
      inetutils

      # core
      openssl
      wget
      curl
      fd
      ripgrep # fast search

      grc # colored log output
      sshfs # mount folders via ssh
      gh # github cli tool
      graph-easy # draw graphs in the terminal
      dive # analyse docker images
      hyperfine # benchmark tool
      sipcalc # ip subnet calculator
      ffmpeg # video editing and cutting
      rclone # sync files
      duf # disk usage
      httpie # awesome alternative to curl
      pulumi-bin # manage infrastructure as code
      viddy # terminal watch command
      unixtools.watch # watches commands
      yq-go # yaml, toml parser
      silicon # create code snippets as images
      crane # container registry tool
      ytt # yaml templating engine
      zk # zettelkasten
      gnupg # gpg
      gping # ping with a graph
      ruby # scripting language
      redis # to use the cli
      k6 # load testing tool
      slides # terminal presentation tool
      presenterm # presentation tool
      comma # run nix binaries on demand
      fblog # json log viewer
      procs # better ps
      mob # mob programming tool

      # lsps
      jsonnet-language-server # grafana lsp, used for screeps

      # gnu binaries
      coreutils-full # multiple tools
      gnutar
      gnused
      gnugrep
      gnumake
      gzip
      findutils
      gawk

      # kubernetes stuff
      docker-compose
      kubectl
      kubelogin # oidc login azure
      krew # kubectl plugins
      kubie # fzf kubeconfig browser
      kind # k8s in docker
      velero # k8s backup tool
      fluxcd # automation
      kubent # check for deprecations
      prometheus # prometheus linter
      kubebuilder # generate controller
      kubernetes-helm # deploy applications

      # cloud
      openstackclient
      s3cmd

      # programming

      ## python
      poetry # python tools
      rustup # rust
      uv # workspace management tool

      ## golang
      golangci-lint
    ];

    # enable integrations
    shell.enableZshIntegration = true;
    shellAliases = {
      # builtins
      size = "du -sh";
      cp = "cp -i";
      mkdir = "mkdir -p";
      df = "df -h";
      free = "free -h";
      du = "du -sh";
      del = "rm -rf";
      lst = "ls --tree -I .git";
      lsl = "ls -l";
      lsa = "ls -a";
      null = "/dev/null";

      # overrides
      cat = "bat";
      top = "btop";
      htop = "btop";
      ping = "gping";
      diff = "delta";
      ssh = "TERM=screen ssh";
      python = "python3";
      pip = "python3 -m pip";
      venv = "python3 -m venv";
      j = "z";
      ji = "zi";

      # programs
      g = "git";
      k = "kubectl";
      d = "docker";
      kca = "kubectl apply -f";
      dc = "docker-compose";
      poe = "poetry";
      tf = "terraform";
      nr = "npm run";
      py = "python";
      pu = "pulumi";
    };

    sessionPath = [
      "$HOME/go/bin"
      "$HOME/.local/bin"
      "$HOME/.cargo/bin"
      "$HOME/.krew/bin"
      "$HOME/.npm-global/bin"
      "/opt/homebrew/bin"
    ];

    sessionVariables = {
      GO111MODULE = "on";
      GOPRIVATE = "github.com/stackitcloud,dev.azure.com/*";
      EDITOR = "nvim";
      VISUAL = "nvim";
      NIXPKGS_ALLOW_UNFREE = "1";
      PULUMI_CONFIG_PASSPHRASE = "";
      COREPACK_ENABLE_AUTO_PIN = "0";
      HOMEBREW_NO_AUTO_UPDATE = "1";
      K9S_FEATURE_GATE_NODE_SHELL = "true";
      SSH_AUTH_SOCK = "/Users/${user}/.bitwarden-ssh-agent.sock";
    };
  };

  programs = {
    # let home-manager manage itself
    home-manager.enable = true;

    # shell integrations are enabled by default
    nushell.enable = true; # zsh alternative
    zoxide.enable = true; # autojump
    jq.enable = true; # json parser
    bat.enable = true; # pretty cat
    lazygit.enable = true; # git tui
    # file browser
    yazi = {
      enable = true;
      shellWrapperName = "y";
    };
    btop.enable = true; # htop alternative
    broot.enable = true; # browser big folders
    carapace.enable = true; # autocompletion
    lsd.enable = true; # pretty ls
    mise.enable = true; # version manager for tools like node or python
    direnv.enable = true; # environment switcher

    # sqlite browser history
    atuin = {
      enable = false;
      flags = [ "--disable-up-arrow" ];
      settings = {
        inline_height = 20;
        style = "compact";
      };
    };

    # pretty prompt
    starship = {
      enable = true;
      settings = {
        add_newline = false;
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[✗](bold red)";
        };
      };
    };

    htop = {
      enable = true;
      settings = {
        tree_view = true;
        show_cpu_frequency = true;
        show_cpu_usage = true;
        show_program_path = false;
      };
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
      #historyWidget.command = "";
      defaultCommand =
        "fd --type f --hidden --follow --exclude .git --exclude .vim --exclude .cache --exclude vendor --exclude node_modules";
      defaultOptions = [
        "--border sharp"
        "--inline-info"
      ];
    };

    # snippet manager
    pet = {
      enable = true;
      # <param=default-value> -> use variables
      snippets = [
        {
          command = "git rev-parse --short HEAD";
          description = "show short git rev";
          output = "888c0f8";
          tag = [ "git" ];
        }
        {
          description = "show size of a folder";
          command = "du -hs <folder>";
        }
        {
          description = "garden kubeconfig from ske-ci ondemand cluster";
          command =
            "kubectl get secret garden-kubeconfig-for-admin -n garden -o jsonpath='{.data.kubeconfig}' | base64 -d > garden-kubeconfig-for-admin.yaml";
        }
        {
          description = "get all images used in a kubernetes cluster";
          command =
            "kubectl get pods --all-namespaces -o jsonpath=\"{.items[*].spec['initContainers', 'containers'][*].image}\" | tr -s '[[:space:]]' '\n' | sort | uniq -c";
        }
      ];
    };
  };
}
