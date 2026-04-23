---@module 'lazy'
---@type LazySpec
return {
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    keys = {
      { '<leader>vs', '<cmd>VenvSelect<cr>' },
    },
    opts = {
      options = {},
      search = {},
    },
  },
}
