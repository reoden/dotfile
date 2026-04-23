-- Todo comments configuration
return {
  {
    src = 'https://github.com/folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'https://github.com/nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
}