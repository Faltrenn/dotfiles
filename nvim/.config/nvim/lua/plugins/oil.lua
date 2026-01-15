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
		})
	end,
}
