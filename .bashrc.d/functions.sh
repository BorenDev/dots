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
