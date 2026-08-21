return {
  {
    "lervag/vimtex",
    lazy = false, -- load immediately
    init = function()
      vim.g.vimtex_view_method = "zathura" -- or "sioyek", "okular", etc.
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_quickfix_mode = 0
    end,
  },
  {
    "frabjous/knap",
    config = function()
      vim.g.knap_settings = {
        texoutputext = "pdf",
        textopdf = "latexmk -pdf %docroot%",
        textopdfviewerlaunch = "zathura %outputfile%",
        textopdfviewerrefresh = "pkill -HUP -x zathura",
      }
    end,
  },
}
