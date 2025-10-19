#!/bin/bash
_yadm_arch_cfg_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
mapfile -t packages < <(grep -v '^#' "$_yadm_arch_cfg_dir/arch.packages" | grep -v '^$')
sudo pacman -S --noconfirm --needed "${packages[@]}"
