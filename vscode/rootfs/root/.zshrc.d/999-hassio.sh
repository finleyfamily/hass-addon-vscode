#! /usr/bin/env bash

# Home Assistant CLI
# shellcheck disable=SC1090
source <(ha completion zsh) && compdef _ha ha

# Show motd on start
cat /etc/motd
