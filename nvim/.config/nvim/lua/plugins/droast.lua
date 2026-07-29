return {
  {
    "immanuwell/droast.nvim",
    config = function()
      require("droast").setup({
        on_save = true,
        args = {
          "--skip",
          "DF007,DF012",
        },
      })
    end,
  },
}
