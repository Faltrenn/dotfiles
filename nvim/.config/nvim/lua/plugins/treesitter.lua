return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    opts = {
        auto_install = true,
        indent = { enable = true },

        ignore_install = { "latex" },
        highlight = {
            enable = true,

            disable = { "latex" }, -- Best highlight by latex plugin.
        },
    }
}
