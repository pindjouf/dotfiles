return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    -- Reapply your colorscheme if needed
    vim.cmd('colorscheme gruvbox') -- Replace 'your_colorscheme' with your actual colorscheme
  end
}
