-- 语法解析器，提供精确高亮、代码折叠、智能缩进

-- :TSBufEnable highlight 开启高亮
-- :TSBufDisable highlight 关闭高亮

return {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    main = "nvim-treesitter.configs", -- 主入口
    opts = {
        ensure_installed = {
            "html",
            "css",
            "scss",
            "vue",
            "javascript",
            "typescript",
            "jsdoc",
            "tsx",
            "lua",
            "markdown",
            "markdown_inline",
        },
        highlight = {
            enable = true, -- 启用高亮
        },
    },
    enabled = true,
} 