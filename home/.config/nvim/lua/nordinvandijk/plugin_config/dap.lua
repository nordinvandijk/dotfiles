return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
    },
    config = function()
      local dap = require "dap"
      local ui = require "dapui"

      require("dapui").setup()
      local mason_registry = require("mason-registry")
      local install_dir = vim.fn.stdpath("data") .. "/mason"

      -- Get the installation path for netcoredbg
      -- local netcoredbg_pkg = mason_registry.get_package("netcoredbg")
      -- local netcoredbg_path = netcoredbg_pkg:get_install_path() .. "/netcoredbg"

      -- Configure the .NET adapter (CoreCLR)
      dap.adapters.coreclr = {
        type = "executable",
        command = install_dir .. '/packages/netcoredbg/netcoredbg',
        args = {"--interpreter=vscode"}
      }

      dap.adapters.netcoredbg = {
        type = "executable",
        command = install_dir .. '/packages/netcoredbg/netcoredbg',
        args = {"--interpreter=vscode"}
      }

      vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
      vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

      -- Eval var under cursor
      vim.keymap.set("n", "<space>?", function()
        require("dapui").eval(nil, { enter = true })
      end)

      vim.keymap.set("n", "<F1>", dap.continue)
      vim.keymap.set("n", "<F2>", dap.step_into)
      vim.keymap.set("n", "<F3>", dap.step_over)
      vim.keymap.set("n", "<F4>", dap.step_out)

      vim.keymap.set("n", "<F5>", dap.step_back)
      vim.keymap.set("n", "<F13>", dap.restart)


      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end

      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },
}
