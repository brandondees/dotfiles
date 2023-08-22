-- https://neovim.io/doc/user/nvim.html#nvim-from-vim

vim.cmd([[
set encoding=utf-8
source ~/.vimrc
]])

vim.cmd("language en_US.UTF-8")

-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua

-- Packer auto bootstrapping
-- https://github.com/wbthomason/packer.nvim#bootstrapping
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local Packer_bootstrap = ensure_packer()

-- load plugins
vim.cmd([[
augroup config#update
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup END
]])

require("packer").startup(function(use)
  use("wbthomason/packer.nvim") -- Package manager
  -- use 'ludovicchabant/vim-gutentags' -- Automatic tags management
  -- UI to select things (files, grep results, open buffers...)
  use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use({ "nvim-telescope/telescope-symbols.nvim" })

  use('gpanders/editorconfig.nvim')

  use { 'mfussenegger/nvim-dap' }
  use { 'nvim-telescope/telescope-dap.nvim' }

  use {'dgagn/diagflow.nvim'} -- floating diagnostic text

  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    requires = {
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/nvim-treesitter-refactor',
        'nvim-treesitter/nvim-treesitter-context',
      },
    },
  }

  use {
    'p00f/nvim-ts-rainbow',
    'windwp/nvim-ts-autotag',
    'JoosepAlviste/nvim-ts-context-commentstring'
  }
  use {
    'windwp/nvim-autopairs',
  }

  use {
    'RRethy/nvim-treesitter-endwise',
    config = function()
      require('nvim-treesitter.configs').setup {
        endwise = {
          enable = true,
        },
      }
    end
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  use("Olical/conjure") -- repl workflow in editor

  use({
    "ThePrimeagen/refactoring.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  })


  use({
    "nvim-orgmode/orgmode",
    config = function()
      require("orgmode").setup_ts_grammar()
    end,
  })

  use({
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    -- 'lukas-reineke/lsp-format.nvim',

    "neovim/nvim-lspconfig", -- Configurations for Nvim LSP
    'folke/lsp-colors.nvim',

    -- 'williamboman/nvim-lsp-installer',
    'folke/trouble.nvim',
    -- 'ray-x/lsp_signature.nvim',
    -- 'jose-elias-alvarez/null-ls.nvim',

  })

  use("hrsh7th/cmp-nvim-lsp") -- LSP source for nvim-cmp
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("hrsh7th/nvim-cmp") -- Autocompletion plugin
  use("saadparwaiz1/cmp_luasnip")
  use("L3MON4D3/LuaSnip") -- Snippets plugin

  use({ "fatih/vim-go", run = ":GoUpdateBinaries" })

  use("jose-elias-alvarez/typescript.nvim")

  -- use("dhruvasagar/vim-table-mode")
  -- use("tpope/vim-dadbod")
  -- use("kristijanhusak/vim-dadbod-completion")

  -- use("github/copilot.vim")
  -- use { "zbirenbaum/copilot.lua" }
  use {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  }
  use {
  "zbirenbaum/copilot-cmp",
  after = { "copilot.lua" },
  config = function ()
    require("copilot_cmp").setup()
  end
  }

  use({
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({})
    end,
  })

  -- Colorscheme / Themes
  -- use('fenetikm/falcon')
  use("rktjmp/lush.nvim")
  use {
    "mcchrish/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    requires = "rktjmp/lush.nvim"
  }
  -- use("sainnhe/everforest")
  -- use { 'embark-theme/vim',
  --   as = 'embark',
  --   config = function()
  --     vim.cmd('colorscheme embark')
  --     vim.cmd('let g:embark_terminal_italics = 1')
  --   end
  -- }



  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if Packer_bootstrap then
    require("packer").sync()
  end
end)
require("packer").install()


--Make line numbers default
vim.wo.number = true
-- vim.wo.relativenumber = true

--Enable mouse mode
vim.o.mouse = "a"

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 150
vim.wo.signcolumn = "yes"

-- Set completeopt to have a better completion experience
-- vim.o.completeopt = 'menuone,noselect'

--Set colorscheme
vim.o.termguicolors = true
-- vim.cmd("colorscheme everforest")
-- vim.cmd("colorscheme falcon")
vim.cmd("colorscheme duckbones")



-- Telescope
require("telescope").setup({})

-- Enable telescope fzf native
require("telescope").load_extension("fzf")

-- Default diagflow config for floating diagnostic output
require('diagflow').setup()

--Add leader shortcuts
local wk = require("which-key")
wk.register({
  ["<leader>v"] = { name = "+vim config" },
  -- ["<leader>f"] = { name = "+files" },
  ["<leader>s"] = { name = "+search" },
  ["<leader>r"] = { name = "+refactor" },
  ["<leader>d"] = { name = "+debugging" },
  ["g"] = { name = "+goto" },
})

vim.keymap.set("n", "<leader>fn", function()
  vim.cmd(":tabnew")
end, { desc = "New File (tab)" })

vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "find buffer" })
vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "find file" })
vim.keymap.set(
  "n",
  "<leader>sb",
  require("telescope.builtin").current_buffer_fuzzy_find,
  { desc = "current buffer fuzzy find" }
)
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "help tags" })
vim.keymap.set("n", "<leader>st", require("telescope.builtin").tags, { desc = "tags" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").grep_string, { desc = "grep string" })
vim.keymap.set("n", "<leader>sp", require("telescope.builtin").live_grep, { desc = "live grep" })
vim.keymap.set("n", "<leader>so", function()
  require("telescope.builtin").tags({ only_current_buffer = true })
end, { desc = "tags in current buffer" })
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "oldfiles" })

