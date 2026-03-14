return {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
        "nvim-lua/plenary.nvim",         -- required
    },
    cmd = "Neogit",
    keys = {
        { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
    },
    opts = {
        kind ="floating",
        commit_editor = {
            kind = "floating",
            show_staged_diff = true,
            spell_check = true,
        }
    }
}
