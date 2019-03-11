alias del='rm -rf'
alias vi='nvim'
alias dc='docker-compose'

alias c='clear'
alias cs='clear;ls'
alias lsa='ls -a'
alias lsl='ls -l'
alias null='/dev/null'

# tmux
alias tmux='tmux -u'
alias tl='tmux ls'
alias ta='tmux attach -t'
alias ts='tmux new-session -s'

# python
alias python='python3'
alias pip='pip3'
function venv() {
	source ~/python/$1/bin/activate
}

function cd() {
	builtin cd $*
	ls -CA
}

# git
function lg() {
	git add --all
	git commit -a -m "$*"
	git push
}

function git-del() {
	git push --delete origin $1
	git branch -d $1
}

if [[ "$OSTYPE" == "linux-gnu" ]]; then
	echo "LINUX"
elif [[ "$OSTYPE" == "darwin"* ]]; then

	alias git='hub'

	function clean() {
		brew update
		brew upgrade
		brew cleanup --prune-prefix
		brew cleanup
		brew doctor
	}

	export FZF_DEFAULT_COMMAND='fd --type f'
	#[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

	# node
	export NVM_DIR="$HOME/.nvm"
	. "/usr/local/opt/nvm/nvm.sh"

elif [[ "$OSTYPE" == "cygwin" ]]; then
        # POSIX compatibility layer and Linux environment emulation for Windows
elif [[ "$OSTYPE" == "msys" ]]; then
        # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
elif [[ "$OSTYPE" == "freebsd"* ]]; then
        # ...
else
	echo 'unknown filesystem!'
fi
