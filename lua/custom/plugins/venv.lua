---@module 'lazy'
---@type LazySpec
return {
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    ft = 'python',
    keys = {
      { '<leader>vs', '<cmd>VenvSelect<cr>' },
    },
    opts = {
      options = {},
      search = {},
    },
    config = function(_, opts)
      require('venv-selector').setup(opts)

      -- Auto-activate the first discovered venv when opening a python file,
      -- unless one is already active (e.g. restored from cache by the plugin).
      local attempted = {}
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('VenvAutoSelect', { clear = true }),
        pattern = 'python',
        callback = function()
          local vs = require 'venv-selector'
          local key = vim.fn.getcwd()
          if attempted[key] then
            return
          end
          -- Defer so the plugin's own cache/uv restore autocmds run first.
          vim.defer_fn(function()
            if attempted[key] or vs.python() then
              return
            end
            attempted[key] = true
            local first
            require('venv-selector.search').run_search {
              on_result = function(result)
                first = first or result
              end,
              on_complete = function()
                if first and not vs.python() then
                  vs.activate_from_path(first.path, first.type)
                end
              end,
            }
          end, 200)
        end,
      })
    end,
  },
}
