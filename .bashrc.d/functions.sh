txt2pdf() {
  input_file=$1
  filename="${input_file%.*}"

  enscript "$input_file" --output=- | ps2pdf - >"$filename.pdf"
}

gcr() {
  git clone --recursive "$@"
}

gsu() {
  find . -name .git -exec sh -c "cd \"\$(dirname \"{}\")\"; printf \"|----- \"; pwd; git submodule update --init --recursive;" \;
}

#######################################
# Traverse a directory, find git repos and submodules and perform the git action on each.
# Arguments: Any git action to perform on any git repo/submodule discovered
#######################################
gr() {
  _dir_name=$(dirname \"{}\")
  find . -name .git -exec sh -c "cd \"\$_dir_name\"; printf \"|----- \"; pwd; $*;" \;
}

#######################################
# Traverse a directory, find git repos and perform the git action on each.
# Arguments: Any git action to perform on any git repo/submodule discovered
#######################################
grg() {
  _dir_name=$(dirname \"{}\")
  find . -type d -name .git -exec sh -c "cd \"\$_dir_name\"; printf \"|----- \"; pwd; $*;" \;
}

#######################################
# Traverse a directory, find git submodules and perform the git action on each.
# Arguments: Any git action to perform on any git repo/submodule discovered
#######################################
grs() {
  _dir_name=$(dirname \"{}\")
  find . -type f -name .git -exec sh -c "cd \"\$_dir_name\"; printf \"|----- \"; pwd; $*;" \;
}

#######################################
# Traverse a directory, find git repos and get their current status
#######################################
gsls() {
  _dir_name=$(dirname \"{}\")
  find . -type d -name .git -exec sh -c "cd \"\$_dir_name\"; printf \"|----- \"; pwd; git status -s -b --ahead-behind" \;
}

#######################################
# Traverse a directory, find git repos, fetch from the remote and get their current status
#######################################
gfls() {
  _dir_name=$(dirname \"{}\")
  find . -type d -name .git -exec sh -c "cd \"\$_dir_name\"; printf \"|----- \"; pwd; git fetch; git status -s -b --ahead-behind" \;
}

#######################################
# Traverse a directory, find git repos, tag each and push to origin
# Arguments:
#   The tag to use on each repo
#######################################
gat() {
  _dir_name=$(dirname \"{}\")
  find . -type d -name .git -exec sh -c "cd \"\$_dir_name\"; printf \"|----- \"; pwd; git tag $1; git push origin $1" \;
}

#######################################
# Traverse a directory, find git repose, create and annotated tag and push to origin.
# Arguments:
#   The tag to use on each repo
#   The annotation for the tag
#######################################
gatm() {
  _dir_name=$(dirname \"{}\")
  find . -type d -name .git -exec sh -c "cd \"\$_dir_name\"; printf \"|----- \"; pwd; git tag -a -m \"$2\" $1; git push origin $1" \;
}

#######################################
# Make a copy of all modified and untracked files in a git repository and maintain directory structure.
#######################################
cpMods() {
  mkdir -p ../mods
  cp --parents "$(git ls-files --modified --others --exclude-standard)" ../mods
}

#######################################
# Make a copy of all modified tracked files in a git repository and maintain the directory structure.
#######################################
cpOnlyMods() {
  mkdir -p ../onlymods
  cp --parents "$(git ls-files --modified)" ../onlymods
}

#######################################
# For the given filepath, find any files of the same name from the current working directory and
# execute vimdiff on the original file and any discovered files of the same name.
# Arguments:
#   Original file path to be diff'd
#######################################
findDiff() {
  fileToDiffPath=$1
  fileToDiff=$(basename "$fileToDiffPath")

  echo "$fileToDiff"

  find . -type f -name "$fileToDiff" -exec vimdiff "$fileToDiffPath" "{}" \;
}

#######################################
# Decrypt and extract the encrypted bz2 tarball into a directory with the name of the tarball
# Arguments:
#   The tarball to extract
#######################################
utarefd() {
  local _dir_name=$(echo "$1" | cut -f1 -d".")
  mkdir -p "$_dir_name"
  gpg -d "$1" | tar xjvf - -C "$_dir_name"
}

#######################################
# Decrypt and extract an encrypted and bz2 compressed tarball
# Arguments:
#   The signed and compressed tarball.
#######################################
utaref() {
  gpg -d "$1" | tar xjvf -
}

#######################################
# Decrypt and list the contents of the encrypted bz2 tarball
# Arguments:
#   The encrypted bz2 compressed tarball
#######################################
utarel() {
  local _tar_name=$1
  local _GPG_TTY=$GPG_TTY
  export GPG_TTY=$(tty)
  gpg -d $_tar_name | tar -tjf -
  export GPG_TTY=$_GPG_TTY
}

#######################################
# Add the provided directory to a bz2 compressed tarball and encrypt it with gpg.
# Arguments:
#   The directory to compress into an encrypted bz2 tarball
#######################################
tared() {
  local _dir_name=$(echo "$1" | sed 's:/*$::')
  echo "$_dir_name"
  local _GPG_TTY=$GPG_TTY
  export GPG_TTY=$(tty)
  if [ -d "$_dir_name" ]; then
    tar cjvpf - "$_dir_name" | gpg --symmetric --cipher-algo aes256 -o "$_dir_name.tar.bz2.gpg"
  else
    echo "Unable to find [$_dir_name]"
  fi
  export GPG_TTY=$_GPG_TTY
}

#######################################
# Add the provided directory to a bz2 encrypted tarball
#   Preserve permissions
# Arguments:
#   Name for the tarball
#   File(s) to add to the tarball
#######################################
taref() {
  local _tar_name=$1
  shift
  local _args=$*
  local _GPG_TTY=$GPG_TTY
  export GPG_TTY=$(tty)
  tar cjvpf - $_args | gpg --symmetric --cipher-algo aes256 -o "$_tar_name.tar.bz2.gpg"
  export GPG_TTY=$_GPG_TTY
}

#######################################
# Use ripgrep and pass results to fzf.  From fzf, if a file was selected, get the
# filepath and line number for the selection.  Open the file with nvim at the
# discovered line.
# Arguments:
#   The pattern to look for
#   The path to start looking for the pattern
#######################################
rvim() {
  filepath_line="$(rg -n "$1" "$2" | fzf)"
  echo "$filepath_line"
  filepath=$(echo "$filepath_line" | cut -d":" -f1)
  line=$(echo "$filepath_line" | cut -d":" -f2)

  if ! [ "$filepath" == "" ] && ! [ "$line" == "" ]; then
    echo nvim +"$line" "$filepath"
    nvim +"$line" "$filepath"
  fi
}

#######################################
# Create a python3 virtual env and activate the venv.
# Arguments:
#   Name for the venv
#######################################
pva() {
  source ".venv_$1/bin/activate"
}

#######################################
# Create a python3 virtual env and activate the venv.
# Arguments:
#   Name for the venv
#######################################
pvd() {
  deactivate
}

#######################################
# Create a python3 virtual env and activate the venv.
# Arguments:
#   Name for the venv
#######################################
pv() {
  python3 -m venv ".venv_$1"
  source ".venv_$1/bin/activate"
}

#######################################
# Create a python3 virtual env, activate the venv and install pkgs from the
# requirements.txt file
# Arguments:
#   Name for the venv
#######################################
pvr() {
  python3 -m venv ".venv_$1"
  source ".venv_$1/bin/activate"
  pip install -r requirements.txt
}

#######################################
# Create a python3 virtual env, activate the venv and install pkgs from the
# pyproject.toml file
# Arguments:
#   Name for the venv
#######################################
pvp() {
  python3 -m venv ".venv_$1"
  source ".venv_$1/bin/activate"
  pip install pyproject.toml
}

#######################################
# Attempt to transfer the default id_rsa.pub to the hosts authorized_keys
# Arguments:
#   Alias for the remote host - the IP, or hostname
#   The username on the remote host to transfer the key to
#######################################
ssh_tx_pub() {
  _PUBLIC_KEY=$3
  _HOST_ALIAS=$1
  _HOST_USERNAME=$2
  if [ -z "${_HOST_USERNAME}" ]; then
    _HOST_USERNAME=$USER
  fi
  if [ -e $_PUBLIC_KEY ]; then
    cat $_PUBLIC_KEY | ssh -e none "$_HOST_USERNAME"@"$_HOST_ALIAS" 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys'
  fi
}

#######################################
# Run docker-compose for the indicated target
# Arguments:
#   The docker target to run
#######################################
dock() {
  docker-compose run --rm "$1"
}

#######################################
# Retrieve a tracked file from a gitlab server.
# Arguments:
#   URL to the raw file location
#######################################
get_getlab_file() {
  curl --header "PRIVATE-TOKEN: $GITLAB_PRIVATE_TOKEN" "$1"
}

#######################################
# Back up neovim configuration locaitons
#######################################
ncfg_bak() {
  bak_ext=bak
  if [[ $1 != '' ]]; then
    bak_ext=$1
  fi
  # required
  mv ~/.config/nvim{,.$bak_ext}

  # optional but recommended
  mv ~/.local/share/nvim{,.$bak_ext}
  mv ~/.local/state/nvim{,.$bak_ext}
  mv ~/.cache/nvim{,.$bak_ext}
}

#######################################
# Remoe back up neovim configuration locaitons
#######################################
ncfg_rmbak() {
  bak_ext=bak
  if [[ $1 != '' ]]; then
    bak_ext=$1
  fi
  # required
  rm -rf "$HOME/.config/nvim.$bak_ext"

  # optional but recommended
  rm -rf "$HOME/.local/share/nvim.$bak_ext"
  rm -rf "$HOME/.local/state/nvim.$bak_ext"
  rm -rf "$HOME/.cache/nvim.$bak_ext"
}

#######################################
# Remove neovim configuration locations and move backups back to expected locations
#######################################
ncfg_revert() {
  bak_ext=bak
  if [[ $1 != '' ]]; then
    bak_ext=$1
  fi
  # required
  rm -rf ~/.config/nvim
  mv ~/.config/nvim{.$bak_ext,}

  # optional but recommended
  rm -rf ~/.local/share/nvim
  mv ~/.local/share/nvim{.$bak_ext,}

  rm -rf ~/.local/state/nvim
  mv ~/.local/state/nvim{.$bak_ext,}

  rm -rf ~/.cache/nvim
  mv ~/.cache/nvim{.$bak_ext,}
}

#######################################
# Remove neovim configuration locations
#######################################
ncfg_rm() {
  # required
  rm -rf ~/.config/nvim

  # optional but recommended
  rm -rf ~/.local/share/nvim

  rm -rf ~/.local/state/nvim

  rm -rf ~/.cache/nvim
}

#######################################
# Create a gz tarball of the neovim configuraiton locations.
# Arguments:
#######################################
ncfg_tarz() {
  pushd "$HOME" || return
  tar czf nvim_cfg.tar.gz .config/nvim .local/share/nvim .local/state/nvim .cache/nvim
  popd || return
}

#######################################
# Create a tarball of all dotfiles
# Arguments:
#######################################
dots_tarz() {
  pushd "$HOME" || return
  _yadm_files=$(yadm ls-files | xargs)
  tar czf dots.tar.gz $_yadm_files .local/share/yadm/
  popd || return
}

#######################################
# Retreive a local copy of all remote branches.
#######################################
gitem() {
  git branch -r | grep -v '\->' | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | while read remote; do git branch --track "${remote#origin/}" "$remote"; done
}
#######################################
# Retreive a local copy of all remote branches.
#######################################
gitem2() {
  #for remote in $(git branch -r); do git branch --track ${remote@origin/} $remote; done
  echo "needs work"
}

#######################################
# Convenience functions to remember how to get pre-defined compiler macros
#######################################
_gcc_defines() {
  echo | gcc -dM -E -
}
_clang_defines() {
  echo | clang -dM -E -
}
_g++_defines() {
  echo | g++ -dM -E -x c++ -
}
_clang++_defines() {
  echo | clang++ -dM -E -x c++ -
}

#######################################
# Create a generic c editorconfig file at the current working directory
#######################################
gen_editor_cfg() {
  cat <<EOF >.editorconfig
root = true

[*]
tab_width = 4
indent_size = 4
auto_format = false
EOF
}

#######################################
# Pretty print the current PATH variable
# Globals:
#   PATH
#######################################
pp_path() {
  echo "${PATH//:/$'\n'}"
}

mkd() {
  mkdir -p "$1"
  cd "$1" || return
}

tarp() {
  _date=$(date '+%Y%m%d_%H%M%S')
  _dir=$(basename "$PWD")
  pushd .. || true
  tar cjf "${_dir}_${_date}.tar.bz2" "$_dir"
  popd || true
}

tard() {
  _date=$(date '+%Y%m%d_%H%M%S')
  _dir=$(basename "$1")
  tar cjf "${_dir}_${_date}.tar.bz2" "$_dir"
}

ttask() {
  tclock timer -d "$1" -M -e "paplay /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga"
}

refresh_device() {
  _DEV_PATH=$1
  _confirmation="N"
  read -rp "Wipe device [y/N]: $_DEV_PATH " _confirmation
  if [ "$_confirmation" == "" ]; then
    _confirmation="n"
  fi
  if [ "$_confirmation" == "y" ]; then
    read -rp "Initialize GPT and filesystem? [y/N]: $_DEV_PATH " _confirmation
    if [ "$_confirmation" == "" ]; then
      _confirmation="n"
    fi
    echo "Refreshing $_DEV_PATH..."
    sudo umount "$_DEV_PATH"*
    sudo wipefs -a "$_DEV_PATH"
    if [ "$_confirmation" == "y" ]; then
      sudo sgdisk --clear "$_DEV_PATH"
      sudo sgdisk -n 1:2048 -t 1:0700 -g "$_DEV_PATH" -p
      sudo mkfs.exfat "$_DEV_PATH"1
    fi
  fi
}
