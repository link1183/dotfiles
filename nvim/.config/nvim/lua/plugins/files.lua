return {
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  {
    "stevearc/oil.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local oil = require("oil")
      oil.setup({
        default_file_explorer = true,
        columns = {
          "icon",
        },
        buf_options = {
          buflisted = false,
          bufhidden = "hide",
        },
        win_options = {
          wrap = true,
          winblend = 0,
          signcolumn = "no",
          cursorcolumn = false,
          foldcolumn = "0",
          spell = false,
          list = false,
          conceallevel = 3,
          concealcursor = "nvic",
        },
        delete_to_trash = false,
        skip_confirm_for_simple_edits = true,
        prompt_save_on_select_new_entry = true,
        cleanup_delay_ms = 1000,
        lsp_file_methods = {
          timeout_ms = 1000,
          autosave_changes = true,
        },
        constrain_cursor = "editable",
        watch_for_changes = true,
        use_default_keymaps = true,
        view_options = {
          show_hidden = true,
          is_hidden_file = function(name, _)
            return vim.startswith(name, ".")
          end,
          is_always_hidden = function(name, _)
            return name == ".." or name == ".git"
          end,
          natural_order = true,
          case_insensitive = false,
          sort = {
            { "type", "asc" },
            { "name", "asc" },
          },
        },
        extra_scp_args = {},

        float = {
          padding = 2,
          max_width = 0,
          max_height = 0,
          border = "rounded",
          preview_split = "auto",
          override = function(conf)
            return conf
          end,
        },
        preview = {
          max_width = 0.9,
          min_width = { 40, 0.4 },
          width = nil,
          max_height = 0.9,
          min_height = { 5, 0.1 },
          height = nil,
          border = "rounded",
          win_options = {
            winblend = 0,
          },
          update_on_cursor_moved = true,
        },
        progress = {
          max_width = 0.9,
          min_width = { 40, 0.4 },
          width = nil,
          max_height = { 10, 0.9 },
          min_height = { 5, 0.1 },
          height = nil,
          border = "rounded",
          minimized_border = "none",
          win_options = {
            winblend = 0,
          },
        },
        ssh = {
          border = "rounded",
        },
        keymaps_help = {
          border = "rounded",
        },
      })
      vim.keymap.set("n", "-", oil.toggle_float, {})
    end,
  },
}
