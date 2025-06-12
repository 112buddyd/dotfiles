return {
  {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
      require("mini.animate").setup()
      require("mini.comment").setup()
      require("mini.surround").setup()
      require("mini.statusline").setup()
      require("mini.tabline").setup()
    end,
  },
}
