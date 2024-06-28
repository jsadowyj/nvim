require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")
map("n", "<leader>fm", function ()
  require("conform").format()
end, { desc = "formatting" })

map("n", "<Enter>", "o<Esc>", { desc = "insert newline" })
map("n", "<S-Enter>", "O<Esc>", { desc = "insert newline above" })

map("n", "c", "\"_c", { desc = "disable copy on change" })

map("n", "<leader>q", ":q<CR>", { desc = "quit buffer" })

map("n", "=", ":vertical resize +5<CR>")
map("n", "-", ":vertical resize -5<CR>")
map("n", "+", ":horizontal resize +2<CR>")
map("n", "_", ":horizontal resize -2<CR>")


map("v", ">", ">gv", { desc = "select line on right indent" })
map("v", "<", "<gv", { desc = "select line on left indent" })

map("t", "<C-Space>", "<C-\\><C-n>", { desc = "escape from terminal" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