vim.keymap.set("i", "<C-e>", require("telescope.builtin").symbols, { desc = '"symbols" / emoji' })
vim.keymap.set("n", "<C-e>", require("telescope.builtin").symbols, { desc = '"symbols" / emoji' })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>di", vim.diagnostic.open_float, { desc = "diagnostic open float" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "diagnostic goto prev" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "diagnostic goto next" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "show diagnostic list" })


-- Debugger / Debugging / DAP
-- https://alpha2phi.medium.com/neovim-dap-enhanced-ebc730ff498b
require('./dbg')

-- OrgMode https://github.com/nvim-orgmode/orgmode
require("orgmode").setup_ts_grammar()
-- OrgMode Tree-sitter configuration
require("nvim-treesitter.configs").setup({
  auto_install = true,
  indent = { enable = true },
  ensure_installed = { "org", "lua", "html", "markdown", "css", "typescript", "bash", "dockerfile", "gitignore", "json",
    "regex", "ruby", "sql", "vim", "yaml" }, -- Or run :TSUpdate org

  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { "org" }, -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },

  refactor = { -- https://github.com/nvim-treesitter/nvim-treesitter-refactor
    highlight_definitions = { enable = true },
    -- highlight_current_scope = { enable = true },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "grr",
      },
    },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = "gnd",
        list_definitions = "gnD",
        list_definitions_toc = "gO",
        goto_next_usage = "<a-*>",
        goto_previous_usage = "<a-#>",
      },
    },
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false -- Whether the query persists across vim sessions
  },

  autotag = { enable = true, },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },


  -- https://github.com/p00f/nvim-ts-rainbow
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
  },
})

require("orgmode").setup({
  org_agenda_files = { "~/Dropbox/org/*", "~/my-orgs/**/*", "~/second-brain/dees/*" },
  -- org_default_notes_file = '~/Dropbox/org/refile.org',
  org_default_notes_file = "~/second-brain/dees/org/refile.org",
})

-- LSP settings
require("mason").setup()
require("mason-lspconfig").setup({ automatic_installation = true })

-- local lsp_format = require("lsp-format")
-- lsp_format.setup()

