local anthropic_key = vim.env.MINUET_ANTHROPIC_API_KEY
local anthropic_model = vim.env.MINUET_ANTHROPIC_MODEL or "claude-haiku-4-5"

local openai_compatible_endpoint = vim.env.MINUET_OPENAI_COMPATIBLE_ENDPOINT
local openai_compatible_model = vim.env.MINUET_OPENAI_COMPATIBLE_MODEL

local max_tokens = tonumber(vim.env.MINUET_MAX_TOKENS) or 512
local context_window = tonumber(vim.env.MINUET_CONTEXT_WINDOW) or 8000

-- Don't setup minuet if no provider is available
if not anthropic_key and not openai_compatible_endpoint and not openai_compatible_model then
  return
end

local provider = anthropic_key and "claude" or "openai_fim_compatible"

require("minuet").setup({
  provider = provider,
  n_completions = 3,
  debounce = 200,
  throttle = 0,
  context_window = context_window,

  provider_options = {
    claude = {
      max_tokens = max_tokens,
      model = anthropic_model,
      api_key = "MINUET_ANTHROPIC_API_KEY",
      stream = true,
    },
    openai_fim_compatible = {
      end_point = openai_compatible_endpoint,
      api_key = "TERM",
      model = openai_compatible_model,
      name = openai_compatible_model,
      stream = true,
      optional = {
        max_tokens = max_tokens,
      },
    },
  },

  virtualtext = {
    auto_trigger_ft = {},
    keymap = {
      accept = nil,
      accept_line = nil,
      accept_n_lines = nil,
      next = "<A-]>",
      prev = "<A-[>",
      dismiss = "<A-e>",
    },
  },
})
