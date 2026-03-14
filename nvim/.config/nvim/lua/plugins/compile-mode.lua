return {
  "ej-shafran/compile-mode.nvim",
  branch = "latest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- if you want to enable coloring of ANSI escape codes in
    -- compilation output, add:
    -- { "m00qek/baleia.nvim", tag = "v1.3.0" },
  },
  config = function()
    ---@type CompileModeOpts

    vim.keymap.set("n", "<leader>cc", "<cmd>Compile<CR>")

    vim.g.compile_mode = {
        default_command = "make -C build/",
        -- if you use something like `nvim-cmp` or `blink.cmp` for completion,
        -- set this to fix tab completion in command mode:
        -- input_word_completion = true,

        -- to add ANSI escape code support, add:
        -- baleia_setup = true,

        -- to make `:Compile` replace special characters (e.g. `%`) in
        -- the command (and behave more like `:!`), add:
        -- bang_expansion = true,
        
        -- Automatically focus the compilation buffer.
        -- :h compile-mode.focus_compilation_buffer
        focus_compilation_buffer = true,
    }
  end
}

