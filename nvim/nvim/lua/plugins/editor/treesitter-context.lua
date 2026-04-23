-- Treesitter context plugin
return {
  {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter-context',
    event = 'VeryLazy',
    config = function()
      require('treesitter-context').setup()
    end,
  },
}