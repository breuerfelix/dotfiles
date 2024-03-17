{ pkgs, ... }: {
  imports = [
    ./zsh.nix
    ./zellij.nix
    ./git.nix
    ./k9s.nix
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
      gitAndTools.delta # pretty diff tool
      sshfs # mount folders via ssh
      gh # github cli tool
      glab # gitlab cli tool
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
      mongodb-tools
      pulumi-bin # manage infrastructure as code
      viddy # terminal watch command
      unixtools.watch # watches commands
      yq-go # yaml, toml parser
      termdown # terminal countdown
      tmate # share terminal via web
      silicon # create code snippets as images
      crane # container registry tool
      ytt # yaml templating engine
      zk # zettelkasten
      mask # taskrunner
      diskonaut # explore disk size
      gnupg # gpg
      gping # ping with a graph
      ruby # scripting language
      corepack # node wrappers
      redis # to use the cli
      k6 # load testing tool
      slides # terminal presentation tool
      presenterm # presentation tool
      asdf-vm # managing different versions
      docker # container runtime
      comma # run nix binaries on demand
      # TODO: create config file for tabby
      tabby # ai coding assistant

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
      kubectl
      krew # kubectl plugins
      kubie # fzf kubeconfig browser
      kind # k8s in docker
      velero # k8s backup tool
      fluxcd # automation
      kubent # check for deprecations
      termshark # tui for wireshark
      prometheus # prometheus linter
      dyff # better kubectl diff
      kubebuilder # generate controller
      kubernetes-helm # deploy applications

      # cloud
      google-cloud-sdk
      awscli2

      # programming

      ## python
      python3
      poetry # python tools
      rustup # rust

      ## node
      deno # node runtime
      nodejs
      nodePackages.npm
      nodePackages.yarn
      nodePackages.expo-cli

      ## golang
      golangci-lint

      ## kotlin
      ktlint
      kotlin
      gradle
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
      extraPackages = with pkgs; [ nil gopls ];
      settings = {
        theme = "tokyonight";

        keys = {
          insert = { j = { k = "normal_mode"; }; };
          normal = {
            C-e = ":write";
            C-q = ":quit";
          };
        };

        editor = {
          line-number = "relative";
          idle-timeout = 200;
          bufferline = "multiple";
          lsp.display-inlay-hints = true;
          cursor-shape.insert = "bar";
          file-picker.hidden = false;
          whitespace.render = "all";
          indent-guides.render = true;
          statusline = {
            mode = {
              normal = "NORMAL";
              insert = "INSERT";
              select = "SELECT";
            };
          };
        };
      };
    };

    # shell integrations are enabled by default
    zoxide.enable = true; # autojump
    jq.enable = true; # json parser
    bat.enable = true; # pretty cat
    lazygit.enable = true; # git tui
    nnn.enable = true; # file browser
    btop.enable = true; # htop alternative
    nushell.enable = true; # zsh alternative
    broot.enable = true; # browser big folders
    atuin.enable = true; # sqlite browser history

    # pretty prompt
    starship = {
      enable = true;
      settings = {
        add_newline = true;
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[✗](bold red)";
        };
      };
    };

    # pretty ls
    lsd = {
      enable = true;
      enableAliases = true;
    };

    go = {
      enable = true;
      package = pkgs.go_1_22;
      goPath = "go";
      goBin = "go/bin";
      goPrivate = [ ];
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
      defaultCommand =
        "fd --type f --hidden --follow --exclude .git --exclude .vim --exclude .cache --exclude vendor";
      defaultOptions = [
        "--border sharp"
        "--inline-info"
        "--bind ctrl-h:preview-down,ctrl-l:preview-up"
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
      ];
    };
  };
}
