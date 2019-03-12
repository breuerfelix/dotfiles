# if not running interactively, return
[[ $- != *i* ]] && return

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

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND='$FZF_DEFAULT_COMMAND'

if [[ "$OSTYPE" == "linux-gnu" ]]; then
	# on arch linux
	source ~/dotfiles/shell/archrc
elif [[ "$OSTYPE" == "darwin"* ]]; then
	# on mac
	source ~/dotfiles/shell/macrc
else
	echo 'unknown filesystem!'
fi
