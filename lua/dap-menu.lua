vim.keymap.set({ "n" }, "<leader>m", function()
  local dap = require "dap"
  require("menu").open {
    {
      name = "󰤑 Run Tests",
      hl = "@conditional",
      cmd = function()
        dap.run {
          type = "python", -- Ajusta el tipo según tu entorno
          request = "launch",
          name = "Run Tests",
          program = "${file}", -- Ajusta según sea necesario
        }
      end,
      rtxt = "t",
    },
    { name = "separator" },
    {
      name = " Continue",
      cmd = function()
        dap.continue()
      end,
      rtxt = "c",
    },
    {
      name = " Toggle Breakpoint",
      cmd = function()
        dap.toggle_breakpoint()
      end,
      rtxt = "b",
    },
    {
      name = " Step Over",
      cmd = function()
        dap.step_over()
      end,
      rtxt = "o",
    },
    {
      name = " Step Into",
      cmd = function()
        dap.step_into()
      end,
      rtxt = "i",
    },
    { name = "separator" },
    {
      name = "󰗂 Step Out",
      hl = "@comment.error",
      cmd = function()
        dap.step_out()
      end,
      rtxt = "u",
    },
    {
      name = "󰍺 Stop",
      cmd = function()
        dap.terminate()
      end,
      rtxt = "s",
    },
  }
end)
