return {
	"NeogitOrg/neogit",
	lazy = true,
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration
		--
		-- -- Only one of these is needed.
		"nvim-telescope/telescope.nvim", -- optional
		-- "ibhagwan/fzf-lua",              -- optional
		-- "nvim-mini/mini.pick",           -- optional
		-- "folke/snacks.nvim",             -- optional
	},
	config = function()
		require("neogit").setup({
			floating = {
				relative = "editor",
				width = 0.9,
				height = 0.9,
				style = "minimal",
				border = "rounded",
			},
			kind = "floating",
			commit_editor = { kind = "floating" },
			commit_view = {
				kind = "floating",
				verify_commit = vim.fn.executable("gpg") == 1, -- Can be set to true or false, otherwise we try to find the binary
			},
		})
	end,
	cmd = "Neogit",
	-- keys = {
	-- 	{ "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
	-- },
}
