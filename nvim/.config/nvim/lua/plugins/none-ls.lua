return { -- Make easy to use linters and code formatters
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua.with({
					extra_args = { "--column-width", "88" },
				}),
				null_ls.builtins.formatting.black.with({
					extra_args = { "--line-length", "88" },
				}),
				null_ls.builtins.formatting.sql_formatter,
				null_ls.builtins.formatting.biome,
				null_ls.builtins.formatting.prettier,
			},
		})
		vim.keymap.set({ "n", "v" }, "<leader>gf", vim.lsp.buf.format, {})
	end,
}

