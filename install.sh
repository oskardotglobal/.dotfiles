#!/bin/bash

# Install nvm
bash -c "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh)"

# Copy files
rsync -a ./ ..
