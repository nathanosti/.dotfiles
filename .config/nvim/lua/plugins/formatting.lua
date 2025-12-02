-- Configuração de formatters usando conform.nvim (usado pelo AstroNvim)
---@type LazySpec
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      -- JavaScript/TypeScript/React/Next.js
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },

      -- Arquivos web
      json = { "prettier" },
      jsonc = { "prettier" },
      yaml = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      html = { "prettier" },
      markdown = { "prettier" },

      -- Python
      python = { "black" },
      -- Alternativa: python = { "ruff_format" }, -- se preferir ruff

      -- Lua (opcional, para configs do Neovim)
      lua = { "stylua" },
    },

    -- Configurações específicas dos formatters
    formatters = {
      prettier = {
        prepend_args = {
          "--single-quote", -- Aspas simples
          "--jsx-single-quote", -- Aspas simples no JSX
          "--trailing-comma",
          "es5", -- Vírgula no final
          "--semi", -- Ponto e vírgula
          "--tab-width",
          "2", -- 2 espaços
          "--print-width",
          "100", -- Largura máxima de linha
        },
      },
      black = {
        prepend_args = {
          "--line-length",
          "88", -- Padrão do Black
          "--fast", -- Modo rápido
        },
      },
    },
  },
}
