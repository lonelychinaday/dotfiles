return {
    "sainnhe/sonokai",
    -- lazy = false,
    priority = 1000,
    config = function()
        -- 启用透明背景(与终端背景融合)
        vim.g.sonokai_transparent_background = "1"
        
        -- 启用斜体字体(用于注释和关键字)
        vim.g.sonokai_enable_italic = "1"
        
        -- 设置主题风格为 andromeda
        vim.g.sonokai_style = "andromeda"
        
        -- 应用配色方案
        vim.cmd.colorscheme("sonokai")
    end,
}