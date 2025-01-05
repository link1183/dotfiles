return {
  {
    "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato",
        background = {
          light = "latte",
          dark = "macchiato",
        },
        transparent_background = true,
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
