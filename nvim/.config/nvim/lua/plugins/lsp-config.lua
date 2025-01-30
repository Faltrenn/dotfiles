_G.lsps = { "lua_ls", "pyright", "sqlls", "ts_ls", "html" }

return {
  { -- Manage lp's, linters, formaters
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  { -- Connect mason to lspconfig
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = _G.lsps,
      })
    end,
  },
  { -- Connect editor to lspservers and manage requests
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      -- Config of lsp's
      for _, lsp in ipairs(_G.lsps) do
        lspconfig[lsp].setup({
          capabilities = capabilities,
          root_dir = function(fname)
            return vim.loop.cwd()
          end,
        })
      end

      -- Keybindings
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
  { -- Show lsp things
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").lazy_load()

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
  { -- Add snippets possibility
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
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
}
