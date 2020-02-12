export ZSH=~/.oh-my-zsh

#ZSH_THEME='pygmalion'
#ZSH_THEME='agnoster'
#ZSH_THEME='pure'
#ZSH_THEME='robbyrussell'
ZSH_THEME='pi'
#ZSH_THEME='bullet-train'

plugins=(
	zsh-syntax-highlighting
	zsh-autosuggestions
	thefuck
	autojump
)

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

zstyle ':bracketed-paste-magic' active-widgets '.self-*'

source $ZSH/oh-my-zsh.sh

export PATH=$PATH:/usr/local/sbin:$HOME/.local/bin

source ~/dotfiles/shell/.bashrc