local lspconfig = require("lspconfig")
local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr }

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")


  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "goto declaration", buffer = opts.buffer })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "goto definition", buffer = opts.buffer })
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "hover", buffer = opts.buffer })
  vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "goto implementation", buffer = opts.buffer })
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "signature help", buffer = opts.buffer })
  -- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
  -- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
  -- vim.keymap.set('n', '<leader>wl', function()
  --   vim.inspect(vim.lsp.buf.list_workspace_folders())
  -- end, opts)
  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "rename file", buffer = opts.buffer })
  vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "goto references", buffer = opts.buffer })
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "code action", buffer = opts.buffer })
  vim.keymap.set("v", "<leader>ca", vim.lsp.buf.range_code_action, { desc = "range code action", buffer = opts.buffer })
  -- 	                    (nvim.buf_set_keymap bufnr :v :<leader>la "<cmd>lua vim.lsp.buf.range_code_action()<CR> " {:noremap true})

  vim.keymap.set("n", "<leader>so", require("telescope.builtin").lsp_document_symbols,
    { desc = "document symbols", buffer = opts.buffer })
  -- vim.api.nvim_buf_create_user_command(bufnr, "Format", vim.lsp.buf.format, {})

  -- lsp_format.on_attach(client)

  -- Autoformat when applicable
  -- https://github.com/VapourNvim/VapourNvim/blob/main/lua/null-ls-config/init.lua
  -- if client.server_capabilities.document_formatting then
  --   vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()")
  --   if client.server_capabilities.document_highlight then
  --     vim.api.nvim_exec([[
  --     augroup document_highlight
  --       autocmd! * <buffer>
  --       autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
  --       autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
  --     augroup END
  --   ]] , false)
  --   end
  -- end
end


-- wk.register({
--   ['='] = { vim.lsp.buf.formatting_sync, 'Format' },
-- }, { prefix = '<leader>l' })
-- vim.cmd("nnoremap <silent> <leader>f :Format<CR>")
-- vim.cmd("nnoremap <silent> <leader>F :FormatWrite<CR>")

-- Add additional capabilities supported by nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Enable the following language servers
local servers = {
  -- "asm_lsp",
  "bashls",
  "clangd",
  "cmake",
  "cssls",
  "cssmodules_ls",
  "clojure_lsp",
  -- "crystalline",
  -- "diagnosticls",
  "dockerls",
  "eslint",
  -- "gopls",
  "graphql",
  "html",
  -- "hls",
  "jedi_language_server",
  -- "jsonls",
  "kotlin_language_server",
  "marksman",
  "prosemd_lsp",
  "pylsp",
  "pyright",
  -- "solargraph",
  "sqlls",
  "svelte",
  "taplo",
  "tailwindcss",
  "terraformls",
  "tflint",
  -- "tsserver",
  "vimls",
  "lemminx",
  "yamlls",
}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

-- Configure lua language server
-- require("lspconfig").sumneko_lua.setup({
--   settings = {
--     Lua = {
--       runtime = {
--         -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
--         version = "LuaJIT",
--       },
--       diagnostics = {
--         -- Get the language server to recognize the `vim` global
--         globals = { "vim" },
--       },
--       workspace = {
--         -- Make the server aware of Neovim runtime files
--         library = vim.api.nvim_get_runtime_file("", true),
--       },
--       -- Do not send telemetry data containing a randomized but unique identifier
--       telemetry = { enable = false },
--     },
--   },
-- })

-- https://github.com/jose-elias-alvarez/typescript.nvim
require("typescript").setup {}

-- require 'lspconfig'.stylelint_lsp.setup {
--   settings = {
--     autoFixOnFormat = true,
--     autoFixOnSave = true,
--     validateOnType = true,
--   }
-- }

-- https://github.com/windwp/nvim-autopairs
-- based on https://github.com/luan/nvim/blob/main/lua/plugins/autopairs.lua
require('nvim-autopairs').setup {}

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))

-- luasnip setup
-- local luasnip = require("luasnip")

-- nvim-cmp setup
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = {
    { name = "copilot" },
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "orgmode" },
  },
})

local has_words_before = function() 
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end
cmp.setup({
  mapping = {
    ["<Tab>"] = vim.schedule_wrap(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end),
  },
})

vim.api.nvim_exec([[
  autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_seq_sync(nil, 500)
  autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform
  autocmd BufWritePre *.tfvars lua vim.lsp.buf.format { async = true }
  autocmd BufWritePre *.tf lua vim.lsp.buf.format { async = true }
]], false)


-- Folding
vim.opt.foldlevel  = 20
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr   = 'nvim_treesitter#foldexpr()'

-- Table mode
-- https://github.com/dhruvasagar/vim-table-mode
-- vim.keymap.set('n', '<leader>tm', )
