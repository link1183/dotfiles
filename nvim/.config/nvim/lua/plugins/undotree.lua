return {
  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("undotree").setup(
        vim.keymap.set(
          "n",
          "<leader>uo",
          require("undotree").toggle,
          { noremap = true, silent = true, desc = "Toggle undotree" }
        )
      )
    end,
  },
}
