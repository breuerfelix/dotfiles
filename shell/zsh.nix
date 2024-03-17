{ pkgs, pkgs-zsh-fzf-tab, ... }: {
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
    enableCompletion = false;
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
      # fixes starship swallowing newlines
      precmd() {
        precmd() {
          echo
        }
      }

      # used for homebrew
      export XDG_DATA_DIRS=$XDG_DATA_DIRS:/opt/homebrew/share

      # better kubectl diff
      export KUBECTL_EXTERNAL_DIFF="dyff between --omit-header --set-exit-code"

      # used for RTL AWS login
      [ -f ~/.aws/env.sh ] && source ~/.aws/env.sh

      source ${pkgs.asdf-vm}/share/asdf-vm/asdf.sh
      eval "$(/opt/homebrew/bin/brew shellenv)"

      bindkey '^e' edit-command-line
      # this is backspace
      bindkey '^H' autosuggest-accept
      bindkey '^ ' autosuggest-accept

      bindkey '^k' up-line-or-search
      bindkey '^j' down-line-or-search

      bindkey '^f' fzf-file-widget

      function lmr () {
        TICKET=$(git branch --show-current | grep -E -i -o '(contract-)?[0-9]{4,}' | tr '[:lower:]' '[:upper:]')
        glab mr create --yes --remove-source-branch --title="$* - CONTRACT-$TICKET"
      }

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

      function pfusch() {
        git add --all
        git commit --amend --no-edit
        git push --force-with-lease
      }

      function dci() { docker inspect $(docker-compose ps -q $1) }

      function nf() {
        pushd ~/.nixpkgs
        nix --experimental-features "nix-command flakes" build ".#darwinConfigurations.brummi.system"
        ./result/sw/bin/darwin-rebuild switch --flake ~/.nixpkgs
      }

      function nfh() {
        pushd ~/.config/nixpkgs
        nix --experimental-features "nix-command flakes" build ".#homeConfigurations.solid.activationPackage"
        ./result/activate
      }

      function nfs() {
        pushd ~/.config/nixpkgs
        sudo nixos-rebuild switch --flake ".#rocky"
      }

      # RTL
      function expose-customer() {
        (
          kubectl port-forward deployment/subscriptions 8080:8080 &
          kubectl port-forward deployment/credits 8081:8080 &
          kubectl port-forward deployment/customer-care-subscriptions 8082:8080 &
          kubectl port-forward deployment/customer365 8083:8080 &
          kubectl port-forward deployment/scoring 8084:8080 &
          kubectl port-forward deployment/trialfraud 8085:8080 &

          echo "Press CTRL-C to stop port forwarding"
          wait
        )
      }
    '';

    dirHashes = {
      dl = "$HOME/Downloads";
      code = "$HOME/code";
    };

    # TODO: move to home.shellAliases
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

      # overrides
      cat = "bat";
      htop = "btop";
      ping = "gping";
      ssh = "TERM=screen ssh";
      python = "python3";
      pip = "python3 -m pip";
      venv = "python3 -m venv";
      j = "z";

      # programs
      g = "git";
      kc = "kubectl";
      k = "kubectl";
      kca = "kubectl apply -f";
      ku = "kubie";
      dk = "docker";
      dc = "docker-compose";
      pd = "podman";
      pc = "podman-compose";
      cod = "colima start --runtime docker";
      coc = "colima start --runtime containerd";
      cos = "colima stop";
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
      pu = "pulumi";

      # terminal cheat sheet
      cht = "cht.sh";
      # lists node_modules folder and their size
      npkill = "npx npkill";

      # utilities
      psf = "ps -aux | grep";
      lsf = "ls | grep";
      shut = "sudo shutdown -h now";
      tssh = "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null";
      socks = "ssh -D 1337 -q -C -N";
      prox =
        "export http_proxy=socks5://127.0.0.1:1337 https_proxy=socks5://127.0.0.1:1337";

      # clean
      dklocal =
        "docker run --rm -it -v `PWD`:/usr/workdir --workdir=/usr/workdir";
      dkclean = "docker container rm $(docker container ls -aq)";

      caps = "xdotool key Caps_Lock";
      gclean =
        "git fetch -p && for branch in $(git branch -vv | grep ': gone]' | awk '{print $1}'); do git branch -D $branch; done";
      ew = "nvim -c ':cd ~/vimwiki' ~/vimwiki";
      weather = "curl -4 http://wttr.in/Koeln";

      # nix
      ne = "nvim -c ':cd ~/.nixpkgs' ~/.nixpkgs";
      clean =
        "nix-collect-garbage -d && nix-store --gc && nix-store --verify --check-contents --repair";
      nsh = "nix-shell";
      nse = "nix search nixpkgs";

      aupt = "sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y";
    };

    plugins = [
      {
        name = "fast-syntax-highlighting";
        src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
      }
      {
        name = "zsh-nix-shell";
        src = "${pkgs.zsh-nix-shell}/share/zsh-nix-shell";
      }
      {
        name = "forgit";
        src = "${pkgs.zsh-forgit}/share/zsh/zsh-forgit";
      }
      {
        name = "fzf-tab";
        src = "${pkgs-zsh-fzf-tab.zsh-fzf-tab}/share/fzf-tab";
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
      pmodules = [ "autosuggestions" "directory" "editor" "git" "terminal" ];
    };
  };
}
