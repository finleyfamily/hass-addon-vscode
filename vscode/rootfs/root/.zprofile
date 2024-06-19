#! /usr/bin/env bash
#
# Loaded at user login.

if [[ ":${PATH}:" != *":${HOME}/.local/bin:"* ]]; then
  export PATH="/usr/local/bin:/usr/local/sbin:$HOME/bin:$HOME/.local/bin:$PATH";
fi

# pyenv setup
export PYENV_ROOT="$HOME/.pyenv";
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH";
eval "$(pyenv init -)";

# nvm setup
export NVM_DIR="$HOME/.nvm";
# shellcheck disable=SC1091
[ -s "${NVM_DIR}/nvm.sh" ] && \. "${NVM_DIR}/nvm.sh";  # This loads nvm
# shellcheck disable=SC1091
[ -s "${NVM_DIR}nvm/etc/bash_completion.d/nvm" ] && \. "${NVM_DIR}/nvm/etc/bash_completion.d/nvm";  # This loads nvm bash_completion
