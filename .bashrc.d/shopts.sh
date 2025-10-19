#!/bin/bash

# Append to the history file, don't overwrite it
shopt -s histappend

#:J:## Save multi-line commands as one command
#:J:#shopt -s cmdhist
#:J:#
#:J:## use readline on history
#:J:#shopt -s histreedit
#:J:#
#:J:## load history line onto readline buffer for editing
#:J:#shopt -s histverify
#:J:#
#:J:## save history with newlines instead of ; where possible
#:J:#shopt -s lithist

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

#:J:## check the window size after each command and, if necessary,
#:J:## update the values of LINES and COLUMNS.
#:J:#shopt -s checkwinsize
