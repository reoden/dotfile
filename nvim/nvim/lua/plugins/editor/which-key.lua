-- Which-key plugin
return {
  {
    src = 'https://github.com/folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      icons = { mappings = vim.g.have_nerd_font },
      spec = {
        { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { '<leader>f', group = '[F]ind (fff)' },
        { 'gr', group = 'LSP Actions', mode = { 'n' } },
      },
    },
  },
}