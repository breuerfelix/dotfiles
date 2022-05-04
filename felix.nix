{ config, pkgs, lib, ... }: {
  imports = [
    ./zsh.nix
    ./adblock.nix
    ./tmux.nix
    ./git.nix
    ./k9s.nix
    ./krew.nix
    ./vim
  ];

  home = {
    stateVersion = "21.11";
    packages = with pkgs; [
      # terminal
      bottom # htop alternatives
      #btop 
      fd ripgrep # fast search
      gitAndTools.delta # pretty diff tool
      wget curl
      thefuck # auto correct commands
      sshfs # mount folders via ssh
      gh # github cli tool
      # TODO m1 mac ttyd # terminal share via web
      graph-easy # draw graphs in the terminal
      unixtools.watch # watches commands
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
      pulumi-bin # manage infrastructure as code
      mosh # alternative ssh shell

      # gnu binaries
      coreutils-full # installs some gnu versions of linux bins
      gnutar gnused gnugrep gnumake # linux implementation of tar
      findutils
      gawk

      # k8s stuff
      kubectl krew k9s kubie kind
      kubelogin-oidc
      velero # k8s backup tool

      #podman # TODO installed via brew - cannot be installed via nix right now

      python3 poetry # python tools
      rustup # rust
      deno # node runtime

      starship # terminal prompt
      slides # terminal presentation tool

      (pkgs.writeShellScriptBin "nixFlakes" ''
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

    # shell integrations are enabled by default
    zoxide.enable = true;
    jq.enable = true;

    lsd = {
      enable = true;
      enableAliases = true;
    };

    bat = {
      enable = true;
      # TODO check if theme gets picked up
      #config = { theme = "base16"; };
    };

    lazygit = {
      enable = true;
    };

    go = {
      enable = true;
      package = pkgs.go_1_18;
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
