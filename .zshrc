# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

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

# Mise
eval "$(~/.local/bin/mise activate zsh)"

# Rust
export PATH="$PATH:$HOME/.cargo/bin"

# FZF - fuzzy finding
source <(fzf --zsh)

# Atuin - shell history
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"

# Starship
eval "$(starship init zsh)"

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
