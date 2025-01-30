require("config.lazy")

-- Theme
vim.cmd.colorscheme("catppuccin") -- Define Theme

-- Editor configs
vim.opt.expandtab = true -- Convert TABs in spaces
vim.opt.shiftwidth = 2 -- Number of spaces in each identation level
vim.opt.tabstop = 2 -- Number of spaces the a tab represents
vim.opt.softtabstop = 2 -- Controla a remoção de espaços ao pressionar <BS>
vim.opt.number = true -- Enumerate lines
vim.opt.undofile = true -- Enable undo even after close editor
vim.opt.scrolloff = 10 -- Set line offset in scroll
vim.opt.colorcolumn = "88" -- Set a different color to the character 88 of each line
vim.opt.mouse = "" -- Disable mouse actions

-- Keybindings
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- Close search hover
vim.keymap.set("n", "<leader>pq", "<cmd>Ex<CR>") -- Close file without close editor
vim.keymap.set(
	"n",
	"[d",
	vim.diagnostic.goto_prev,
	{ desc = "Go to previous [D]iagnostic message" }
)
vim.keymap.set(
	"n",
	"]d",
	vim.diagnostic.goto_next,
	{ desc = "Go to next [D]iagnostic message" }
)

vim.keymap.set(
	"n",
	"<leader>q",
	vim.diagnostic.setloclist,
	{ desc = "Open diagnostic [Q]uickfix list" }
)

-- Commands
-- Enable to create nonexistentFolder/newFile in NetRW
vim.api.nvim_create_autocmd("BufNewFile", {
	pattern = "*",
	callback = function()
		local dir = vim.fn.expand("<afile>:p:h")
		if vim.fn.isdirectory(dir) == 0 then
			vim.fn.mkdir(dir, "p")
		end
	end,
})

-- Copy the opened file's path (i use to open html files on browser)
vim.api.nvim_create_user_command("Cppath", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

-- Aliases
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Q", "q", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("WQ", "wq", {})
vim.api.nvim_create_user_command("LAzy", "Lazy <args>", { nargs = "?" })
