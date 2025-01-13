return {
  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("flutter-tools").setup({})
    end,
  },
  {
    "nvim-flutter/pubspec-assist.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("pubspec-assist").setup({})
    end,
  },
}
