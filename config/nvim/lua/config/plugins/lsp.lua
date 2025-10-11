-- ~/.config/nvim/lua/config/plugins/lsp.lua
return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig", "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      mason_lspconfig.setup({
        ensure_installed = { "lua_ls", "ts_ls", "html", "cssls", "bashls" },
        automatic_installation = true,
      })

      -- Capabilities for completion (cmp integration)
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- on_attach now doesn’t define mappings (handled in which-key)
      local on_attach = function(_, _)
        -- Nothing here now, all keymaps are in which-key.lua
      end

      -- Configure installed servers with new API
      for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
        vim.lsp.config[server] = {
          capabilities = capabilities,
          on_attach = on_attach,
        }
        vim.lsp.enable(server)
      end
    end,
  },
}