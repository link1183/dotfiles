return {
  {
    "chomosuke/typst-preview.nvim",
    lazy = false, -- or ft = 'typst'
    config = function()
      require("lspconfig")["tinymist"].setup({
        settings = {
          formatterMode = "typstyle",
        },
      })

      require("typst-preview").setup({
        invert_colors = "always",
      })
    end,
  },
}
