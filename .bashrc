case $- in
  *i*) ;;
    *) return;;
esac

# oh-my-bash configuration

export OSH="$HOME/.oh-my-bash"

OSH_THEME="clean"
HYPHEN_INSENSITIVE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
OMB_USE_SUDO=false
completions=()
aliases=()
plugins=(git)

source "$OSH/oh-my-bash.sh"
source "$HOME/.aliases"
source "$HOME/.env"
