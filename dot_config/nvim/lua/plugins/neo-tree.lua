return {
  "nvim-neo-tree/neo-tree.nvim",
  ---@diagnostic disable-next-line: unused-local
  opts = function(_plugin, opts) opts.filesystem.filtered_items.hide_dotfiles = false end,
}
