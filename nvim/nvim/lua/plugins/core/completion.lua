-- Completion (blink.cmp) configuration
return {
  {
    src = 'https://github.com/saghen/blink.cmp',
    version = vim.version.range('1.*'),
    dependencies = {
      {
        src = 'https://github.com/L3MON4D3/LuaSnip',
        version = vim.version.range('2.*'),
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return nil
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {},
        opts = {},
      },
    },
    opts = {
      keymap = {
        preset = 'enter',
      },

      appearance = {
        nerd_font_variant = 'mono',
      },

      completion = {
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets' },
      },

      snippets = { preset = 'luasnip' },

      fuzzy = { implementation = 'lua' },

      signature = { enabled = true },
    },
  },
}