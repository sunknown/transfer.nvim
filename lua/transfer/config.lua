local M = {}

M.defaults = {
  -- deployment config template: can be a string, a function or a table of lines
  config_template = [[
return {
  ["server1"] = {
    host = "server1",
    mappings = {
      {
        ["local"] = "domains/example.com",
        ["remote"] = "/var/www/example.com",
      },
    },
    filePermissions = "664", -- optional: set file permissions for uploaded files
    dirPermissions = "775", -- optional: set directory permissions for uploaded directories
    -- excludedPaths = {
    --   "src", -- local path relative to project root
    -- },
  },
}
]],
  close_diffview_mapping = "<leader>b", -- buffer related mapping to close diffview, set to nil to disable mapping
  upload_rsync_params = { -- a table of strings or functions
    "-rlzi",
    "--delete",
    "--checksum",
    "--exclude",
    ".git",
    "--exclude",
    ".idea",
    "--exclude",
    ".DS_Store",
    "--exclude",
    ".nvim",
    "--exclude",
    "*.pyc",
  },
  download_rsync_params = { -- a table of strings or functions
    "-rlzi",
    "--delete",
    "--checksum",
    "--exclude",
    ".git",
  },
  use_rsync_for_files = true, -- whether to use rsync instead of scp for file transfers
}

M.options = {}

M.setup = function(opts)
  opts = opts or {}
  M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})
end

return M
