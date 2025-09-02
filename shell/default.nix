{ pkgs, unstable, ... }: {
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

      # terminal
      # TODO: currently broken
      #unstable.ghostty

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
      yt-dlp # download youtube videos
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
      gnupg # gpg
      gping # ping with a graph
      ruby # scripting language
      corepack # node wrappers
      redis # to use the cli
      k6 # load testing tool
      slides # terminal presentation tool
      presenterm # presentation tool
      asdf-vm # managing different versions
      comma # run nix binaries on demand
      sshuttle # vpn over ssh
      fblog # json log viewer
      terraform
      opentofu
      putty # for kubernetes training
      procs # better ps
      mob # mob programming tool
      claude-code # ai cli tool

      # work
      kafkactl # kafka
      openconnect # cli vpn client
      jira-cli-go # jira cli

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
      kubelogin # oidc login azure
      krew # kubectl plugins
      kubie # fzf kubeconfig browser
      kind # k8s in docker
      velero # k8s backup tool
      fluxcd # automation
      kubent # check for deprecations
      termshark # tui for wireshark
      prometheus # prometheus linter
      kubebuilder # generate controller
      kubernetes-helm # deploy applications

      # cloud
      google-cloud-sdk
      awscli2
      # TODO: compile fails
      #azure-cli
      openstackclient
      s3cmd

      # programming

      ## python
      python3
      poetry # python tools # TODO tests failing
      rustup # rust
      uv # workspace management tool

      ## node
      deno # node runtime
      # FIXME: is compiling from scratch
      #nodejs
      #nodePackages.npm

      ## golang
      golangci-lint
      cue

      ## kotlin
      ktlint
      kotlin
      gradle
    ];

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
      cht = "cht.sh"; # terminal cheat sheet
      kapitan = "docker run -t --rm -v $(pwd):/src:delegated kapicorp/kapitan";
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
      EDITOR = "nvim";
      VISUAL = "nvim";
      NIXPKGS_ALLOW_UNFREE = "1";
      PULUMI_CONFIG_PASSPHRASE = "";
      COREPACK_ENABLE_AUTO_PIN = "0";
      # TODO: do not use hardcoded path
      # somehow ~/ or $HOME does not work
      SSH_AUTH_SOCK = "/Users/felix/.bitwarden-ssh-agent.sock";
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
            C-m = ":write";
            C-p = ":quit";
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
    nushell.enable = true; # zsh alternative
    zoxide.enable = true; # autojump
    jq.enable = true; # json parser
    bat.enable = true; # pretty cat
    lazygit.enable = true; # git tui
    yazi.enable = true; # file browser
    btop.enable = true; # htop alternative
    broot.enable = true; # browser big folders
    carapace.enable = true; # autocompletion
    lsd.enable = true; # pretty ls

    # sqlite browser history
    atuin = {
      enable = true;
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

    go = {
      enable = true;
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
