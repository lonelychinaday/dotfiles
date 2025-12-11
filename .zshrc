# ===============================================
# Oh My Zsh 核心配置 / Core Oh My Zsh setup
# ===============================================

# 基础信息 / Base info
export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="random"  # 默认主题 / Default theme
ZSH_THEME="avit"  # 默认主题 / Default theme

# 插件配置 / Plugins configuration
plugins=(
  git                       # Git 常用增强 / Core Git helpers
  zsh-syntax-highlighting   # 命令高亮 / Command highlighting
  zsh-autosuggestions       # 历史命令建议 / History-based suggestions
)

# 加载 Oh My Zsh / Load Oh My Zsh
source "$ZSH/oh-my-zsh.sh"

# 语言与排序 / Locale & collation
export LANG=zh_CN.UTF-8
export LC_COLLATE=C

# ===============================================
# Shell 行为设置 / Shell behavior tweaks
# ===============================================

HISTFILE="$HOME/.zsh_history"
HISTSIZE=5000
SAVEHIST=5000
export REPORTTIME=3                # 执行超过 3 秒显示耗时 / Report runtime for commands >3s

setopt APPEND_HISTORY              # 追加写入历史 / Append history instead of overwriting
setopt SHARE_HISTORY               # 会话之间共享历史 / Share history across sessions
setopt HIST_IGNORE_DUPS            # 忽略重复命令 / Ignore duplicate commands
setopt HIST_FIND_NO_DUPS           # 搜索时跳过重复 / Skip duplicates when searching history
setopt AUTO_CD                     # 直接输入目录即可进入 / Allow directory switch without cd
setopt AUTO_PUSHD                  # 维护目录栈 / Auto pushd on cd
setopt PUSHD_IGNORE_DUPS           # 去重目录栈 / Remove duplicate directories in stack
setopt CORRECT                     # 轻量命令纠错 / Command auto correction
setopt EXTENDED_GLOB               # 扩展通配符 / Enable extended globbing
setopt INTERACTIVE_COMMENTS        # 支持 # 注释 / Allow comments in interactive shell
setopt COMPLETE_IN_WORD            # 单词中间补全 / Complete within words
unsetopt BEEP                      # 禁用蜂鸣 / Disable terminal bell

# ===============================================
# CLI 环境变量与 PATH / CLI env & PATH
# ===============================================

# PATH 工具函数 / PATH helper utilities
path_prepend() {  # 将目录插入 PATH 头部 / Prepend directory to PATH
  local dir="$1"
  [[ -z "$dir" ]] && return
  case ":$PATH:" in
    *":$dir:"*) ;;  # 已存在则跳过 / Skip if already present
    *) PATH="$dir${PATH:+":$PATH"}" ;;
  esac
}

path_append() {  # 将目录附加到 PATH 尾部 / Append directory to PATH
  local dir="$1"
  [[ -z "$dir" ]] && return
  case ":$PATH:" in
    *":$dir:"*) ;;
    *) PATH="${PATH:+${PATH}:}$dir" ;;
  esac
}

# PATH 统一配置 / Consolidated PATH setup
path_prepend "$HOME/bin"
path_prepend "/usr/local/bin"
path_prepend "$HOME/.codeium/windsurf/bin"
path_prepend "$HOME/.antigravity/antigravity/bin"
path_prepend "$HOME/.local/share/nvim/mason/bin"
path_append "/Applications/WezTerm.app/Contents/MacOS"
export PATH

# ===============================================
# 扩展函数占位 / Function placeholders
# ===============================================
# 如需自定义函数，可在此处添加 / Add custom functions here when needed

# ===============================================
# 常用别名 / Common aliases
# ===============================================

alias vim="nvim"
alias p="pnpm"

# alias | grep git

# alias gss = "git status --short"
# alias ga = "git add"
# alias gaa = "git add --all"
# alias gapa = "git add --patch"
# alias gcmsg = "git commit --message"
# alias gl = "git pull"
# alias gp = "git push"
# glola='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --all'
# alias gb = "git branch"

# ===============================================
# 提示符与其他工具 / Prompt & additional tooling
# ===============================================


export EDITOR="nvim"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}



# eval "$(starship init zsh)"  # 启用 Starship / Enable Starship prompt
