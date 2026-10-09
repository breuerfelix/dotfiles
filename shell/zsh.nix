{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    autosuggestion.enable = true;

    history = {
      append = true;
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true; # ignore commands starting with a space
      share = true;
    };

    syntaxHighlighting = {
      enable = true;
    };

    initContent = ''
      [ -f ~/.env/env.sh ] && source ~/.env/env.sh

      # used for homebrew
      export XDG_DATA_DIRS=$XDG_DATA_DIRS:/opt/homebrew/share

      # better kubectl diff
      export KUBECTL_EXTERNAL_DIFF="${pkgs.dyff}/bin/dyff between --omit-header --set-exit-code"

      if command -v gardenctl &> /dev/null; then
        export GCTL_SHELL=zsh
        if [ -z "$GCTL_SESSION_ID" ] && [ -z "$TERM_SESSION_ID" ]; then
          export GCTL_SESSION_ID=$(uuidgen)
        fi

        eval "$(gardenctl kubectl-env zsh)"
        source <(gardenctl completion zsh)
      fi

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
      function lgp() {
        git add --all
        git commit --signoff -a -m "$*"
        git push
      }

      function gm() {
        git reset --hard
        git checkout main
        git fetch
        git pull
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

      function nfh() {
        pushd ~/.nixpkgs
        nix --experimental-features 'nix-command flakes' build '.#homeConfigurations.SIT-SMBP-446M7F.activationPackage'
        ./result/activate
        popd
      }

      function kshell() {
        kubectl debug -it --profile=sysadmin --image registry.ske.stackit.cloud/library/busybox node/$*
      }

      # ondemand
      function ondconnect() {
        export OND="$1"
        mkdir -p ~/.config/stackit/profiles/ondemand-$OND
        if [ ! -f ~/.config/stackit/profiles/ondemand-"$OND"/cli-config.json ]; then
          cp ~/.config/stackit/profiles/qa/cli-config.json ~/.config/stackit/profiles/ondemand-"$OND"/cli-config.json
        fi

        export BASIC_AUTH_USERNAME=$(kubectl get -n ondemand secret ond-$OND-credentials -ojsonpath='{.data.username}' | base64 -d)
        export BASIC_AUTH_PASSWORD=$(kubectl get -n ondemand secret ond-$OND-credentials -ojsonpath='{.data.password}' | base64 -d)
        export PROJECT_ID=$(kubectl get -n ondemand secret ond-$OND-credentials -ojsonpath='{.data.projectID}' | base64 -d)
        export SNA_PROJECT_ID=$(kubectl get -n ondemand secret ond-$OND-credentials -ojsonpath='{.data.snaProjectID}' | base64 -d)
        export SKE_API=https://ske-api.ing.ond-$OND.ci.ske.eu01.stackit.cloud

        kubectl ske connect ondemand ond-$OND
      }
    '';

    shellAliases = {
      psf = "ps -aux | grep";
      lsf = "ls | grep";
      tssh = "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null";
      socks = "ssh -D 1337 -q -C -N";
      prox =
        "export http_proxy=socks5://127.0.0.1:1337 https_proxy=socks5://127.0.0.1:1337";

      # programs
      oc = "opencode";
      cc = "claude --dangerously-skip-permissions";

      # gardenctl
      gc = "gardenctl";
      gcprow = "gc target --garden prd --project 74140853d0 --shoot prow-trust";
      gcprovider = "eval $(gardenctl provider-env zsh)";
      ondc = "gcprow && ondconnect";
      ond = "gc target --garden ond-$OND";
      ondi = "ond --seed stackit";
      onds = "ond --seed s-eu01-000";
      ondr = "ond --seed r-eu01-0";

      # clean
      dkclean = "docker container rm $(docker container ls -aq)";

      gclean =
        "git fetch -p && for branch in $(git branch -vv | grep ': gone]' | awk '{print $1}'); do git branch -D $branch; done";

      # nix
      ne = "nvim -c ':cd ~/.nixpkgs' ~/.nixpkgs";
      nf = "sudo nix run nix-darwin -- switch --flake ~/.nixpkgs";
      clean =
        "nix-collect-garbage -d && nix-store --gc && nix store optimise && nix-store --verify --check-contents";
      nsh = "nix-shell";
      nse = "nix search nixpkgs";
    };
  };
}
