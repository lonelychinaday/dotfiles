return {
    "stevearc/conform.nvim",
    event ={ "BufWritePre", "BufNewFile" },
    config = function()
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                html = { "prettierd" },
                css = { "prettierd" },
                scss = { "prettierd" },
                less = { "prettierd" },
                javascript = { "prettierd" },
                typescript = { "prettierd" },
                vue = { "prettierd" },
                javascriptreact = { "prettierd" },
                typescriptreact = { "prettierd" },
                lua = { "stylua" },
                markdown = { "prettierd" },
            },
            format_on_save = {
                lsp_fallback = true,
                async = false,
                timeout_ms = 500,
            }
        })
    end,
    keys = {
        {
            "<leader>lf",
            function()
                require("conform").format({
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 500,
                })
            end,
            mode = "n",
        },
    }
}