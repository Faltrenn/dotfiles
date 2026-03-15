vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local keymap = vim.keymap
local pack = vim.pack

-- Plenary | Plugin toolkit | Some plugins depends on it
pack.add{{ src = "https://github.com/nvim-lua/plenary.nvim", name = "plenary" }}

-- Catppuccin | Colorscheme
pack.add{{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" }}

vim.cmd.colorscheme "catppuccin-nvim"

-- Oil | File explorer

pack.add{{ src = "https://github.com/stevearc/oil.nvim", name = "oil" }}

require("oil").setup({
	default_file_explorer = true,
	delete_to_trash = true,
	columns = { "permissions", "size", "mtime" },
	skip_confirm_for_simple_edits = true,
	view_options = { show_hidden = true },
	use_default_keymaps = false,
	keymaps = {
		["<CR>"] = "actions.select", -- Select with enter.
		["-"] = { "actions.parent", mode = "n" },
	}
})

keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Neogit | Tool to handle git

pack.add{{ src = "https://github.com/NeogitOrg/neogit", name = "neogit" }}

require("neogit").setup({
	kind ="floating",
	commit_editor = {
		kind = "floating",
		show_staged_diff = true,
		spell_check = true,
	}
})

keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>")

