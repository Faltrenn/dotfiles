return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		columns = {
			"permissions",
			"size",
			"mtime",
		},
		skip_confirm_for_simple_edits = false,
		view_options = {
			-- Show files and directories that start with "."
			show_hidden = true,
		},

	},
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
}
