require("config.lazy")

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.cmd.colorscheme "catppuccin-nvim"
