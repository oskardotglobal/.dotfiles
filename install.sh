#!/bin/bash

# Install nvm
if [ ! -d $HOME/.nvm ]; then
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh)"
fi

# Copy files
rsync -a \
    --exclude "*.sh" \
    --exclude "README.md" \
    --exclude ".git" \
    --exclude "*.zsh-theme" \
   ./ ..
