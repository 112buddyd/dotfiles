## To Clone, run these commands

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

echo ".dotfiles" >> .gitignore


git clone --bare git@github.com:112buddyd/dotfiles.git $HOME/.dotfiles


alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'


dotfiles checkout


dotfiles config --local status.showUntrackedFiles no

