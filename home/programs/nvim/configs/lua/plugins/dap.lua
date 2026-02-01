return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      -- 1) Adapter: prefer Mason-installed codelldb if present, fallback to "codelldb" in PATH.
      local mason_codelldb = vim.fn.expand("~/.local/share/nvim/mason/bin/codelldb")
      if vim.fn.executable(mason_codelldb) == 1 then
        -- codelldb >= 1.11 supports stdio; this simple "executable" form usually works.
        dap.adapters.codelldb = {
          type = "executable",
          command = mason_codelldb,
          -- no args needed for stdio mode
        }
      else
        -- fallback: rely on PATH's codelldb (or you can change to lldb-vscode)
        dap.adapters.codelldb = {
          type = "executable",
          command = "codelldb",
        }
      end

      -- 2) Configurations usable for c/cpp/rust
      dap.configurations.cpp = {
        {
          name = "Launch executable",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp

      -- 3) Leader-based keymaps (no function keys)
      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }

      -- session control
      map("n", "<leader>dc", function()
        require("dap").continue()
      end, vim.tbl_extend("force", opts, { desc = "Debug: Continue / Start" }))

      map("n", "<leader>ds", function()
        require("dap").step_over()
      end, vim.tbl_extend("force", opts, { desc = "Debug: Step Over" }))

      map("n", "<leader>di", function()
        require("dap").step_into()
      end, vim.tbl_extend("force", opts, { desc = "Debug: Step Into" }))

      map("n", "<leader>do", function()
        require("dap").step_out()
      end, vim.tbl_extend("force", opts, { desc = "Debug: Step Out" }))

      map("n", "<leader>dr", function()
        require("dap").repl.toggle()
      end, vim.tbl_extend("force", opts, { desc = "Debug: Toggle REPL" }))

      map("n", "<leader>db", function()
        require("dap").toggle_breakpoint()
      end, vim.tbl_extend("force", opts, { desc = "Debug: Toggle Breakpoint" }))

      map("n", "<leader>dw", function()
        require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, vim.tbl_extend("force", opts, { desc = "Debug: Conditional Breakpoint" }))

      map("n", "<leader>dp", function()
        require("dap").pause()
      end, vim.tbl_extend("force", opts, { desc = "Debug: Pause" }))

      map("n", "<leader>de", function()
        require("dap").terminate()
      end, vim.tbl_extend("force", opts, { desc = "Debug: Terminate Session" }))
      -- optional: set signs (you already had these; keep them)
      vim.fn.sign_define(
        "DapBreakpoint",
        { text = "●", texthl = "", linehl = "debugBreakpoint", numhl = "debugBreakpoint" }
      )
      vim.fn.sign_define(
        "DapBreakpointCondition",
        { text = "◆", texthl = "", linehl = "debugBreakpoint", numhl = "debugBreakpoint" }
      )
      vim.fn.sign_define("DapStopped", { text = "▶", texthl = "Search", linehl = "debugPC", numhl = "debugPC" })
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      -- dapui.setup({
      --   -- you can configure layouts here; defaults are fine if you want minimal setup
      -- })

      -- recommended listener hooks (open after session initialized, close before exit/terminate)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- some quick toggles via leader
      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }
      map("n", "<leader>tu", "<CMD>lua require('dapui').toggle()<CR>", opts)
      map("n", "<leader>tb", "<CMD>lua require('dap').toggle_breakpoint()<CR>", opts)
    end,
  },

  -- optional: show inline variables as virtual text
  {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },
}
