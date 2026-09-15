-- EXAMPLE 
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "terraformls", "gopls", "jsonnet_ls", "jinja_lsp", "pylsp", "ruby_lsp"}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

lspconfig["ansiblels"].setup({
  filetypes = {
    "yaml.ansible",
  },
  settings = {
    ansible = {
      ansible = {
        path = "ansible",
        useFullyQualifiedCollectionNames = true
      },
      executionEnvironment = {
        enabled = false
      },
      python = {
        interpreterPath = "python3"
      },
      completion = {
        provideRedirectModules = true,
        provideModuleOptionAliases = true
      },
      validation = {
          enabled = true,
          lint = {
            enabled = true,
            path = 'ansible-lint',
            arguments = "-x name,fqcn"
          },
      },
    },
  },
  on_attach = on_attach,
  capabilities = capabilities,
  on_init = on_init,
})

-- cooklang is not bundled with lspconfig, so register it as a custom server
local configs = require "lspconfig.configs"
if not configs.cooklang then
  configs.cooklang = {
    default_config = {
      cmd = { "cook", "lsp" },
      filetypes = { "cook" },
      root_dir = lspconfig.util.root_pattern(".git"),
      single_file_support = true,
    },
  }
end

-- highlighting comes from treesitter; nvchad's on_init disables the server's semantic tokens so they don't override it
lspconfig["cooklang"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
  on_init = on_init,
})
