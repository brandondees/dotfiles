---@type LazySpec
return {
  "Aaronik/GPTModels.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim",
  },

  ---@param _plugin LazyPlugin
  ---@param _opts table
  config = function(_plugin, _opts)
    -- Both visual and normal mode for each, so you can open with a visual selection or without.
    vim.api.nvim_set_keymap("v", "<Leader>rC", ":GPTModelsCode<CR>", { noremap = true, desc = "GPT Models Code" })
    vim.api.nvim_set_keymap("n", "<Leader>rC", ":GPTModelsCode<CR>", { noremap = true, desc = "GPT Models Code" })
    vim.api.nvim_set_keymap("v", "<Leader>rc", ":GPTModelsChat<CR>", { noremap = true, desc = "GPT Models Chat" })
    vim.api.nvim_set_keymap("n", "<Leader>rc", ":GPTModelsChat<CR>", { noremap = true, desc = "GPT Models Chat" })
  end,
}
