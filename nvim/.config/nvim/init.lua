require("config.lazy")

vim.cmd.colorscheme("catppuccin")

local keymap = vim.keymap

keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.o.number = true
vim.o.tabstop = 4      -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4  -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4   -- Number of spaces inserted when indenting

vim.o.undofile = true  -- Preserves undo even when close file
vim.opt.scrolloff = 10 -- Set line offset in scroll

-- Keybindings
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")                          -- Close search hover

NEOGIT_DIR = require("oil").get_current_dir()

keymap.set("n", "<leader>cwd", function()
    NEOGIT_DIR = require("oil").get_current_dir()
    if not NEOGIT_DIR then
        NEOGIT_DIR = vim.fn.expand("%:p:h")
    end
    print("Neogit Working Directory setted to", NEOGIT_DIR)
end, { desc = "Change neogit working directory" })

keymap.set({"n", "v"}, "<leader>gg", function ()
    require("neogit").open({ cwd=NEOGIT_DIR })
end, { desc = "Show Neogit UI" })

-- Telescope config
local builtin = require("telescope.builtin")

keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
keymap.set("n", "<leader>fg", builtin.live_grep,  { desc = "Telescope live grep"  })
keymap.set("n", "<leader>fb", builtin.buffers,    { desc = "Telescope buffers"    })
keymap.set("n", "<leader>fh", builtin.help_tags,  { desc = "Telescope help tags"  })

-- Aliases
vim.api.nvim_create_user_command("W",     "w",     {})
vim.api.nvim_create_user_command("Q",     "q",     {})
vim.api.nvim_create_user_command("Qa",    "qa",    {})
vim.api.nvim_create_user_command("Wq",    "wq",    {})
vim.api.nvim_create_user_command("WQ",    "wq",    {})
vim.api.nvim_create_user_command("Wqa",   "wqa",   {})
vim.api.nvim_create_user_command("WQa",   "wqa",   {})
vim.api.nvim_create_user_command("LAzy",  "Lazy <args>", { nargs = "?" })
vim.api.nvim_create_user_command("MAson", "Mason", {})
