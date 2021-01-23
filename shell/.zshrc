export ZSH=~/.oh-my-zsh

#ZSH_THEME='pygmalion'
#ZSH_THEME='agnoster'
#ZSH_THEME='pure'
#ZSH_THEME='robbyrussell'
#ZSH_THEME='bullet-train'
ZSH_THEME='pi'

export HISTFILE=~/.zsh_history
export HISTSIZE=999999999
export SAVEHIST=$HISTSIZE

setopt hist_find_no_dups
setopt histignorespace
export ZSH_AUTOSUGGEST_USE_ASYNC=true

plugins=(
    zsh-autosuggestions
    thefuck
    autojump
    #hacker-quotes
    bgnotify
    poetry
    zsh-kubectl-prompt
    zsh-syntax-highlighting # must be last
)

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

# fix copy paste in terminal
zstyle ':bracketed-paste-magic' active-widgets '.self-*'

export PATH=$PATH:/usr/local/sbin:$HOME/.local/bin

source $ZSH/oh-my-zsh.sh
source ~/dotfiles/shell/.bashrc

bindkey '^e' edit-command-line
bindkey '^ ' autosuggest-accept
bindkey '^k' up-line-or-search
bindkey '^j' down-line-or-search

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
bindkey '^r' fzf-history-widget
bindkey '^f' fzf-file-widget
