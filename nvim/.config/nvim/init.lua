-- Plenary | Plugin toolkit | Some plugins depends on it
pack.add{{ src = "https://github.com/nvim-lua/plenary.nvim", name = "plenary" }}

-- Catppuccin | Colorscheme
pack.add{{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" }}

vim.cmd.colorscheme "catppuccin-nvim"

