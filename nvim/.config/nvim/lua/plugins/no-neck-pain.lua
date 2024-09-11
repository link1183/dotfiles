return {
  {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    config = function()
      require("no-neck-pain").setup({
        buffers = {
          right = {
            enabled = true,
          },
          left = {
            enabled = true,
          },
          scratchPad = {
            enabled = false,
            location = "~/vaults/personal/",
            fileName = "notes",
          },
          bo = {
            filetype = "md",
          },
        },
        colors = {
          blend = -0.2,
        },
      })
    end,
  },
}
