-- UI plugins (snacks, themes)
-- Current active theme
local active_theme = 'catppuccin'

-- Build theme list based on active theme
local theme_specs = {}

if active_theme == 'catppuccin' then
  table.insert(theme_specs, {
    src = 'https://github.com/catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    lazy = false,
    config = function()
      require('catppuccin').setup {
        flavour = 'macchiato',
        background = { light = 'latte', dark = 'mocha' },
        transparent_background = true,
        term_colors = true,
        styles = {
          comments = { 'italic' },
        },
        integrations = {
          telescope = true,
          nvimtree = true,
          treesitter = true,
          notify = true,
        },
      }
      vim.cmd 'colorscheme catppuccin'
    end,
  })
elseif active_theme == 'onedark' then
  table.insert(theme_specs, {
    src = 'https://github.com/navarasu/onedark.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      require('onedark').setup {
        style = 'darker',
        transparent = true,
        term_colors = true,
        ending_tildes = false,
        cmp_itemkind_reverse = false,
        code_style = {
          comments = 'italic',
          keywords = 'none',
          functions = 'none',
          strings = 'italic',
          variables = 'none',
        },
        lualine = {
          transparent = false,
        },
      }
      require('onedark').load()
    end,
  })
end

return vim.list_extend({
  -- Snacks plugin
  {
    src = 'https://github.com/folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    keys = {
      {
        '<leader>z',
        function() Snacks.zen() end,
        desc = 'Toggle Zen Mode',
      },
      {
        '<leader>D',
        function()
          if vim.g.snacks_dim_enabled then
            Snacks.dim.disable()
            vim.g.snacks_dim_enabled = false
            print 'Dim disabled'
          else
            Snacks.dim.enable()
            vim.g.snacks_dim_enabled = true
            print 'Dim enabled'
          end
        end,
        desc = 'Toggle Dim',
      },
    },
    opts = {
      indent = {
        enabled = false,
        indent = {
          enabled = false,
          only_current = false,
          only_scope = false,
          char = '┊',
          hl = {
            'SnacksIndentRed',
            'SnacksIndentYellow',
            'SnacksIndentBlue',
            'SnacksIndentOrange',
            'SnacksIndentGreen',
            'SnacksIndentViolet',
            'SnacksIndentCyan',
          },
        },
        scope = {
          enabled = false,
          char = '║',
          underline = true,
          only_current = true,
          hl = {
            'SnacksIndentScopeRed',
            'SnacksIndentScopeYellow',
            'SnacksIndentScopeBlue',
            'SnacksIndentScopeOrange',
            'SnacksIndentScopeGreen',
            'SnacksIndentScopeViolet',
            'SnacksIndentScopeCyan',
          },
        },
        chunk = {
          enabled = false,
          char = {
            corner_top = '╭',
            corner_bottom = '╰',
            horizontal = '─',
            vertical = '│',
            arrow = '>',
          },
          only_current = true,
          hl = {
            'SnacksIndentChunkRed',
            'SnacksIndentChunkOrange',
            'SnacksIndentChunkYellow',
            'SnacksIndentChunkGreen',
            'SnacksIndentChunkBlue',
            'SnacksIndentChunkCyan',
            'SnacksIndentChunkViolet',
          },
        },
      },
    },
  },
}, theme_specs)