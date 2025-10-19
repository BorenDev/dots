#!/bin/bash
_yadm_arch_cfg_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# TODO: Determine if I want to install all these packages
# bash "$_yadm_arch_cfg_dir/pkgs.sh"

bash "$_yadm_arch_cfg_dir/pkgs.sh"
bash "$_yadm_arch_cfg_dir/tmux.sh"
