return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text", -- inline variable values
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      --
      -- 1. Setup nvim-dap-ui
      --
      dapui.setup()
      require("nvim-dap-virtual-text").setup()

      -- Auto-open/close dap-ui when debugging
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      --
      -- 2. Ensure the JS Debug Adapter is installed
      --
      require("mason-nvim-dap").setup({
        ensure_installed = { "js-debug-adapter" },
        automatic_installation = true,
      })

      --
      -- 3. Breakpoint Signs (VSCode / ABAP style)
      --
      vim.fn.sign_define("DapBreakpoint", {
        text = "●", -- red circle
        texthl = "DapBreakpoint",
        linehl = "",
        numhl = ""
      })
      vim.fn.sign_define("DapStopped", {
        text = "▶", -- green arrow
        texthl = "DapStopped",
        linehl = "Visual", -- highlight line where stopped
        numhl = ""
      })
      vim.fn.sign_define("DapBreakpointRejected", {
        text = "", -- warning
        texthl = "DapBreakpointRejected",
        linehl = "",
        numhl = ""
      })

      -- Custom highlight groups
      vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#FF5555" })           -- red
      vim.api.nvim_set_hl(0, "DapStopped", { fg = "#50FA7B", bold = true }) -- green
      vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = "#F1FA8C" })   -- yellow

      --
      -- 4. Pick correct package manager (pnpm > yarn > npm)
      --
      local function detect_package_manager()
        local cwd = vim.fn.getcwd()
        if vim.fn.filereadable(cwd .. "/pnpm-lock.yaml") == 1 then
          return "pnpm"
        elseif vim.fn.filereadable(cwd .. "/yarn.lock") == 1 then
          return "yarn"
        else
          return "npm"
        end
      end

      --
      -- 5. Setup adapter
      --
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        },
      }

      --
      -- 6. Debug configurations
      --
      for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact", "astro" }) do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "▶ Launch current file",
            program = "${file}",
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            protocol = "inspector",
            console = "integratedTerminal",
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "▶ Debug Next.js dev server",
            runtimeExecutable = detect_package_manager(),
            runtimeArgs = { "run", "dev" },
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            port = 9229,
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "🔗 Attach to process",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
        }
      end
    end,
  },
}
