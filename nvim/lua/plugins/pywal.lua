return {
  {
    "AlphaTechnolog/pywal.nvim",
    lazy = false, -- load on startup
    priority = 1000, -- make sure it loads before other colorschemes
    config = function()
      -- Apply pywal theme
      -- vim.cmd("colorscheme pywal")

      -- Optional: make sure true colors are enabled
      vim.opt.termguicolors = true
      vim.opt.background = "dark"
    end,
  },
}
