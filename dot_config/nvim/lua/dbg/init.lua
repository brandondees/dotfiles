require('telescope').load_extension('dap')
-- require('dbg.python')




vim.api.nvim_set_keymap('n', '<leader>dct', '<cmd>lua require"dap".continue()<CR>', { desc = 'continue' })
vim.api.nvim_set_keymap('n', '<leader>dsv', '<cmd>lua require"dap".step_over()<CR>', { desc = 'step over' })
vim.api.nvim_set_keymap('n', '<leader>dsi', '<cmd>lua require"dap".step_into()<CR>', { desc = 'step into' })
vim.api.nvim_set_keymap('n', '<leader>dso', '<cmd>lua require"dap".step_out()<CR>', { desc = 'step out' })
vim.api.nvim_set_keymap('n', '<leader>dtb', '<cmd>lua require"dap".toggle_breakpoint()<CR>', { desc = 'toggle breakpoint' })

vim.api.nvim_set_keymap('n', '<leader>dsc', '<cmd>lua require"dap.ui.variables".scopes()<CR>', { desc = 'ui variables scopes' })
vim.api.nvim_set_keymap('n', '<leader>dhh', '<cmd>lua require"dap.ui.variables".hover()<CR>', { desc = 'ui variables hover' })
vim.api.nvim_set_keymap('v', '<leader>dhv',
  '<cmd>lua require"dap.ui.variables".visual_hover()<CR>', { desc = 'ui variables visual hover' })

vim.api.nvim_set_keymap('n', '<leader>duh', '<cmd>lua require"dap.ui.widgets".hover()<CR>', { desc = 'ui widgets hover' })
vim.api.nvim_set_keymap('n', '<leader>duf',
  "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>",
  { desc = 'ui widgets scopes' })

vim.api.nvim_set_keymap('n', '<leader>dsbr',
  '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
  { desc = 'set breakpoint <condition>' })
vim.api.nvim_set_keymap('n', '<leader>dsbm',
  '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
  { desc = 'set breakpoint <message>' })
vim.api.nvim_set_keymap('n', '<leader>dro', '<cmd>lua require"dap".repl.open()<CR>', { desc = 'repl open' })
vim.api.nvim_set_keymap('n', '<leader>drl', '<cmd>lua require"dap".repl.run_last()<CR>', { desc = 'repl run last' })


-- telescope-dap
vim.api.nvim_set_keymap('n', '<leader>dcc',
  '<cmd>lua require"telescope".extensions.dap.commands{}<CR>', { desc = 'list commands' })
vim.api.nvim_set_keymap('n', '<leader>dco',
  '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>', { desc = 'list configurations' })
vim.api.nvim_set_keymap('n', '<leader>dlb',
  '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>', { desc = 'list breakpoints' })
vim.api.nvim_set_keymap('n', '<leader>dv',
  '<cmd>lua require"telescope".extensions.dap.variables{}<CR>', { desc = 'list variables' })
vim.api.nvim_set_keymap('n', '<leader>df',
  '<cmd>lua require"telescope".extensions.dap.frames{}<CR>', { desc = 'list frames' })
