# dotfiles

统一管理个人配置文件的仓库。A repository for centralized personal configuration files.

将原本散落在 `$HOME` 下的设置（例如 `~/.config/nvim`、`~/.config/wezterm`、`~/.tmux.conf` 等）迁移到此处，并通过软链接保持与系统实际位置一致。Migrate settings originally scattered under `$HOME` (e.g., `~/.config/nvim`, `~/.config/wezterm`, `~/.tmux.conf`) and keep them linked back to their actual locations via symlinks.

```plain
dotfiles/
├── README.md
├── install.sh
├── .config/
│   ├── nvim/
│   ├── wezterm/
│   └── ... 
├── .tmux.conf
├── .zshrc
├── ...
└── ...
```

保留与 `$HOME` 相同的目录和文件名称，可以直接映射回最终位置，降低管理成本。Preserve directory and file names identical to those under `$HOME` so they map back to their final locations seamlessly and reduce management overhead.
