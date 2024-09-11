return {
  {
    "dhruvmanila/browser-bookmarks.nvim",
    version = "*",
    -- Only required to override the default options
    opts = {
      selected_browser = "firefox",
      url_open_command = "xdg-open",
    },
    dependencies = {
      --   -- Only if your selected browser is Firefox, Waterfox or buku
      "kkharji/sqlite.lua",
      --
      --   -- Only if you're using the Telescope extension
      "nvim-telescope/telescope.nvim",
    },
  },
}
