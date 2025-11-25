return {
  -- VimTeX for LaTeX support
  {
    "lervag/vimtex",
    lazy = false, -- lazy-loading will disable inverse search
    config = function()
      vim.g.vimtex_view_general_viewer = "okular"
      vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = {
        continuous = 1,
      }
      -- Enhanced LaTeX settings
      vim.g.vimtex_quickfix_mode = 0 -- Don't auto-open quickfix
      vim.g.vimtex_syntax_enabled = 1
      vim.g.vimtex_syntax_conceal_disable = 0
      vim.g.vimtex_fold_enabled = 1
      vim.g.vimtex_indent_enabled = 1
      vim.g.vimtex_format_enabled = 1
    end,
    keys = {
      { "<localleader>lc", "<cmd>VimtexCompile<cr>", desc = "Compile LaTeX", ft = "tex" },
      { "<localleader>lv", "<cmd>VimtexView<cr>", desc = "View PDF", ft = "tex" },
      { "<localleader>lk", "<cmd>VimtexClean<cr>", desc = "Clean aux files", ft = "tex" },
      { "<localleader>lt", "<cmd>VimtexTocToggle<cr>", desc = "Toggle TOC", ft = "tex" },
      { "<localleader>le", "<cmd>VimtexErrors<cr>", desc = "Show errors", ft = "tex" },
      { "<localleader>ls", "<cmd>VimtexStop<cr>", desc = "Stop compilation", ft = "tex" },
    },
  },

  -- Configure conform.nvim to add LaTeX formatters
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        tex = { "latexindent" },
        latex = { "latexindent" },
        bib = { "bibtex-tidy" },
      },
    },
  },

  -- Configure nvim-lspconfig for LaTeX
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        texlab = {
          settings = {
            texlab = {
              auxDirectory = ".",
              bibtexFormatter = "texlab",
              build = {
                args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
                executable = "latexmk",
                forwardSearchAfter = false,
                onSave = false,
              },
              chktex = {
                onEdit = false,
                onOpenAndSave = true,
              },
              diagnosticsDelay = 300,
              formatterLineLength = 80,
              forwardSearch = {
                args = {},
              },
              latexFormatter = "latexindent",
              latexindent = {
                modifyLineBreaks = true,
              },
            },
          },
        },
      },
    },
  },

  -- Configure Mason to ensure LaTeX tools are installed
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "texlab",
        "latexindent",
      },
    },
  },
}
