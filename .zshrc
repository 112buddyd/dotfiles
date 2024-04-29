# oh-my-zsh stuff
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
zstyle ':omz:update' mode auto      # update automatically without asking
ZSH_DISABLE_COMPFI="true"
plugins=(git)
source $ZSH/oh-my-zsh.sh
# end oh-my-zsh stuff

# Env Vars
export EDITOR='nvim'
export VISUAL='nvim'

# Aliases
alias vi='nvim'
alias vim='nvim'
alias cls='clear'
alias ll='ls -la'
# alias dotfiles="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# Autocompletion
fpath=(~/.zshrc/completion $fpath)
fpath+=~/.zfunc
autoload -Uz compinit && compinit -i

# Rust
export PATH="$PATH:$HOME/.cargo/bin"

# check if on a mac or linux 
if [[ `uname` == "Darwin" ]]; then
	eval "$(/usr/local/bin/mise activate zsh)"
else
	eval "$(/home/buddy/.local/bin/mise activate zsh)"
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  source ~/.rvm/scripts/rvm
  export PATH="$PATH:$HOME/bin"
  eval "$(atuin init zsh)"
  export PATH="$PATH:$HOME/.rvm/bin"

fi
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


