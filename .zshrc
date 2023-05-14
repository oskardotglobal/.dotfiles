# oh-my-zsh configuration

export ZSH="$HOME/.oh-my-zsh"
export ZSH_COMPDUMP="$ZSH/cache/.zcompdump-$HOST"

ZSH_THEME="oskardotglobal"
HYPHEN_INSENSITIVE=true
DISABLE_AUTO_UPDATE=true
HIST_STAMPS="dd.mm.yyyy"
plugins=("git")

source "$ZSH/oh-my-zsh.sh"
source "$HOME/.aliases"
source "$HOME/.env"
