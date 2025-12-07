return {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
        -- 自定义键位以与 mini.surround 保持一致
        require("nvim-surround").setup({
            -- 键位说明：<leader>sa 添加包裹、<leader>sd 删除包裹、<leader>sc 替换包裹
            keymaps = {
                -- 禁用插入模式
                insert = false,
                -- 禁用插入行模式
                insert_line = false,

                -- 普通模式：<leader>sa{motion}{char} 添加包裹，不换行
                normal = "<leader>sa",
                
                -- 普通模式：<leader>saa{char} 整行就地包裹，不换行
                normal_cur = "<leader>saa",
                
                -- 普通模式：<leader>sA{motion}{char} 行模式添加包裹，换行
                normal_line = "<leader>sA",
                
                -- 普通模式：<leader>sAA{char} 行模式包裹当前行，换行
                normal_cur_line = "<leader>sAA",
                
                -- 删除包裹：<leader>sd{char}
                delete = "<leader>sd",
                
                -- 替换包裹：<leader>sc{旧}{新}
                change = "<leader>sc",
                
                -- 行替换包裹：<leader>sC{旧}{新}
                change_line = "<leader>sC",

                -- 可视模式：<leader>sa 将选区用字符包裹，不换行
                visual = "<leader>sa",
                
                -- 可视行模式：<leader>gsa 行选区包裹，换行
                visual_line = "<leader>sA",
            },
        })
    end
}

-- 现在的核心操作键位为 <leader>sa（添加）、<leader>sd（删除）、<leader>sc（替换）。以下示例中，* 表示光标位置：

--     Old text                    Command               New text
-- ----------------------------------------------------------------------------
--     surr*ound_words             <leader>saiw)         (surround_words)
--     sur*round_word              <leader>saa)          (surround_word)
--     surroun*d words             <leader>sA)           ( surround words )
--     surroun*d words             <leader>sAA)          ( surround words )
--     surr*ound_words             <leader>saiw(         ( surround_words )
--     *make strings               <leader>sa$"          "make strings"
--     [delete ar*ound me!]        <leader>sd]           delete around me!
--     remove <b>HTML t*ags</b>    <leader>sdt           remove HTML tags
--     'change quot*es'            <leader>sc'"          "change quotes"
--     <b>or tag* types</b>        <leader>sch1<CR>      <h1>or tag types</h1>
--     delete(functi*on calls)     <leader>sdf           function calls


-- Visual mode + S