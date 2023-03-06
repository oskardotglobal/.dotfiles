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

source "$OSH"/oh-my-bash.sh

# nvm configuration

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
