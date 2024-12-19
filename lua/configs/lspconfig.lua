-- EXAMPLE 
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "terraformls", "gopls", "jsonnet_ls"}

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
