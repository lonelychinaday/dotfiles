-- lua/plugins/nvim-spectre.lua
return {
  "nvim-pack/nvim-spectre",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>rs", function() require("spectre").open_file_search() end },
    { "<leader>rS", function() require("spectre").open() end },
    { "<leader>rw", function() require("spectre").open_visual({ select_word = true }) end },
  },
}