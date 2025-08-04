Original plugin:

- [coffebar/transfer](https://github.com/coffebar/transfer.nvim)

# Changes from original

## Install

### Lazy.nvim

Added "TransferDiff" option:

```lua
{
  "coffebar/transfer.nvim",
  lazy = true,
  cmd = { "TransferInit", "TransferDiff", "TransferUpload", "TransferDownload", "TransferDirDiff", "TransferRepeat" },
  opts = {},
},
```

## Commands

- `TransferInit` - create a config file and open it. Just edit if it already exists.
- `DiffRemote` - open a diff view with the remote file (scp).
- `TransferDiff` - open a diff view with the remote file (rsync).
- `TransferRepeat` - repeat the last transfer command (except TransferInit, DiffRemote).
- `TransferUpload [path]` - upload the given file or directory.
- `TransferDownload [path]` - download the given file or directory.
- `TransferDirDiff [path]` - diff the directory with the remote one and display the changed files in the quickfix.

## Deployment config example

Added "filePermissions", "dirPersmissions" for updating permissions after file\folder upload with rsync

```lua
-- .nvim/deployment.lua
return {
  ["example_name"] = {
    host = "myhost",
    username = "web", -- optional
    mappings = {
      {
        ["local"] = "live", -- path relative to project root
        ["remote"] = "/var/www/example.com", -- absolute path or relative to user home
      },
      {
        ["local"] = "test",
        ["remote"] = "/var/www/test.example.com",
      },
    },
    excludedPaths = { -- optional
      "live/src/", -- local path relative to project root
      "test/src/",
    },
    filePermissions = "664",
    dirPersmissions = "775",
  },
}
```

### Which-key

Example with "TransferDiff" option

```lua
require("which-key").add({
  { "<leader>u", group = "Upload / Download", icon = "" },
  {
    "<leader>ud",
    "<cmd>TransferDownload<cr>",
    desc = "Download from remote server (scp)",
    icon = { color = "green", icon = "󰇚" },
  },
  {
    "<leader>uf",
    "<cmd>DiffRemote<cr>",
    desc = "Diff file with remote server (scp)",
    icon = { color = "green", icon = "" },
  },
  {
    "<leader>uu",
    "<cmd>TransferDiff<cr>",
    desc = "Diff file with remote server (rsync)",
    icon = { color = "green", icon = "" },
  },
  {
    "<leader>ui",
    "<cmd>TransferInit<cr>",
    desc = "Init/Edit Deployment config",
    icon = { color = "green", icon = "" },
  },
  {
    "<leader>ur",
    "<cmd>TransferRepeat<cr>",
    desc = "Repeat transfer command",
    icon = { color = "green", icon = "󰑖" },
  },
  {
    "<leader>uu",
    "<cmd>TransferUpload<cr>",
    desc = "Upload to remote server (scp)",
    icon = { color = "green", icon = "󰕒" },
  },
})
```

## Config

[Look at defaults](https://github.com/coffebar/transfer.nvim/blob/main/lua/transfer/config.lua) and overwrite anything in your opts.

You can use rsync instead of scp for file transfers by setting `use_rsync_for_files = true` in your config (set by default). When using rsync, you can specify file permissions in your deployment configuration:

```lua
-- .nvim/deployment.lua
return {
  ["example_name"] = {
    host = "myhost",
    username = "web", -- optional
    mappings = {
      {
        ["local"] = "live", -- path relative to project root
        ["remote"] = "/var/www/example.com", -- absolute path or relative to user home
      },
    },
    filePermissions = "664", -- set file permissions for uploaded files
    dirPersmissions = "775", -- set directory permissions for uploaded directories
  },
}
```
