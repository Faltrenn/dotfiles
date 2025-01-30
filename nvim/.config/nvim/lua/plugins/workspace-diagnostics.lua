return { -- Add the entire project to trouble see diagnostics
	"artemave/workspace-diagnostics.nvim",
	config = function()
		-- Keybind
		vim.api.nvim_set_keymap("n", "<space>z", "", {
			noremap = true,
			callback = function()
				for _, client in ipairs(vim.lsp.buf_get_clients()) do
					require("workspace-diagnostics").populate_workspace_diagnostics(
						client,
						0
					)
				end
			end,
		})
	end,
}
