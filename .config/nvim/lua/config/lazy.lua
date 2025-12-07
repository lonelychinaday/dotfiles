-- 插件管理器配置文件

-- vim.fn.stdpath("data") = "~/.local/share/nvim"
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- 检查 lazy.nvim 是否已安装
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

-- 将 lazy.nvim 添加到运行时路径
vim.opt.rtp:prepend(lazypath)

-- 设置 Lazy.nvim 的默认配置
require("lazy").setup({
    spec = {
        { import = "plugins" }, -- 读取 lua/plugins 下的插件
    },
})

