# if not running interactively, return
[[ $- != *i* ]] && return

# override aliases
alias ls='lsd -A'
alias cat='bat'
alias fd='fdfind'
alias vi='nvim'

# misspelling
alias car='cat'

# programs
alias nr='npm run'
alias python='python3'
alias py='python3'
alias pip='pip3'
alias jl='jupyter lab'
alias sf='screenfetch'
alias sc='systemctl'
alias ssh='TERM=screen ssh'
alias shut='sudo shutdown -h now'

# terraform
alias tf='terraform'
alias tfa='terraform apply -auto-approve'
alias tfd='terraform destroy -auto-approve'

# docker
alias dc='docker-compose'
alias dcu='docker-compose up'
alias dcud='docker-compose up -d'
alias dcd='docker-compose down'
alias dce='docker-compose exec'

function dci() {
 docker inspect $(docker-compose ps -q $1)
}

alias dk='docker'
alias dkc='docker container'
alias dki='docker image'
alias dkv='docker volume'
alias dklocal='docker run --rm -it -v ${PWD}:/usr/workdir --workdir=/usr/workdir -u $(id -u ${USER}):$(id -g ${USER})'

alias kb='kubectl'
alias mk='minikube'
alias kblocal='kubectl run -it --rm --restart=Never alpine --image=alpine sh'

# taskbook
alias tbt='tb -t'
alias tbn='tb -n'
alias tbc='tb -c'
alias tbd='tb -d'
alias tbb='tb -b'
alias tbs='tb -s'
alias tbtc='tbt @coding'
alias tbtg='tbt @general'

# files
alias del='rm -rf'
alias sdel='sudo rm -rf'
alias lst='ls --tree -I .git'
alias lsa='ls'
alias lsl='ls -l'
alias mkdir='mkdir -p'
alias cp='cp -i' # confirm before overwrite

# console
alias c='clear'
alias cs='clear;ls'
alias null='/dev/null'
alias res='source ~/.zshrc'

function mkd() {
 mkdir $1
 builtin cd $1
}

# tmux
alias tmux='tmux -u'
alias tl='tmux ls'
alias ta='tmux attach -t'
alias ts='tmux new-session -s'
alias td='tmux kill-session -t'

# git
alias gid='git diff'
alias gis='git status'
alias gic='git checkout'
alias gicb='git checkout -b'

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

function cd() {
	builtin cd $*
	ls
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
export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --follow --exclude .git --exclude .vim'
export FZF_CTRL_T_COMMAND='$FZF_DEFAULT_COMMAND'

# asdf-vm
#. /opt/asdf-vm/asdf.sh
#. /opt/asdf-vm/completions/asdf.bash

# nvm
export PATH="$PATH:$HOME/programs/npm/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# flutter
export PATH="$PATH:$HOME/packages/flutter/bin"

# language
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LC_COLLATE=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8

# system specific config
if [[ "$OSTYPE" == "linux-gnu" ]]; then
	# on arch linux
	#alias in='yay -S'
	#alias yel='yay -Rs'

	# on ubuntu
	alias in='sudo apt install'
	alias uin='sudo apt remove'

	source /usr/share/autojump/autojump.sh

	function clean() {
		npm install -g npm
		npm cache clean --force

		pip install --upgrade pip

		cargo install-update -a

		# on ubuntu
		sudo apt update
		sudo apt full-upgrade
	  sudo apt autoremove

		# on arch linux
		#yay -Syu --devel --timeupdate
		#yay -Yc

		# enpass scaling settings
		export QT_AUTO_SCREEN_SCALE_FACTOR=0
		export QT_SCREEN_SCALE_FACTORS=1
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

	# python
	function venv() {
		source ~/python/$1/bin/activate
	}

	#[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
else
	echo 'unknown filesystem!'
fi
