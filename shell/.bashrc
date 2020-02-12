# if not running interactively, return
[[ $- != *i* ]] && return

# language
export LC_ALL=en_US.UTF-8

alias luser='pkill -KILL -u'

# binaries
alias python2='/usr/bin/python2'
alias pip2='/usr/bin/pip2'
alias python3='/usr/bin/python3'
alias pip3='/usr/bin/pip3'

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
alias py='python'
alias pip='python3 -m pip'
alias sf='screenfetch'
alias sc='systemctl'
alias ssh='TERM=screen ssh'
alias shut='sudo shutdown -h now'

# terraform
alias tf='terraform'
alias tfa='terraform apply -auto-approve'
alias tfd='terraform destroy -auto-approve'

# docker
alias dk='docker'
alias dke='docker exec -it'
alias dklocal='docker run --rm -it -v ${PWD}:/usr/workdir --workdir=/usr/workdir'

alias dc='docker-compose'

function dci() {
	docker inspect $(docker-compose ps -q $1)
}

alias dm='docker-machine'

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

function watch() {
	while sleep 1
	do clear
		$*
	done
}

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

# golang
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# ruby
export GEM_HOME=$HOME/.gem
export GEM_PATH=$HOME/.gem
export PATH=$PATH:$GEM_PATH/bin

function sv() {
	sudo systemctl $1 $2
}

function cd() {
	builtin cd $*
	ls
}

# git
alias gm='git commit --signoff'
alias gpu='git push --set-upstream origin'

function lgc() {
	git commit --signoff -m "$*"
}

function clone() {
	git clone git@$1.git
}

function gclone() {
	clone github.com:$1
}

function bclone() {
	gclone breuerfelix/$1
}

function gsm() {
	git submodule foreach "$* || :"
}

function lg() {
	git add --all
	git commit --signoff -a -m "$*"
	git push
}

function git-del() {
	git push --delete origin $1
	git branch -d $1
}

# plugins

# kubectl
if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi

# nnn
source ~/dotfiles/shell/nnn.sh

# rust
export PATH=$HOME/.cargo/bin:$PATH
source $HOME/.cargo/env

# direnv
#eval "$(direnv hook zsh)"

# gpg
export GPG_TTY=$(tty)

# nomad
[ -x /usr/local/bin/nomad ] && complete -o nospace -C /usr/local/bin/nomad nomad

# fuzzy finder
source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --follow --exclude .git --exclude .vim'
export FZF_CTRL_T_COMMAND='$FZF_DEFAULT_COMMAND'

# asdf-vm
#. /opt/asdf-vm/asdf.sh
#. /opt/asdf-vm/completions/asdf.bash

# nvm
export PATH=$PATH:$HOME/programs/npm/bin
export NVM_DIR=$HOME/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# flutter
export PATH=$PATH:$HOME/packages/flutter/bin

# import secrets which are not stored in the repo
[ -f $HOME/.secrets.sh ] && source $HOME/.secrets.sh

# docker machine
source /etc/bash_completion.d/docker-machine-prompt.bash

# autojump
source /usr/share/autojump/autojump.sh

# powerline
powerline-daemon -q

# esp-idf
export IDF_PATH=$HOME/inovex/esp-idf
. $HOME/inovex/esp-idf/export.sh >> /dev/null

# system specific config
if [[ "$OSTYPE" == "linux-gnu" ]]; then
	# on arch linux
	#alias in='yay -S'
	#alias yel='yay -Rs'

	# on ubuntu
	alias in='sudo apt install'
	alias uin='sudo apt remove'

	# enpass scaling settings
	#export QT_AUTO_SCREEN_SCALE_FACTOR=0
	#export QT_SCREEN_SCALE_FACTORS=1

	function clean() {
		npm install -g npm@latest
		npm cache clean --force

		rustup self update
		rustup update

		pip install --user --upgrade pip

		#cargo install-update -a

		# on ubuntu
		sudo apt update
		sudo apt full-upgrade -y
		sudo apt autoremove -y

		# on arch linux
		#yay -Syu --devel --timeupdate
		#yay -Yc
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
	echo 'unknown operating system!'
fi
