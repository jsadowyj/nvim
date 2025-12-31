local dap = require("dap")
local dapui = require("dapui")

-- Setup dap-ui
dapui.setup()

-- Setup dap-go
require("dap-go").setup()

-- Setup dap-python with dedicated debugpy venv (see README for setup)
require("dap-python").setup("~/.venvs/debugpy/bin/python")

-- When you run `source .venv/bin/activate`, the shell sets $VIRTUAL_ENV
-- to the venv path (e.g., /path/to/project/.venv). This function uses
-- that to find the project's Python interpreter for debugging, so your
-- project's packages are available. Falls back to python3 in PATH if no venv is active.
require("dap-python").resolve_python = function()
  return vim.env.VIRTUAL_ENV and vim.env.VIRTUAL_ENV .. "/bin/python" or "python3"
end

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

-- Alt keys (quick access while debugging)
map("n", "<A-c>", dap.continue, { desc = "DAP continue" })
map("n", "<A-n>", dap.step_over, { desc = "DAP step over" })
map("n", "<A-s>", dap.step_into, { desc = "DAP step into" })
map("n", "<A-o>", dap.step_out, { desc = "DAP step out" })
map("n", "<A-b>", dap.toggle_breakpoint, { desc = "DAP toggle breakpoint" })
map("n", "<A-B>", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "DAP conditional breakpoint" })
map("n", "<A-t>", dap.terminate, { desc = "DAP terminate" })
map("n", "<A-u>", dapui.toggle, { desc = "DAP toggle UI" })
map("n", "<A-r>", dap.repl.open, { desc = "DAP open REPL" })

-- Go specific
map("n", "<leader>dgt", function()
  require("dap-go").debug_test()
end, { desc = "DAP Go debug test" })
map("n", "<leader>dgl", function()
  require("dap-go").debug_last_test()
end, { desc = "DAP Go debug last test" })

-- Python specific
map("n", "<leader>dpt", function()
  require("dap-python").test_method()
end, { desc = "DAP Python debug test method" })
map("n", "<leader>dpc", function()
  require("dap-python").test_class()
end, { desc = "DAP Python debug test class" })
