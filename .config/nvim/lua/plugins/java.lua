return {
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    config = function()
      local jdtls_path = vim.fn.stdpath("data") .. "/mason/bin/jdtls"
      local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" })

      local config = {
        cmd = { jdtls_path },
        root_dir = root_dir,
      }
      require("jdtls").start_or_attach(config)
    end,
  },
}
