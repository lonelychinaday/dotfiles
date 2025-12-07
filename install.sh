#!/usr/bin/env bash
set -euo pipefail

# Neovim 配置部署脚本 / Neovim config deployment script
# 功能 / Features:
# 1. 将仓库中的 .config/nvim 链接到 $HOME/.config/nvim
#    Symlink repository .config/nvim into $HOME/.config/nvim
# 2. 若目标已存在则先备份为 *.bak_<timestamp>
#    Backup existing target as *.bak_<timestamp> before linking

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
DOTFILES_DIR=${DOTFILES:-$SCRIPT_DIR}
SOURCE="$DOTFILES_DIR/.config/nvim"
TARGET="$HOME/.config/nvim"

if [[ ! -e "$SOURCE" ]]; then
  echo "[dotfiles] 源目录不存在：$SOURCE / Source directory missing" >&2
  exit 1
fi

mkdir -p "$(dirname "$TARGET")"

# 若目标已经是正确的软链接则跳过 / Skip if symlink already correct
if [[ -L "$TARGET" && $(readlink "$TARGET") == "$SOURCE" ]]; then
  echo "[dotfiles] 已存在正确链接 / Symlink already correct"
  exit 0
fi

# 如目标存在则备份 / Backup existing target if present
if [[ -e "$TARGET" || -L "$TARGET" ]]; then
  timestamp=$(date +%Y%m%d_%H%M%S)
  backup="${TARGET}.bak_${timestamp}"
  mv "$TARGET" "$backup"
  echo "[dotfiles] 已备份 $TARGET -> $backup / Backed up"
fi

ln -sfn "$SOURCE" "$TARGET"
echo "[dotfiles] 已创建链接：$TARGET -> $SOURCE / Symlink created"
