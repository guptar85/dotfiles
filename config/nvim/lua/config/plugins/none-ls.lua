-- ~/.config/nvim/lua/config/plugins/none-ls.lua
return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "jay-babu/mason-null-ls.nvim",
    "gbprod/none-ls-shellcheck.nvim", -- Shellcheck
    "nvimtools/none-ls-extras.nvim", -- ✅ ESLint sources
  },
  config = function()
    local null_ls = require("null-ls")

    local sources = {
      -- JavaScript / TypeScript
      null_ls.builtins.formatting.prettier,
      require("none-ls.diagnostics.eslint_d"), -- diagnostics
      require("none-ls.code_actions.eslint_d"), -- code actions

      -- Lua
      null_ls.builtins.formatting.stylua,

      -- Bash / Shell
      null_ls.builtins.formatting.shfmt,
      require("none-ls-shellcheck.diagnostics"),
      require("none-ls-shellcheck.code_actions"),

      -- Markdown
      null_ls.builtins.diagnostics.markdownlint,
      null_ls.builtins.formatting.prettier,
    }

    -- ✅ Create augroup only once
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    null_ls.setup({
      sources = sources,
      on_attach = function(client, bufnr)
        -- Filetypes you do NOT want autoformatted
        local ignore_ft = { "lua", "markdown" }

        if client.supports_method("textDocument/formatting")
          and not vim.tbl_contains(ignore_ft, vim.bo[bufnr].filetype) then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end
      end,
    })

    require("mason-null-ls").setup({
      ensure_installed = {
        "prettier",
        "stylua",
        "shfmt",
        "shellcheck",
        "eslint_d",
        "markdownlint",
      },
      automatic_installation = true,
    })
  end,
}
