#!/bin/bash

_TMUX_PLUGINS_DIR=~/.config/tmux/plugins/tpm
mkdir -p $_TMUX_PLUGINS_DIR
[ ! -d "$_TMUX_PLUGINS_DIR/.git" ] && git clone https://github.com/tmux-plugins/tpm $_TMUX_PLUGINS_DIR
