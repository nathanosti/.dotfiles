return {
  -- Tokyo Night colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night", -- night, storm, moon, day
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = { bold = true },
        variables = {},
        sidebars = "transparent",
        floats = "transparent",
      },
      sidebars = { "qf", "help", "terminal", "packer", "NvimTree" },
      day_brightness = 0.3,
      hide_inactive_statusline = false,
      dim_inactive = false,
      lualine_bold = false,

      on_colors = function(colors)
        colors.bg = "NONE" -- Forçar transparência total
        colors.bg_sidebar = "NONE"
        colors.bg_float = "NONE"
      end,

      on_highlights = function(hl, c)
        hl.Normal = { bg = "NONE" }
        hl.NormalFloat = { bg = "NONE" }
        hl.NormalNC = { bg = "NONE" }
        hl.SignColumn = { bg = "NONE" }
        hl.NvimTreeNormal = { bg = "NONE" }
      end,
    },
  },

  -- Configure LazyVim to use tokyonight
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },
}
