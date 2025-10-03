return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {},
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "black", "ruff" },
      },
    },
  },
  -- Depuração Python
  { "mfussenegger/nvim-dap-python" },
}
