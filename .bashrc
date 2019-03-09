alias del="rm -rf"
alias vi="nvim"
alias git="hub"
alias dc="docker-compose"

# tmux
alias tmux='tmux -u'
alias ta='tmux attach'
alias tls='tmux ls'
alias tat='tmux attach -t'
alias tns='tmux new-session -s'

# python
alias python="python3"
alias pip="pip3"
function venv() {
	source ~/python/$1/bin/activate
}

function cd() {
	builtin cd $*
	ls -CA
}

export FZF_DEFAULT_COMMAND='fd --type f'
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

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

function clean() {
	brew update
	brew upgrade
	brew cleanup --prune-prefix
	brew cleanup
	brew doctor
}

# node
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"
