-- Diagnostic plugins (trouble, tiny-inline-diagnostic)
return {
  {
    src = 'https://github.com/folke/trouble.nvim',
    opts = {},
    cmd = 'Trouble',
    keys = {
      {
        '<leader>qD',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>qd',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>qs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Document Symbols',
      },
      {
        '<leader>ql',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>qL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>qQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  },

  {
    src = 'https://github.com/rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy',
    priority = 1000,
    config = function()
      require('tiny-inline-diagnostic').setup {
        preset = 'modern',
        transparent_bg = false,
        transparent_cursorline = true,
        signs = {
          vertical = ' │',
          vertical_end = ' └',
        },
        blend = {
          factor = 0.1,
        },
        options = {
          show_source = {
            enabled = true,
            if_many = true,
          },
          add_messages = {
            display_count = true,
          },
          set_arrow_to_diag_color = true,
          multilines = {
            enabled = true,
            always_show = true,
          },
          show_all_diags_on_cursorline = true,
          enable_on_insert = false,
          enable_on_select = true,
        },
      }
    end,
  },
}