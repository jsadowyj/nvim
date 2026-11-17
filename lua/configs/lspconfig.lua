-- EXAMPLE 
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "terraformls", "gopls", "jsonnet_ls", "jinja_lsp", "pylsp"}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- Root on Gemfile.lock so nested engines (e.g. defend/) with a bare Gemfile
-- resolve to the parent app instead of crashing ruby-lsp (exit code 78).
lspconfig["ruby_lsp"].setup({
  root_dir = lspconfig.util.root_pattern("Gemfile.lock", ".git"),
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
})

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

-- terragrunt-ls is not bundled with lspconfig v1 nor in mason; install the binary from
-- https://github.com/gruntwork-io/terragrunt-ls/releases onto $PATH
if not configs.terragrunt_ls then
  configs.terragrunt_ls = {
    default_config = {
      cmd = { "terragrunt-ls" },
      filetypes = { "hcl" },
      -- only attach inside terragrunt projects, not to other HCL (packer, nomad, ...)
      root_dir = lspconfig.util.root_pattern("root.hcl", "terragrunt.hcl"),
      single_file_support = false,
    },
  }
end

lspconfig["terragrunt_ls"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
  on_init = on_init,
})

-- highlighting comes from treesitter; nvchad's on_init disables the server's semantic tokens so they don't override it
lspconfig["cooklang"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
  on_init = on_init,
})
