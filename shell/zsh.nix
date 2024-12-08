{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = false;
    autocd = true;
    autosuggestion.enable = true;

    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true; # ignore commands starting with a space
      save = 20000;
      size = 20000;
      share = true;
    };

    initExtra = ''
      [ -f ~/.env/env.sh ] && source ~/.env/env.sh

      # used for homebrew
      export XDG_DATA_DIRS=$XDG_DATA_DIRS:/opt/homebrew/share

      # better kubectl diff
      export KUBECTL_EXTERNAL_DIFF="${pkgs.dyff}/bin/dyff between --omit-header --set-exit-code"

      # used for RTL AWS login
      [ -f ~/.aws/env.sh ] && source ~/.aws/env.sh

      # asdf slows down my terminal start a lot
      #source ${pkgs.asdf-vm}/share/asdf-vm/asdf.sh

      bindkey '^w' edit-command-line
      bindkey '^ ' autosuggest-accept
      bindkey '^p' history-search-backward
      bindkey '^n' history-search-forward
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

      function gclone() { git clone $(pbpaste) }
      function gsm() { git submodule foreach "$* || :" }
      function lgc() { git commit --signoff -m "$*" }
      function lg() {
        git add --all
        git commit --signoff -a -m "$*"
        git push
      }

      function gref() {
        git reset --hard
        git clean -df
        git checkout main
        git fetch
        git pull
      }

      function pfusch() {
        git add --all
        git commit --amend --no-edit
        git push --force-with-lease
      }

      function dci() { docker inspect $(docker-compose ps -q $1) }

      function psp () {
        git checkout -b PSPDX-$1
      }

      function lmr () {
        T=$(git branch --show-current | grep -E -i -o '^[A-Za-z]+-[0-9]+')
        TICKET=$(echo "$T" | tr '[:lower:]' '[:upper:]')

        glab mr create --yes --fill --remove-source-branch --title="$TICKET: $*"
      }
    '';

    shellAliases = {
      psf = "ps -aux | grep";
      lsf = "ls | grep";
      tssh = "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null";
      socks = "ssh -D 1337 -q -C -N";
      prox =
        "export http_proxy=socks5://127.0.0.1:1337 https_proxy=socks5://127.0.0.1:1337";

      # clean
      dklocal =
        "docker run --rm -it -v `PWD`:/usr/workdir --workdir=/usr/workdir";
      dkclean = "docker container rm $(docker container ls -aq)";

      gclean =
        "git fetch -p && for branch in $(git branch -vv | grep ': gone]' | awk '{print $1}'); do git branch -D $branch; done";
      weather = "curl -4 http://wttr.in/Koeln";

      # nix
      ne = "nvim -c ':cd ~/.nixpkgs' ~/.nixpkgs";
      nf = "nix run nix-darwin -- switch --flake ~/.nixpkgs";
      clean =
        "nix-collect-garbage -d && nix-store --gc && nix-store --verify --check-contents && nix store optimise";
      nsh = "nix-shell";
      nse = "nix search nixpkgs";
    };

    plugins = [
      {
        name = "fast-syntax-highlighting";
        src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
      }
    ];
  };
}
