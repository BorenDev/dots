# Set EDITOR to nvim if it's installed
_nvim_check=$(which nvim)
if [ "$_nvim_check" ]; then export EDITOR=$_nvim_check; fi

# Adjust location of taskwarrior rc
[ ! -d ~/.config/task ] && mkdir -p ~/.config/task
export TASKRC=~/.config/task/taskrc

export MANPAGER="nvim +Man!"

# If pyenv is installed make sure it's configured
if [ -d ~/.pyenv ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

U_ID="$(id -u)"
G_ID="$(id -g)"
export U_ID
export G_ID
