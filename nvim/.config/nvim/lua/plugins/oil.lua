return {
	"stevearc/oil.nvim",
	config = function()
		require("oil").setup({
			-- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
			delete_to_trash = true,
			-- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
			skip_confirm_for_simple_edits = true,
			columns = {
				-- "icon",
				"permissions",
				"size",
				"mtime",
			},
			view_options = {
				-- Show files and directories that start with "."
				show_hidden = true,
			},
			use_default_keymaps = false,
			keymaps = {
				-- ["g?"] = { "actions.show_help", mode = "n" },
				["<CR>"] = "actions.select",
				-- ["<C-s>"] = { "actions.select", opts = { vertical = true } },
				-- ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
				-- ["<C-t>"] = { "actions.select", opts = { tab = true } },
				-- ["<C-p>"] = "actions.preview",
				-- ["<C-c>"] = { "actions.close", mode = "n" },
				-- ["<C-l>"] = "actions.refresh",
				["-"] = { "actions.parent", mode = "n" },
				-- ["_"] = { "actions.open_cwd", mode = "n" },
				-- ["`"] = { "actions.cd", mode = "n" },
				-- ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
				-- ["gs"] = { "actions.change_sort", mode = "n" },
				-- ["gx"] = "actions.open_external",
				-- ["g."] = { "actions.toggle_hidden", mode = "n" },
				-- ["g\\"] = { "actions.toggle_trash", mode = "n" },
			},
		})
	end,
}
