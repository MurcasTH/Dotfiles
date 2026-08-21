local quickshell_root = vim.fn.expand("~/.config/quickshell")

local function get_quickshell_build_dir()
  local path = quickshell_root .. "/.qmlls.ini"
  local file = io.open(path, "r")

  if not file then
    return nil
  end

  for line in file:lines() do
    local build_dir = line:match('^buildDir%s*=%s*"(.-)"%s*$') or line:match("^buildDir%s*=%s*(.-)%s*$")

    if build_dir and build_dir ~= "" then
      file:close()
      return build_dir
    end
  end

  file:close()
  return nil
end

local qmlls_cmd = {
  "qmlls6",
  "--no-cmake-calls",
}

local quickshell_build_dir = get_quickshell_build_dir()

if quickshell_build_dir then
  vim.list_extend(qmlls_cmd, {
    "--build-dir",
    quickshell_build_dir,
    "-I",
    quickshell_build_dir,
  })
end

return {
  {
    "neovim/nvim-lspconfig",

    -- Make sure Mason installs clangd automatically
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "p00f/clangd_extensions.nvim",
    },

    opts = {
      servers = {
        qmlls = {
          cmd = qmlls_cmd,
          filetypes = { "qml", "qmljs" },
          root_dir = quickshell_root,
        },

        clangd = {
          keys = {
            { "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
          },
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=never",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
            -- "--compile-commands-dir=/home/murcas/.config/quickshell/lib/plugins/applauncher/build",
          },
          -- filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
          -- root_dir = function(fname)
          --   local util = require("lspconfig.util")
          --   return util.root_pattern("compile_commands.json", "compile_flags.txt", "Makefile", "CMakeLists.txt", ".git")(
          --     fname
          --   )
          -- end,
          capabilities = { offsetEncoding = { "utf-16" } },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },

        omnisharp = {
          enabled = false,
          handlers = {
            ["textDocument/definition"] = function(...)
              return require("omnisharp_extended").handler(...)
            end,
          },
          keys = {
            {
              "gd",
              LazyVim.has("telescope.nvim") and function()
                require("omnisharp_extended").telescope_lsp_definitions()
              end or function()
                require("omnisharp_extended").lsp_definitions()
              end,
              desc = "Goto Definition",
            },
          },
          enable_roslyn_analyzers = true,
          organize_imports_on_format = true,
          enable_import_completion = true,
        },
      },

      setup = {
        clangd = function(_, opts)
          local clangd_ext_opts = require("lazyvim.util").opts("clangd_extensions.nvim")
          require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts }))
          return false
        end,
      },
    },
  },
}
