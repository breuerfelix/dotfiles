export ZSH=~/.oh-my-zsh

#ZSH_THEME='pygmalion'
#ZSH_THEME='agnoster'
#ZSH_THEME='pure'
#ZSH_THEME='robbyrussell'
#ZSH_THEME='bullet-train'
ZSH_THEME='pi'

plugins=(
    zsh-syntax-highlighting
    zsh-autosuggestions
    thefuck
    autojump
)

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

zstyle ':bracketed-paste-magic' active-widgets '.self-*'

export PATH=$PATH:/usr/local/sbin:$HOME/.local/bin

source $ZSH/oh-my-zsh.sh
source ~/dotfiles/shell/.bashrc
