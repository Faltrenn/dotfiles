return { -- Better syntax highlighting
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      auto_install = true,
      indent = { enable = true },

      ignore_install = { "latex" },
      highlight = {
        enable = true,

        disable = { "latex" },
      },
    })
  end,
}
