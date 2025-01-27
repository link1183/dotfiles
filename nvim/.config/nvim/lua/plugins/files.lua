return {
  {
    "echasnovski/mini.files",
    version = "*",
    config = function()
      require("mini.files").setup({
        windows = {
          preview = true,
        },
      })
      vim.keymap.set("n", "-", "<cmd>lua MiniFiles.open()<CR>")
    end,
  },
}
