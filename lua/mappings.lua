require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")
map("n", "<leader>fm", function()
  require("conform").format()
end, { desc = "formatting" })

map("n", "<Leader>bdo", ":BufDelOther<CR>", { desc = "Delete all other buffers" })

-- map("n", "<Enter>", "o<Esc>", { desc = "insert newline" })
-- map("n", "<S-Enter>", "O<Esc>", { desc = "insert newline above" })

map("n", "c", '"_c', { desc = "disable copy on change" })

map("n", "<leader>q", ":q<CR>", { desc = "quit buffer" })

map("n", "=", ":vertical resize +5<CR>")
map("n", "-", ":vertical resize -5<CR>")
map("n", "+", ":horizontal resize +2<CR>")
map("n", "_", ":horizontal resize -2<CR>")

map("v", ">", ">gv", { desc = "select line on right indent" })
map("v", "<", "<gv", { desc = "select line on left indent" })
map("n", "<leader>y", '"+y', { desc = "yank to clipboard" })
map("n", "<leader>yy", '"+y', { desc = "yank line to clipboard" })
map("v", "<leader>y", '"+y', { desc = "yank selection to clipboard" })

map("t", "<C-Space>", "<C-\\><C-n>", { desc = "escape from terminal" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--
map("n", "<leader>S", function()
  require("spectre").toggle()
end, { desc = "Toggle Spectre" })

map("n", "<leader>sw", function()
  require("spectre").open_visual { select_word = true }
end, { desc = "Search current word" })

map("v", "<leader>sw", function()
  require("spectre").open_visual()
end, {
  desc = "Search current word (visual mode)",
})

map("n", "<leader>sp", function()
  require("spectre").open_file_search { select_word = true }
end, {
  desc = "Search on current file",
})

-- Gitsigns
map("n", "]c", function()
  if vim.wo.diff then return "]c" end
  vim.schedule(function() require("gitsigns").next_hunk() end)
  return "<Ignore>"
end, { expr = true, desc = "Next git hunk" })

map("n", "[c", function()
  if vim.wo.diff then return "[c" end
  vim.schedule(function() require("gitsigns").prev_hunk() end)
  return "<Ignore>"
end, { expr = true, desc = "Previous git hunk" })

map("n", "<leader>hs", function() require("gitsigns").stage_hunk() end, { desc = "Stage hunk" })
map("n", "<leader>hr", function() require("gitsigns").reset_hunk() end, { desc = "Reset hunk" })
map("v", "<leader>hs", function() require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage hunk" })
map("v", "<leader>hr", function() require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset hunk" })
map("n", "<leader>hS", function() require("gitsigns").stage_buffer() end, { desc = "Stage buffer" })
map("n", "<leader>hu", function() require("gitsigns").undo_stage_hunk() end, { desc = "Undo stage hunk" })
map("n", "<leader>hR", function() require("gitsigns").reset_buffer() end, { desc = "Reset buffer" })
map("n", "<leader>hp", function() require("gitsigns").preview_hunk() end, { desc = "Preview hunk" })
map("n", "<leader>hb", function() require("gitsigns").blame_line({ full = true }) end, { desc = "Blame line" })
map("n", "<leader>hd", function() require("gitsigns").diffthis() end, { desc = "Diff this" })
map("n", "<leader>hD", function() require("gitsigns").diffthis("~") end, { desc = "Diff this ~" })

-- Todo comments
map("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next todo comment" })
map("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous todo comment" })
map("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })

-- Minuet AI
map("n", "<leader>mt", "<cmd>Minuet virtualtext toggle<cr>", { desc = "Toggle Minuet AI" })

-- Telescope git
map("n", "<leader>fg", "<cmd>Telescope git_status<cr>", { desc = "Find git modified files" })
