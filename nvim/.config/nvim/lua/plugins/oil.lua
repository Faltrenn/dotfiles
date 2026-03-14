return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
        default_file_explorer = true,
		columns = {
			"permissions",
			"size",
			"mtime",
		},
		skip_confirm_for_simple_edits = true,
		view_options = {
			-- Show files and directories that start with "."
			show_hidden = true,
		},

	},
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
}
