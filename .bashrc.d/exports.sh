# Set EDITOR to nvim if it's installed
_nvim_check=$(command -v nvim)
if [ "$_nvim_check" ]; then
  export EDITOR=$_nvim_check
  export MANPAGER="nvim +Man!"
fi

U_ID="$(id -u)"
G_ID="$(id -g)"
export U_ID
export G_ID
