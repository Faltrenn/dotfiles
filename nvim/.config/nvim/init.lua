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

pack.add{{ name = "treesitter", src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" }}

local parser_install_dir = vim.fn.stdpath('data') .. '/site'
vim.opt.runtimepath:prepend(parser_install_dir)

require('nvim-treesitter').setup {
	install_dir = parser_install_dir,
}

vim.api.nvim_create_autocmd('FileType', {
    pattern = { "*" },
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local ft = vim.bo[bufnr].filetype
        
        -- Ignora tipos de arquivo vazios ou específicos como 'oil'
        if ft == "" or ft == "oil" then return end

        local ok = pcall(vim.treesitter.start, bufnr)

        if not ok then
            -- Tenta descobrir o nome da linguagem para o Treesitter
            local lang = vim.treesitter.language.get_lang(ft) or ft
            
            vim.cmd("TSInstall " .. lang)

            local function try_start_later()
                vim.defer_fn(function()
                    -- Tenta iniciar o treesitter
                    if pcall(vim.treesitter.start, bufnr) then
                        print("Treesitter activated for " .. lang)
			return
                    end
		    try_start_later() -- RECURSÃO: Tenta novamente se falhou
                end, 1000)
            end
            
            -- INICIA a primeira tentativa
            try_start_later()
        end
    end
})

-- Some basic configs

vim.o.undofile = true
vim.o.number = true

-- Aliases
vim.api.nvim_create_user_command("W",     "w",     {})
vim.api.nvim_create_user_command("Q",     "q",     {})
-- vim.api.nvim_create_user_command("W!",    "w!",    {})
-- vim.api.nvim_create_user_command("Q!",    "q!",    {})
vim.api.nvim_create_user_command("Qa",    "qa",    {})
vim.api.nvim_create_user_command("Wq",    "wq",    {})
vim.api.nvim_create_user_command("WQ",    "wq",    {})
vim.api.nvim_create_user_command("Wqa",   "wqa",   {})
vim.api.nvim_create_user_command("WQa",   "wqa",   {})
