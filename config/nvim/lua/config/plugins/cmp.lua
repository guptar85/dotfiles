return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",        -- LSP completions
    "hrsh7th/cmp-buffer",          -- Buffer words
    "hrsh7th/cmp-path",            -- Filesystem paths
    "hrsh7th/cmp-cmdline",         -- Command line completion
    "L3MON4D3/LuaSnip",            -- Snippets engine
    "saadparwaiz1/cmp_luasnip",    -- Snippet completions
    "rafamadriz/friendly-snippets" -- Pre-made snippets
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- Load snippet sources
    require("luasnip.loaders.from_vscode").lazy_load()                                 -- Pre-made VSCode-style snippets
    require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets" }) -- Custom personal snippets

    -- Treat 'telekasten' files as 'markdown' for snippets
    luasnip.filetype_extend("telekasten", { "markdown" })

    -- ✨ Enable LuaSnip advanced behavior
    luasnip.config.set_config({
      history = true,                             -- Allow reusing snippets
      updateevents = "TextChanged,TextChangedI",   -- Live updates while typing
      enable_autosnippets = true,                  -- Allow autosnippets if added later
    })

    -- 🧠 Completion setup
    cmp.setup({
      formatting = {
        format = function(entry, vim_item)
          local source_names = {
            nvim_lsp = "LSP",
            luasnip = "🧠 Snippet",
            buffer = "📄 Buffer",
            path = "📁 Path",
          }
          vim_item.menu = source_names[entry.source.name] or entry.source.name
          return vim_item
        end,
      },

      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),

        -- Tab navigation for completion & snippets
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
    })

    -- Command line completion (search)
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- Command line completion (:)
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })
  end,
}
