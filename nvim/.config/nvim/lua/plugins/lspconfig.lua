return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local keymap = vim.keymap

			-- Keybindings
			keymap.set("n", "K", vim.lsp.buf.hover, {})
			keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
			keymap.set({ "n", "v" }, "<leader>gf", function()
				vim.lsp.buf.format({ timeout_ms = 1000 })
			end, {})

			-- Garante que o módulo utilitário nativo esteja carregado.
			local lsp_util = require("lspconfig.util")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local sourcekit_path_full = vim.fn.system("xcrun -f sourcekit-lsp")
			local sourcekit_path = sourcekit_path_full:gsub("%s", "")

			vim.lsp.config.sourcekit = {
				cmd = { sourcekit_path },
				filetypes = { "swift", "objective-c", "objective-cpp" },

				-- ⚠️ CORREÇÃO: Usamos o lsp_util carregado explicitamente
				root_dir = lsp_util.root_pattern("Package.swift", ".git", ".xcodeproj"),

				capabilities = capabilities,
			}
		end,
	},
	{
		{
			"mason-org/mason.nvim",
			opts = {
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			},
		},
		{
			"mason-org/mason-lspconfig.nvim",
			opts = {
				-- Autoloads LSPs when mason-lspconfig is installed
				ensure_installed = { "lua_ls" }, -- Example LSPs to install
			},
		},
		{ -- Show lsp things
			"hrsh7th/nvim-cmp",
			config = function()
				local cmp = require("cmp")

				cmp.setup({
					snippet = {
						expand = function(args)
							require("luasnip").lsp_expand(args.body)
						end,
					},
					window = {
						completion = cmp.config.window.bordered(),
						documentation = cmp.config.window.bordered(),
					},
					mapping = cmp.mapping.preset.insert({
						["<C-b>"] = cmp.mapping.scroll_docs(-4),
						["<C-f>"] = cmp.mapping.scroll_docs(4),
						["<C-Space>"] = cmp.mapping.complete(),
						["<C-e>"] = cmp.mapping.abort(),
						["<CR>"] = cmp.mapping.confirm({ select = true }),
					}),
					sources = cmp.config.sources({
						{ name = "nvim_lsp" },
						{ name = "luasnip" },
					}, {
						{ name = "buffer" },
					}),
				})
			end,
		},
		{ -- Connect lsp to cmp
			"hrsh7th/cmp-nvim-lsp",
		},
		{
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
			config = function()
				local ls = require("luasnip")
				local function jump_or_tab(forward)
					return function()
						if forward then
							if ls.expand_or_jumpable() then
								ls.jump(1)
							else
								return vim.api.nvim_replace_termcodes(
									"<Tab>",
									true,
									true,
									true
								)
							end
						else
							if ls.jumpable(-1) then
								ls.jump(-1)
							else
								return vim.api.nvim_replace_termcodes(
									"<C-d>",
									true,
									true,
									true
								)
							end
						end
					end
				end

				-- Add jump to snippets
				vim.keymap.set({ "i", "s" }, "<Tab>", function()
					local termcode = jump_or_tab(true)()
					if termcode then
						vim.api.nvim_feedkeys(termcode, "n", true)
					end
				end, { silent = true })

				vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
					local termcode = jump_or_tab(false)()
					if termcode then
						vim.api.nvim_feedkeys(termcode, "n", true)
					end
				end, { silent = true })
			end,
		},
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "InsertEnter",
		opts = {
			bind = true,
			handler_opts = {
				border = "rounded",
			},
		},
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local null_ls = require("null-ls")

			local limit = 88

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua.with({
						extra_args = { "--column-width", limit },
					}),
					null_ls.builtins.formatting.black.with({
						extra_args = { "--line-length", limit },
					}),
					-- null_ls.builtins.formatting.sql_formatter,
					-- null_ls.builtins.formatting.biome,
					-- null_ls.builtins.formatting.prettier,
					-- null_ls.builtins.formatting.latexindent,
				},
			})
		end,
	},
}
