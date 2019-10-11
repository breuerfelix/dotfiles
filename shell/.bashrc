# if not running interactively, return
[[ $- != *i* ]] && return

# programs
alias vi='nvim'
alias nr='npm run'
alias py='python'
alias jl='jupyter lab'
alias sf='screenfetch'
alias sc='systemctl'
alias tf='terraform'

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
alias resource='source ~/.zshrc'

# tmux
alias tmux='tmux -u'
alias tl='tmux ls'
alias ta='tmux attach -t'
alias ts='tmux new-session -s'
alias td='tmux kill-session -t'

# safety
alias cp='cp -i' # confirm before overwrite

# golang
export GOPATH=${HOME}/go
export PATH=$PATH:${GOPATH}/bin

function sv() {
 sudo systemctl $1 $2
}

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

function clone() {
 git clone git@$1.git
}

function gclone() {
 clone github.com:$1
}

function bclone() {
 gclone breuerfelix/$1
}

function iclone() {
 clone gitlab.inovex.de:$1
}

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

# plugins

# fuzzy finder
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude .vim'
export FZF_CTRL_T_COMMAND='$FZF_DEFAULT_COMMAND'

# asdf-vm
. /opt/asdf-vm/asdf.sh
. /opt/asdf-vm/completions/asdf.bash

# language
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LC_COLLATE=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8

# system specific config
if [[ "$OSTYPE" == "linux-gnu" ]]; then
	# on arch linux
	alias in='yay -S'
	alias yel='yay -Rs'

	source /usr/share/autojump/autojump.zsh

	function clean() {
		yay -Syu --devel --timeupdate
		yay -Yc
	}
elif [[ "$OSTYPE" == "darwin"* ]]; then
	# on mac
	alias git='hub'

	alias python='python3'
	alias pip='pip3'

	function clean() {
		npm cache clean --force
		brew update
		brew upgrade
		brew cleanup --prune-prefix
		brew cleanup
		brew doctor
	}

	#[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
else
	echo 'unknown filesystem!'
fi
