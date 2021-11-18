{ config, pkgs, lib, ... }: {
  home.file.starship = {
    target = ".config/starship.toml";
    text = ''
      #add_newline = false

      [character]
      success_symbol = "[➜](bold green) "
      error_symbol = "[✗](bold red) "
    '';
  };

  home.file.kubie = {
    target = ".kube/kubie.yaml";
    text = ''
      prompt:
        zsh_use_rps1: true
    '';
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    # TODO reenable when issue is fixed
    # https://github.com/NixOS/nix/issues/5445
    enableCompletion = false;
    autocd = true;
    dotDir = ".config/zsh";
    #defaultKeymap = ""; #vicmd or viins

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = false;
      save = 20000;
      size = 20000;
      share = true;
    };

    initExtra = ''
      path+=$HOME/.local/bin
      #source /secrets/environment.bash

      # make libgc++ available in the terminal
      export LD_LIBRARY_PATH=${lib.makeLibraryPath [pkgs.stdenv.cc.cc]}

      bindkey '^e' edit-command-line
      bindkey '^ ' autosuggest-accept
      bindkey '^k' up-line-or-search
      bindkey '^j' down-line-or-search

      bindkey '^r' fzf-history-widget
      bindkey '^f' fzf-file-widget

      function cd() {
          builtin cd $*
          lsd
      }

      function mkd() {
          mkdir $1
          builtin cd $1
      }

      function take() { builtin cd $(mktemp -d) }
      function vit() { nvim $(mktemp) }

      function lgc() { git commit --signoff -m "$*" }

      function clone() { git clone git@$1.git }

      function gclone() { clone github.com:$1 }

      function bclone() { gclone breuerfelix/$1 }

      function gsm() { git submodule foreach "$* || :" }

      function lg() {
          git add --all
          git commit --signoff -a -m "$*"
          git push
      }

      function dci() { docker inspect $(docker-compose ps -q $1) }

      # shell completions
      # TODO test this
      . <(kubebuilder completion zsh)
    '';

    dirHashes = {
      dl = "$HOME/Downloads";
      nix = "$HOME/.nixpkgs";
      code = "$HOME/code";
    };

    shellAliases = {
      # builtins
      size = "du -sh";
      cp = "cp -i";
      mkdir = "mkdir -p";
      df = "df -h";
      free = "free -h";
      du = "du -sh";
      susu = "sudo su";
      op = "xdg-open";
      del = "rm -rf";
      sdel = "sudo rm -rf";
      lst = "ls --tree -I .git";
      lsl = "ls -l";
      lsa = "ls -a";
      null = "/dev/null";
      tmux = "tmux -u";
      tu = "tmux";

      # overrides
      cat = "bat";
      ssh = "TERM=screen ssh";
      python = "python3";
      pip = "python3 -m pip";
      venv = "python3 -m venv";

      # programs
      g = "git";
      kc = "kubectl";
      ku = "kubie";
      dk = "docker";
      dc = "docker-compose";
      pd = "podman";
      pc = "podman-compose";
      sc = "sudo systemctl";
      poe = "poetry";
      fb = "pcmanfm .";
      space = "ncdu";
      ca = "cargo";
      tf = "terraform";
      diff = "delta";
      nr = "npm run";
      py = "python";
      awake = "caffeinate";

      # terminal cheat sheet
      cht = "cht.sh";
      # lists node_modules folder and their size
      npkill = "npx npkill";

      # utilities
      psf = "ps -aux | grep";
      lsf = "ls | grep";
      search = "sudo fd . '/' | grep"; # TODO replace with ripgrep
      shut = "sudo shutdown -h now";
      tssh = "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null";
      socks = "ssh -D 1337 -q -C -N";

      # clean
      dklocal = "docker run --rm -it -v `PWD`:/usr/workdir --workdir=/usr/workdir";
      dkclean = "docker container rm $(docker container ls -aq)";

      caps = "xdotool key Caps_Lock";
      gclean = "git fetch -p && for branch in $(git branch -vv | grep ': gone]' | awk '{print $1}'); do git branch -D $branch; done";
      ew = "nvim -c ':cd ~/vimwiki' ~/vimwiki";
      weather = "curl -4 http://wttr.in/Koeln";

      # nix
      ne = "nvim -c ':cd ~/.nixpkgs' ~/.nixpkgs";
      nb = "darwin-rebuild switch";
      nbu = "nix-channel --update && darwin-rebuild switch";
      #clean = "rm -rf ~/.Trash/* && nix-collect-garbage"; # TODO empty bin
      clean = "nix-collect-garbage";
      nsh = "nix-shell";
      nbh = "LD_LIBRARY_PATH= home-manager switch";
      nbhu = "LD_LIBRARY_PATH= nix-channel --update && LD_LIBRARY_PATH= home-manager switch";

      aupt = "sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y";
    };

    plugins = [
      {
        name = "fast-syntax-highlighting";
        file = "fast-syntax-highlighting.plugin.zsh";
        src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
      }
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = "${pkgs.zsh-nix-shell}/share/zsh-nix-shell";
      }
      {
        name = "forgit";
        file = "forgit.plugin.zsh";
        src = "${pkgs.forgit}/share/forgit";
      }
    ];
    prezto = {
      enable = true;
      caseSensitive = false;
      utility.safeOps = true;
      editor = {
        dotExpansion = true;
        keymap = "vi";
      };
      python = {
        virtualenvInitialize = true;
        virtualenvAutoSwitch = true;
      };

      pmodules = [
        "autosuggestions"
        "completion"
        "directory"
        "editor"
        "git"
        "terminal"
      ];
    };
  };
}
