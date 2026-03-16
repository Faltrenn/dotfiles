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

local ignore_types = { "", "oil", "NeogitStatus", "nvim-pack" }
local ignore_list = {}
for _, type in ipairs(ignore_types) do
    ignore_list[type] = true
end

vim.api.nvim_create_autocmd('FileType', {
    pattern = { "*" },
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local ft = vim.bo[bufnr].filetype

        -- Ignora tipos de arquivo vazios ou específicos como 'oil'
        if ignore_list[ft] then return end

        local ok = pcall(vim.treesitter.start, bufnr)

        if not ok then
            local lang = vim.treesitter.language.get_lang(ft) or ft

            if ignore_list[lang] then return end

            vim.cmd("TSInstall " .. lang)

            local function try_start_later()
                vim.defer_fn(function()
                    -- Tenta iniciar o treesitter
                    if pcall(vim.treesitter.start, bufnr) then
                        print("Treesitter activated for " .. lang)
                        return
                    end
                    try_start_later()
                end, 1000)
            end

            -- INICIA a primeira tentativa
            try_start_later()
        end
    end
})

-- Multicursor | Enable multicursors

pack.add {{ name = "multicursor", src = "https://github.com/jake-stewart/multicursor.nvim", version = "1.0"}}
local mc = require("multicursor-nvim")
mc.setup()
-- Add or skip cursor above/below the main cursor.
keymap.set({"n", "x"}, "<up>", function() mc.lineAddCursor(-1) end)
keymap.set({"n", "x"}, "<down>", function() mc.lineAddCursor(1) end)
keymap.set({"n", "x"}, "<leader><up>", function() mc.lineSkipCursor(-1) end)
keymap.set({"n", "x"}, "<leader><down>", function() mc.lineSkipCursor(1) end)

-- Add or skip adding a new cursor by matching word/selection
keymap.set({"n", "x"}, "<leader>n", function() mc.matchAddCursor(1) end)
keymap.set({"n", "x"}, "<leader>s", function() mc.matchSkipCursor(1) end)
keymap.set({"n", "x"}, "<leader>N", function() mc.matchAddCursor(-1) end)
keymap.set({"n", "x"}, "<leader>S", function() mc.matchSkipCursor(-1) end)

-- Disable and enable cursors.
-- set({"n", "x"}, "<c-q>", mc.toggleCursor)

-- Mappings defined in a keymap layer only apply when there are
-- multiple cursors. This lets you have overlapping mappings.
mc.addKeymapLayer(function(layerSet)
    -- Select a different cursor as the main one.
    layerSet({"n", "x"}, "<left>", mc.prevCursor)
    layerSet({"n", "x"}, "<right>", mc.nextCursor)

    -- Delete the main cursor.
    layerSet({"n", "x"}, "<leader>x", mc.deleteCursor)

    -- Enable and clear cursors using escape.
    layerSet("n", "<esc>", mc.clearCursors)
end)

-- Live Server | Hot reload to web project

pack.add {{ name="live-server", src="https://github.com/ngtuonghy/live-server-nvim" }}

require("live-server-nvim").setup {
    custom = {
        "--port=8080",
        "--no-css-inject",
    },
    serverPath = vim.fn.stdpath("data") .. "/live-server/", --default
    open = "folder", -- folder|cwd     --default
}

-- Some basic configs

vim.o.undofile = true
vim.o.number = true
vim.o.tabstop = 4      -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4  -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4   -- Number of spaces inserted when indenting
vim.o.scrolloff = 10   -- Set line offset in scroll

keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- Close search highlight

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
