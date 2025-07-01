return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    keys = {
      {
        "<leader>cp",
        ft = "markdown",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
      },
    },
    config = function()
      vim.cmd([[do FileType]])
    end,
  },
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("obsidian").setup({
        workspaces = {
          {
            name = "Personal",
            path = "~/projects/github/vaults/personal",
          },
          {
            name = "Games",
            path = "~/projects/github/games-notes",
          },
          {
            name = "RP",
            path = "~/projects/github/vaults/rp",
          },
        },
        completion = {
          min_chars = 0,
          nvim_cmp = false,
          blink = true,
          match_case = false,
        },
        ui = {
          enable = false,
        },
        new_notes_location = "current_dir",
      })
    end,
  },
}
