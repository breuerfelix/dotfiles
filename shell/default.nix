{ config, pkgs, lib, inputs, system, ... }: {
  imports = [
    ./zsh.nix
    ./adblock.nix
    ./tmux.nix
    ./zellij.nix
    ./git.nix
    ./k9s.nix
    #./krew.nix
  ];

  home = {
    packages = with pkgs; [
      neovim # customized by overlay

      # net tools
      #bind # marked as broken
      nmap
      inetutils

      # core
      openssl
      wget
      curl
      fd
      ripgrep # fast search

      # htop alternatives
      bottom
      btop
      #gotop # TODO fix

      comma # nix-shell wrapper
      grc # colored log output
      gitAndTools.delta # pretty diff tool
      thefuck # auto correct commands
      sshfs # mount folders via ssh
      gh # github cli tool
      graph-easy # draw graphs in the terminal
      cht-sh # cheat sheet -> cht python read file
      tealdeer # community driven man pages
      dive # analyse docker images
      hyperfine # benchmark tool
      sipcalc # ip subnet calculator
      youtube-dl # download youtube videos
      ffmpeg # video editing and cutting
      rclone # sync files
      duf # disk usage
      httpie # awesome alternative to curl
      bitwarden-cli
      mongodb-tools
      terraform
      terragrunt
      pulumi-bin # manage infrastructure as code
      nodePackages.snyk # vulnerability scanner
      viddy # terminal watch command
      unixtools.watch # watches commands
      yq-go # yaml, toml parser
      termdown # terminal countdown
      tmate # share terminal via web
      silicon # create code snippets as images
      crane # container registry tool
      ytt # yaml templating engine

      # shells
      nushell # new type of shell
      mosh # alternative ssh shell

      # golang utils
      golangci-lint

      # gnu binaries
      coreutils-full # installs some gnu versions of linux bins
      gnutar
      gnused
      gnugrep
      gnumake
      gzip
      findutils
      gawk

      # k8s stuff
      kubectl
      krew
      k9s
      kubie
      kind
      kubelogin-oidc
      velero # k8s backup tool
      fluxcd # automation

      # programming
      python3
      poetry # python tools
      rustup # rust
      deno # node runtime
      nodejs
      nodePackages.npm
      nodePackages.yarn
      nodePackages.expo-cli

      starship # terminal prompt
      slides # terminal presentation tool

      # custom nixFlakes command for home-manager standalone
      (pkgs.writeShellScriptBin "nx" ''
        exec ${pkgs.nixFlakes}/bin/nix --experimental-features "nix-command flakes" "$@"
      '')
    ];

    sessionPath = [
      "$HOME/go/bin"
      "$HOME/.local/bin"
      "$HOME/.cargo/bin"
      "$HOME/.krew/bin"
    ];
    sessionVariables = {
      GO111MODULE = "on";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  programs = {
    # let home-manager manage itself
    home-manager.enable = true;

    # vim alternative
    helix = {
      enable = true;
    };

    # shell integrations are enabled by default
    zoxide.enable = true; # autojump
    jq.enable = true; # json parser
    bat.enable = true; # pretty cat
    lazygit.enable = true; # git tui
    nnn.enable = true; # file browser

    # pretty ls
    lsd = {
      enable = true;
      enableAliases = true;
    };

    go = {
      enable = true;
      package = pkgs.go_1_19;
      goPath = "go";
      goBin = "go/bin";
      goPrivate = [ "github.com/stackitcloud" ];
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
      defaultCommand = "fd --type f --hidden --follow --exclude .git --exclude .vim --exclude .cache --exclude vendor";
      defaultOptions = [
        "--border sharp"
        "--inline-info"
        "--bind ctrl-h:preview-down,ctrl-l:preview-up"
      ];
    };

    # snippet manager
    pet = {
      enable = true;
      snippets = [
        {
          description = "show short git rev";
          command = "git rev-parse --short HEAD";
          output = "888c0f8";
        }
        {
          description = "garden kubeconfig from ske-ci ondemand cluster";
          command = "kubectl get secret garden-kubeconfig-for-admin -n garden -o jsonpath='{.data.kubeconfig}' | base64 -d > garden-kubeconfig-for-admin.yaml";
        }
      ];
    };
  };
}
