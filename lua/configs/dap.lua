local dap = require("dap")
local dapui = require("dapui")

-- Setup dap-ui
dapui.setup()

-- Setup dap-go
require("dap-go").setup()

-- Auto open/close dapui
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

-- Keymaps
local map = vim.keymap.set
map("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP toggle breakpoint" })
map("n", "<leader>dB", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "DAP conditional breakpoint" })
map("n", "<leader>dc", dap.continue, { desc = "DAP continue" })
map("n", "<leader>di", dap.step_into, { desc = "DAP step into" })
map("n", "<leader>do", dap.step_over, { desc = "DAP step over" })
map("n", "<leader>dO", dap.step_out, { desc = "DAP step out" })
map("n", "<leader>dr", dap.repl.open, { desc = "DAP open REPL" })
map("n", "<leader>dl", dap.run_last, { desc = "DAP run last" })
map("n", "<leader>du", dapui.toggle, { desc = "DAP toggle UI" })
map("n", "<leader>dt", dap.terminate, { desc = "DAP terminate" })

-- Go specific
map("n", "<leader>dgt", function()
  require("dap-go").debug_test()
end, { desc = "DAP Go debug test" })
map("n", "<leader>dgl", function()
  require("dap-go").debug_last_test()
end, { desc = "DAP Go debug last test" })
