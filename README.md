# dotfiles

统一管理个人配置文件的仓库。建议将原本散落在 `$HOME` 下的设置（例如 `~/.config/nvim`、`~/.config/wezterm`、`~/.tmux.conf` 等）迁移到此处，并通过软链接保持与系统实际位置一致。

## 目录建议

```plain
~/dotfiles/
├── README.md
├── install.sh        # 可选：自动化建立软链接的脚本
├── .config/
│   ├── nvim/
│   └── wezterm/
├── .tmux.conf
└── secrets/          # 可选：不纳入版本控制的敏感配置
```

> **提示**：保留与 `$HOME` 相同的目录和文件名称，可以直接映射回最终位置，降低管理成本。

## 迁移流程

1. **备份原配置**（推荐）
   ```bash
   cp -r ~/.config/nvim ~/.config/nvim_backup
   cp -r ~/.config/wezterm ~/.config/wezterm_backup
   cp ~/.tmux.conf ~/.tmux.conf.bak
   ```
2. **移动配置到仓库**
   ```bash
   mv ~/.config/nvim ~/dotfiles/.config/
   mv ~/.config/wezterm ~/dotfiles/.config/
   mv ~/.tmux.conf ~/dotfiles/.tmux.conf
   ```
3. **建立软链接**（可按实际情况调整）
   ```bash
   DOTFILES="$HOME/dotfiles"
   ln -sfn "$DOTFILES/.config/nvim" "$HOME/.config/nvim"
   ln -sfn "$DOTFILES/.config/wezterm" "$HOME/.config/wezterm"
   ln -sfn "$DOTFILES/.tmux.conf" "$HOME/.tmux.conf"
   ```
   - 建议把上述命令整理成 `install.sh`，自动化处理所有文件和目录。
4. **验证**：重新打开 nvim、wezterm、tmux 等程序，确认配置生效后再删除备份。
5. **版本控制**：
   ```bash
   cd ~/dotfiles
   git status
   git add .
   git commit -m "chore: migrate configs"
   ```

## 多设备同步建议

1. 在新设备克隆：`git clone git@your.git.host:username/dotfiles.git ~/dotfiles`
2. 执行 `install.sh`（或手动 `ln -sfn`）建立所需链接。
3. 如果配置存在平台差异，可在脚本中根据 `uname` 判断或维护独立分支/目录。

## 忽略敏感与临时文件

- 建议创建 `.gitignore`，排除无需追踪的缓存、临时或敏感文件（如 `secrets/` 目录）。
- 对于 API Key、SSH、SOPS 等敏感信息，可使用 `git-crypt`、`sops` 或手动同步，避免直接提交。

## 后续维护

- **更新配置**：直接在仓库中编辑文件，通过 `git status` 查看变更并提交。
- **备份与回溯**：利用 Git 日志快速回顾历史版本。
- **定期同步**：通过 `git pull` / `git push` 保持各设备最新状态。
