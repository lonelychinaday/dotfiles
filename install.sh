#!/usr/bin/env bash
set -euo pipefail

# dotfiles 配置部署脚本 / dotfiles config deployment script
# 功能 / Features:
#   - 将仓库中的指定配置目录通过软链接部署到 $HOME
#     Symlink selected config directories from repository into $HOME
#   - 如目标已存在则先备份为 *.bak_<timestamp>
#     Backup existing targets to *.bak_<timestamp> before linking

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
DOTFILES_DIR=${DOTFILES:-$SCRIPT_DIR}

# 需要部署的配置列表 / Config items to deploy
ITEMS=(
  ".config/nvim"
  ".config/wezterm"
  ".config/starship.toml"
)

log() {
  printf '[dotfiles] %s\n' "$*"
}

ensure_source_exists() {
  local source="$1"
  if [[ ! -e "$source" ]]; then
    log "源路径不存在：$source / Source missing"
    exit 1
  fi
}

backup_target() {
  local target="$1"
  local timestamp backup_path
  timestamp=$(date +%Y%m%d_%H%M%S)
  backup_path="${target}.bak_${timestamp}"
  mv "$target" "$backup_path"
  log "已备份 $target -> $backup_path / Backed up"
}

ensure_parent_dir() {
  local target="$1"
  local parent
  parent=$(dirname "$target")
  mkdir -p "$parent"
}

deploy_item() {
  local relative="$1"
  local source="$DOTFILES_DIR/$relative"
  local target="$HOME/$relative"

  ensure_source_exists "$source"
  ensure_parent_dir "$target"

  if [[ -L "$target" && $(readlink "$target") == "$source" ]]; then
    log "已存在正确链接：$target / Symlink already correct"
    return
  fi

  if [[ -e "$target" || -L "$target" ]]; then
    backup_target "$target"
  fi

  ln -sfn "$source" "$target"
  log "已创建链接：$target -> $source / Symlink created"
}

main() {
  for item in "${ITEMS[@]}"; do
    deploy_item "$item"
  done
  log "全部完成 / All done"
}

main "$@"
