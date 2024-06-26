local autocmd = vim.api.nvim_create_autocmd

-- Enables LSP for ansible files
autocmd({"BufRead", "BufNewFile"}, {
  pattern = {
     "**/roles/*.y*ml",
     "**/tasks/*.y*ml",
     "**/vars/*.y*ml",
     "**/handlers/*.y*ml",
     "**/*ansible*/*.y*ml",
     "**/playbooks/*.y*ml",
   },
  command = "set filetype=yaml.ansible"
})

-- Enables LSP for ansible files
 autocmd({"BufRead", "BufNewFile"}, {
  pattern = {
     "*.tf",
   },
  command = "set filetype=terraform"
 })
