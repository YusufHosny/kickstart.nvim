return {
  'lambdalisue/vim-suda',
  event = 'BufRead',
  config = function()
    vim.g.suda_smart_edit = 1

    vim.api.nvim_create_user_command('W', 'SudaWrite', {})

    vim.keymap.set('n', '<leader>w', ':SudaWrite<CR>', { 
      silent = true, 
      desc = 'suda [W]rite (Save with sudo)' 
    })
  end,
}
