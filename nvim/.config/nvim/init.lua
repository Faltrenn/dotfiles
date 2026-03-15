vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local keymap = vim.keymap
local pack = vim.pack

-- Plenary | Plugin toolkit | Some plugins depends on it
pack.add{{ name = "plenary", src = "https://github.com/nvim-lua/plenary.nvim" }}

-- Catppuccin | Colorscheme
pack.add{{ name = "catppuccin", src = "https://github.com/catppuccin/nvim" }}

vim.cmd.colorscheme "catppuccin-nvim"

-- Oil | File explorer

pack.add{{ name = "oil", src = "https://github.com/stevearc/oil.nvim" }}

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

pack.add{{ name = "neogit", src = "https://github.com/NeogitOrg/neogit" }}

require("neogit").setup({
	kind ="floating",
	commit_editor = {
		kind = "floating",
		show_staged_diff = true,
		spell_check = true,
	}
})

keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>")

-- Vim Tmux Navigator | Easy navigation between neovim windows and tmux panels

pack.add{{ name="vim-tmux-navigator", src = "https://github.com/christoomey/vim-tmux-navigator" }}

-- Treesitter | Better code highlight
pack.add{{ name = "treesitter", src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" }}

require("nvim-treesitter.configs").setup({
    auto_install = true,
    indent = { enable = true },

    ignore_install = { "latex" },
    highlight = {
	enable = true,

	disable = { "latex" },
    },
})

-- Some basic configs

vim.o.undofile = true
vim.o.number = true
