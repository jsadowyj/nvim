-- terraform-ls only reads installed modules/providers from <stack>/.terraform, but
-- terragrunt runs `terraform init` inside .terragrunt-cache instead. To get module
-- output completion without a separate init, symlink the newest cached .terraform
-- into the stack directory when a terraform file is opened.

local uv = vim.uv
local M = {}

local checked = {} -- dirs already handled this session

-- Return the newest <cache>/<h1>/<h2>/<suffix>/.terraform matching this stack dir.
-- The suffix is the part of the source path after `//`, which is some tail of `dir`.
local function find_cached_dot_terraform(dir)
  local roots = vim.fn.glob(dir .. "/.terragrunt-cache/*/*", false, true)
  local parts = vim.split(dir, "/", { trimempty = true })
  local best, best_mtime
  for _, root in ipairs(roots) do
    for i = #parts + 1, 1, -1 do
      local suffix = table.concat(parts, "/", i)
      local candidate = suffix == "" and (root .. "/.terraform") or (root .. "/" .. suffix .. "/.terraform")
      local stat = uv.fs_stat(candidate .. "/modules/modules.json") or uv.fs_stat(candidate .. "/providers")
      if stat then
        if not best_mtime or stat.mtime.sec > best_mtime then
          best, best_mtime = candidate, stat.mtime.sec
        end
        break
      end
    end
  end
  return best
end

-- Keep the symlink out of `git status` via the clone-local exclude file
-- (the usual `**/.terraform/*` gitignore pattern doesn't match a symlink).
local function ensure_git_excluded(dir)
  vim.fn.system { "git", "-C", dir, "check-ignore", "-q", ".terraform" }
  if vim.v.shell_error ~= 1 then
    return -- already ignored, or not a git repo
  end
  local exclude = vim.trim(vim.fn.system { "git", "-C", dir, "rev-parse", "--path-format=absolute", "--git-path", "info/exclude" })
  if vim.v.shell_error ~= 0 or exclude == "" then
    return
  end
  vim.fn.mkdir(vim.fs.dirname(exclude), "p")
  local f = io.open(exclude, "a")
  if f then
    f:write "\n# terragrunt cache symlinks created by nvim for terraform-ls\n**/.terraform\n"
    f:close()
  end
end

function M.link(dir)
  if checked[dir] then
    return
  end
  checked[dir] = true

  if not uv.fs_stat(dir .. "/terragrunt.hcl") then
    return
  end
  local link = dir .. "/.terraform"
  local lstat = uv.fs_lstat(link)
  if lstat and lstat.type ~= "link" then
    return -- a real `terraform init` dir; never touch it
  end

  local target = find_cached_dot_terraform(dir)
  if not target then
    return -- terragrunt hasn't initialized this stack yet
  end
  if lstat then
    if uv.fs_readlink(link) == target then
      return
    end
    uv.fs_unlink(link) -- stale link to an old/removed cache dir
  end

  local ok, err = uv.fs_symlink(target, link)
  if not ok then
    vim.notify("terragrunt: could not link .terraform: " .. tostring(err), vim.log.levels.WARN)
    return
  end
  ensure_git_excluded(dir)
end

function M.setup()
  -- BufReadPre runs before the LSP attaches, so terraform-ls sees the link on didOpen
  vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("TerragruntCacheLink", { clear = true }),
    pattern = { "*.tf", "*.tfvars" },
    callback = function(args)
      M.link(vim.fs.dirname(vim.fs.normalize(vim.fn.fnamemodify(args.file, ":p"))))
    end,
  })
end

return M
