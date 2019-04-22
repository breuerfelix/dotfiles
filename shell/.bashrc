# if not running interactively, return
[[ $- != *i* ]] && return

# programs
alias vi='nvim'
alias dc='docker-compose'
alias d='docker'
alias nr='npm run'

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

# python
function venv() {
	source ~/python/$1/bin/activate
}

function cd() {
	builtin cd $*
	ls -CA
}

# git
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
