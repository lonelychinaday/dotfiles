return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		require("utils.diagnostics").setup()
		require("servers")
	end,
}
