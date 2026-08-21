return {
  { import = "lazyvim.plugins.extras.lang.clangd" },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- ensures parsers update automatically
    opts = {
      ensure_installed = {
        "c",
        "cpp",
        "lua", -- optional, good to have
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false, -- safer for Neovim
      },
      indent = {
        enable = true,
      },
    },
  },
}
