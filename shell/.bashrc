# if not running interactively, return
[[ $- != *i* ]] && return

# programs
alias vi='nvim'
alias nr='npm run'
alias py='python'
alias jl='jupyter lab'
alias sf='screenfetch'
alias readlink='greadlink'

# docker
alias dc='docker-compose'
alias dcu='docker-compose up'
alias dcud='docker-compose up -d'
alias dcd='docker-compose down'
alias dk='docker'
alias dkc='docker container'
alias dki='docker image'
alias dkv='docker volume'
alias kb='kubectl'

# files
alias del='rm -rf'
alias lsa='ls -a'
alias lsl='ls -l'
alias c='clear'
alias cs='clear;ls'
alias null='/dev/null'

# tmux
alias tmux='tmux -u'
alias tl='tmux ls'
alias ta='tmux attach -t'
alias ts='tmux new-session -s'

# safety
alias cp='cp -i' # confirm before overwrite

# golang
export GOPATH="${HOME}/go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

# gipfelstuermer
alias gdbackend='sshcode felix@dev4 "~/code"'
alias gdfrontend='sshcode felix@cgn3f "~/code"'

#docker
function dbi() {
 docker exec -it $1 /bin/bash
}

# python
function venv() {
	source ~/python/$1/bin/activate
}

function cd() {
	builtin cd $*
	ls -CA
}

# git
alias gpu='git push --set-upstream origin'
alias gco='git checkout'

function gcb() {
 git checkout -b $1
 git push --set-upstream origin $1
}

function gsm() {
	git submodule foreach "$* || :"
}

function lg() {
	git add --all
	git commit -a -m "$*"
	git push
}

function git-del() {
	git push --delete origin $1
	git branch -d $1
}

# fuzzy finder
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude .vim'
export FZF_CTRL_T_COMMAND='$FZF_DEFAULT_COMMAND'

# language
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LC_COLLATE=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LC_COLLATE=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8

# system specific config
if [[ "$OSTYPE" == "linux-gnu" ]]; then
	# on arch linux
	source ~/dotfiles/shell/archrc
elif [[ "$OSTYPE" == "darwin"* ]]; then
	# on mac
	source ~/dotfiles/shell/macrc
else
	echo 'unknown filesystem!'
fi
