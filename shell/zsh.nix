{ config, pkgs, lib, ... }: {
  home.file.starship = {
    target = ".config/starship.toml";
    text = ''
      #add_newline = false
      command_timeout = 2000

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
    enableCompletion = true;
    autocd = true;
    dotDir = ".config/zsh";
    #defaultKeymap = "viins"; #vicmd or viins

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      NIXPKGS_ALLOW_UNFREE = "1";
    };

    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true; # ignore commands starting with a space
      save = 20000;
      size = 20000;
      share = true;
    };

    initExtra = ''
      #export LD_LIBRARY_PATH=${lib.makeLibraryPath [pkgs.stdenv.cc.cc]}

      # TODO: handle secrets somehow
      #source /secrets/environment.bash

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

      function gitdel() {
        git tag -d $1
        git push --delete origin $1
      }

      function lg() {
        git add --all
        git commit --signoff -a -m "$*"
        git push
      }

      function dci() { docker inspect $(docker-compose ps -q $1) }

      function transfer() {
        wget --method PUT --body-file=$1 https://up.fbr.ai/$1 -O - -nv
      }

      function nf() {
        pushd ~/.nixpkgs
        nix --experimental-features "nix-command flakes" build ".#darwinConfigurations.alucard.system"
        ./result/sw/bin/darwin-rebuild switch --flake ~/.nixpkgs
      }

      function nfh() {
        pushd ~/.config/nixpkgs
        nix --experimental-features "nix-command flakes" build ".#homeConfigurations.solid.activationPackage"
        ./result/activate
      }
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
      tu = "tmux -u";
      tua = "tmux a -t";

      # overrides
      cat = "bat";
      ssh = "TERM=screen ssh";
      python = "python3";
      pip = "python3 -m pip";
      venv = "python3 -m venv";
      j = "z";

      # programs
      g = "git";
      kc = "kubectl";
      ks = "k9s";
      ku = "kubie";
      dk = "docker";
      dc = "docker-compose";
      pd = "podman";
      pc = "podman-compose";
      li = "lima nerdctl";
      lc = "limactl";
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
      os = "openstack";

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
      clean = "nix-collect-garbage -d && nix-store --gc && nix-store --verify --check-contents --repair";
      nsh = "nix-shell";
      "," = "nix-shell -p";

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
      #prompt.showReturnVal = true;
      #tmux.autoStartLocal = true;
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
