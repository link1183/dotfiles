return {
  {
    "sylvanfranklin/omni-preview.nvim",
    opts = {},
    dependencies = {
      -- Typst
      { "chomosuke/typst-preview.nvim", lazy = true },
      -- CSV
      {
        "hat0uma/csvview.nvim",
        ---@module "csvview"
        ---@type CsvView.Options
        opts = {
          view = {
            display_mode = "border",
            header_lnum = 1,
            sticky_header = {
              enabled = true,
            },
          },
          parser = { comments = { "#", "//" } },
          keymaps = {
            -- Text objects for selecting fields
            textobject_field_inner = { "if", mode = { "o", "x" } },
            textobject_field_outer = { "af", mode = { "o", "x" } },
            jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
            jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
            jump_next_row = { "<Enter>", mode = { "n", "v" } },
            jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
          },
        },
        cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
      },
      {
        "barrett-ruth/live-server.nvim",
        build = "pnpm add -g live-server",
        cmd = { "LiveServerStart", "LiveServerStop" },
        config = true,
      },
    },
    keys = {
      { "<leader>po", "<cmd>OmniPreview start<CR>", desc = "OmniPreview Start" },
      { "<leader>pc", "<cmd>OmniPreview stop<CR>", desc = "OmniPreview Stop" },
    },
  },
}
