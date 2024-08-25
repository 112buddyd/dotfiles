# Env Vars
export EDITOR='nvim'
export VISUAL='nvim'

# Aliases
alias vi='nvim'
alias vim='nvim'
alias cls='clear'
alias ll='ls -la'

# Autocompletion
fpath=(~/.zshrc/completion $fpath)
fpath+=~/.zfunc
autoload -Uz compinit && compinit -i

# Rust
export PATH="$PATH:$HOME/.cargo/bin"


# check if on a mac or linux 
if [[ `uname` == "Darwin" ]]; then
  eval "$(/usr/local/bin/mise activate zsh)"
  export PATH="/usr/local/opt/ruby/bin:$PATH"
else
	eval "$(/home/buddy/.local/bin/mise activate zsh)"
  export PATH="$PATH:$HOME/bin"
  eval "$(atuin init zsh)"
  export PATH="$PATH:$HOME/.rvm/bin"
fi

