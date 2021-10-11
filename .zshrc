#
# OhmyZsh stuff
#

# Path to your oh-my-zsh installation.
export ZSH="/Users/oskar/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
HIST_STAMPS="dd.mm.yyyy"

plugins=(
  git 
  sudo
  copydir
  npm
)

source $ZSH/oh-my-zsh.sh

#
# User configuration
#

# Make everything colorful
export CLICOLOR=1

# Aliases
alias nbs='noteblockstudio'
alias mmc='sudo /Applications/MultiMC.app/Contents/MacOS/MultiMC'
alias multimc='mmc'

# Lang
export LANG=en_US.UTF-8

# ls-Aliases
alias ls='ls -G -h -1'
alias l='ls -A -G -h -1'
alias ll='ls -A -G -h -1 -l'
# vim stuff
alias nano='nvim'
alias vim='nvim'
alias vi='nvim'
export EDITOR="nvim"
# andere Aliases
alias spotify='spt'

# Functions
otrdecoder() {
  /Users/oskar/.bin/otrdecoder -e andreas.manhart@gmx.de -p unwichtig -i "$1"
}

noteblockstudio() {
 wine /Users/oskar/.wine/drive_c/users/crossover/Minecraft\ Note\ Block\ Studio/Minecraft\ Note\ Block\ Studio.exe 
}

# PATH stuff
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/Users/oskar/.bin/refind-bin-0.13.2:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PATH="/usr/local/bin/mcrcon:$PATH"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PATH="/Users/oskar/.bin/:$PATH"
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
