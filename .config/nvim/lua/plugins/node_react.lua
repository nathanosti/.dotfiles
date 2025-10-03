return {
  -- Language Server
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tsserver = {},
        eslint = {},
      },
    },
  },
  -- Formatter
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
      },
    },
  },
}
