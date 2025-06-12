local function setup_dap_for_brazil_python()
  local dap = require("dap")

  local function merge_to_new(base_table, new_table)
    local merged = {}
    for k, v in pairs(base_table) do
      merged[k] = v
    end
    for k, v in pairs(new_table) do
      merged[k] = v
    end
    return merged
  end

  local function get_nearest_function_name()
    local ts_utils = require("nvim-treesitter.ts_utils")
    local node = ts_utils.get_node_at_cursor()

    while node do
      if node:type() == "function_declaration" then
        return ts_utils.get_node_text(node:child(1))[1]
      end
      node = node:parent()
    end
  end

  local py_conf_base = {
    type = "debugpy",
    request = "launch",
    console = "integratedTerminal",
    autoReload = {
      enabled = true
    },
    justMyCode = true,
  }

  local configs = {
    {
      name = "Pytest - all tests",
      module = "pytest",
      args = {
        "test"
      },
    },
    {
      name = "Pytest - keyword tests",
      module = "pytest",
      args = function()
        return {
          "-k",
          vim.fn.input("Enter test keyword: "),
        }
      end,
    },
    {
      name = "Pytest - this file",
      module = "pytest",
      args = {
        "${file}",
      },
    },
    {
      name = "Pytest - this func",
      module = "pytest",
      args = function()
        local func = get_nearest_function_name()
        if not func then
          func = vim.fn.input("Enter test name: ")
        end
        return {
          "${file}::" .. func,
        }
      end,
    },
    {
      name = "Flask",
      program = "./manage.py",
      args = {
        "runserver",
        "--host",
        "0.0.0.0",
        "--port",
        "8880"
      },
    }
  }
  for _, x in ipairs(configs) do
    table.insert(dap.configurations.python, merge_to_new(py_conf_base, x))
  end
end

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
      "theHamsta/nvim-dap-virtual-text",
    },
    keys = {
      { "<leader>d",  group = "Debugging",                               desc = "Debugging" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint() end,    desc = "Set Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end,          desc = "Continue" },
      { "<leader>do", function() require("dap").step_over() end,         desc = "Step Over" },
      { "<leader>di", function() require("dap").step_into() end,         desc = "Step Into" },
      { "<leader>dO", function() require("dap").step_out() end,          desc = "Step Out" },
      { "<leader>dq", function() require("dap").terminate() end,         desc = "Terminate" },
      { "<leader>dr", function() require("dap").repl.toggle() end,       desc = "Toggle DAP Repl" },
      { "<leader>dl", function() require("dap").run_last() end,          desc = "Run Last" },
      { "<leader>du", function() require("dapui").toggle() end,          desc = "Toggle DAP UI" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local dap_python = require("dap-python")

      require("dapui").setup({})
      require("nvim-dap-virtual-text").setup({
        commented = true, -- Show virtual text alongside comment
      })

      dap_python.setup()
      setup_dap_for_brazil_python()

      vim.fn.sign_define("DapBreakpoint", {
        text = "",
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
      })

      vim.fn.sign_define("DapBreakpointRejected", {
        text = "", -- or "❌"
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
      })

      vim.fn.sign_define("DapStopped", {
        text = "", -- or "→"
        texthl = "DiagnosticSignWarn",
        linehl = "Visual",
        numhl = "DiagnosticSignWarn",
      })

      -- Automatically open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
    end,
  },
}
