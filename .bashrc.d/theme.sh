black="\[\e[0;30m\]"
red="\[\e[0;31m\]"
green="\[\e[0;32m\]"
orange="\[\e[0;33m\]"
blue="\[\e[0;34m\]"
purple="\[\e[0;35m\]"
cyan="\[\e[0;36m\]"
grey="\[\e[0;37m\]"
dark_grey="\[\e[0;90m\]"
light_red="\[\e[0;91m\]"
light_green="\[\e[0;92m\]"
yellow="\[\e[0;93m\]"
light_blue="\[\e[0;94m\]"
light_purple="\[\e[0;95m\]"
turquoise="\[\e[0;96m\]"
white="\[\e[0;97m\]"

bold_black="\[\e[30;1m\]"
bold_red="\[\e[31;1m\]"
bold_green="\[\e[32;1m\]"
bold_orange="\[\e[33;1m\]"
bold_blue="\[\e[34;1m\]"
bold_purple="\[\e[35;1m\]"
bold_cyan="\[\e[36;1m\]"
bold_grey="\[\e[37;1m\]"
bold_dark_grey="\[\e[90;1m\]"
bold_light_red="\[\e[91;1m\]"
bold_light_green="\[\e[92;1m\]"
bold_yellow="\[\e[93;1m\]"
bold_light_blue="\[\e[94;1m\]"
bold_light_purple="\[\e[95;1m\]"
bold_turquoise="\[\e[96;1m\]"
bold_white="\[\e[97;1m\]"

normal="\[\e[0m\]"
reset_color="\[\e[39m\]"

STATUS_THEME_PROMPT_BAD="${bold_red}❯${reset_color}${normal} "
STATUS_THEME_PROMPT_OK="${bold_green}❯${reset_color}${normal} "

# This can do the same thing `_dirtrim` does
# but it only works on Bash 4+
# PROMPT_DIRTRIM=3

_dirtrim() {
  echo "$1" | rev | cut -d"/" -f1 | rev
}

_git_current_branch() {
  local ref
  ref=$(command git symbolic-ref --quiet HEAD 2>/dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return # no git repo.
    ref=$(command git rev-parse --short HEAD 2>/dev/null) || return
  fi
  echo "${ref#refs/heads/}"
}

_git_state() {
  if [ -z "$(git status -s)" ]; then # it's "clean"
    echo "${green}✔"
  else
    echo "${red}✗"
  fi
}

_git_info() {
  if git rev-parse --git-dir >/dev/null 2>&1; then
    echo "${green}$(_git_current_branch) $(_git_state)${reset_color}"
  fi
}

_myprompt() {
  local ret_status="$([ $? -eq 0 ] && echo -e "$STATUS_THEME_PROMPT_OK" || echo -e "$STATUS_THEME_PROMPT_BAD")"
  # PS1="${blue}\$(_dirtrim \"\w\") $(_git_info)\n${ret_status}"
  PS1="${light_green}\$HOSTNAME ${orange}\$(_dirtrim \"\w\") ${ret_status}"
}

export PROMPT_COMMAND=_myprompt
