return {
  {
    "mfussenegger/nvim-jdtls",
    config = function()
      require("jdtls").start_or_attach({ -- config padrão
        cmd = { "java-lsp.sh", "jdtls" },
        root_dir = vim.fn.getcwd(),
      })
    end,
  },
}
