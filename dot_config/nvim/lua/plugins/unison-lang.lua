---@type LazySpec
return {
  {
    "unisonweb/unison",
    branch = "trunk",
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/editor-support/vim")
      require("lazy.core.loader").packadd(plugin.dir .. "/editor-support/vim")
    end,
    init = function(plugin)
      require("lazy.core.loader").ftdetect(plugin.dir .. "/editor-support/vim")

      local on_attach = function(client, bufnr)
        -- Always show the signcolumn, otherwise it would shift the text each time
        -- diagnostics appear/become resolved
        vim.o.signcolumn = "yes"

        -- Update the cursor hover location every 1/4 of a second
        vim.o.updatetime = 250

        -- Disable appending of the error text at the offending line
        vim.diagnostic.config { virtual_text = false }

        -- Enable a floating window containing the error text when hovering over an error
        vim.api.nvim_create_autocmd("CursorHold", {
          buffer = bufnr,
          callback = function()
            local opts = {
              focusable = false,
              close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
              border = "rounded",
              source = "always",
              prefix = " ",
              scope = "cursor",
            }
            vim.diagnostic.open_float(nil, opts)
          end,
        })

        -- This setting is to display hover information about the symbol under the cursor
        vim.keymap.set("n", "K", vim.lsp.buf.hover)
      end

      -- Setup the Unison LSP
      require("lspconfig")["unison"].setup {
        on_attach = on_attach,
      }
    end,
  },
} -- This function is for configuring a buffer when an LSP is attached
