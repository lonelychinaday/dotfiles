return {
  "chomosuke/typst-preview.nvim",
  ft = "typst", -- 仅在 typst 文件中加载 / lazy-load on Typst files
  version = "1.*",
  build = function()
    -- 首次安装或升级时同步二进制依赖 / ensure helper binaries are downloaded
    require("typst-preview").update()
  end,
  opts = {
    debug = true, -- 调试日志，默认关闭 / disable verbose logging
    open_cmd = nil, -- 可在此自定义浏览器启动命令（如 "open %s" 或 "firefox %s"）
    port = 0, -- 0 表示随机端口，避免冲突 / random port
    follow_cursor = true, -- 预览窗口跟随光标 / follow cursor by default
    -- 复用 Mason 安装的 tinymist，避免重复下载
    -- 这里指向 Mason 的可执行文件路径（默认 `${stdpath("data")}/mason/bin/tinymist`）
    dependencies_bin = {
      tinymist = vim.fn.stdpath("data") .. "/mason/bin/tinymist",
      websocat = nil, -- 保持默认下载 / let plugin download websocat automatically
    },
    extra_args = nil, -- 若需传给 typst-preview 的额外参数，可在此填写
  },
  config = function(_, opts)
    local tp = require("typst-preview")
    tp.setup(opts)

    -- 快捷命令示例 / optional helper mappings
    vim.api.nvim_create_user_command("TypstPreviewToggleDoc", function()
      tp.toggle("document")
    end, { desc = "Typst 文档模式预览 / toggle document preview" })

    vim.api.nvim_create_user_command("TypstPreviewToggleSlide", function()
      tp.toggle("slide")
    end, { desc = "Typst 幻灯模式预览 / toggle slide preview" })
  end,
}

