-- https://www.lazyvim.org/
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins", version = "*" },

    -- UI stuff
    { import = "lazyvim.plugins.extras.ui.edgy", version = "*" },
    { import = "lazyvim.plugins.extras.ui.treesitter-context", version = "*" },

    -- Languages
    { import = "lazyvim.plugins.extras.lang.angular", version = "*" },
    { import = "lazyvim.plugins.extras.lang.clangd", version = "*" },
    { import = "lazyvim.plugins.extras.lang.cmake", version = "*" },
    { import = "lazyvim.plugins.extras.lang.docker", version = "*" },
    { import = "lazyvim.plugins.extras.lang.git", version = "*" },
    { import = "lazyvim.plugins.extras.lang.go", version = "*" },
    { import = "lazyvim.plugins.extras.lang.java", version = "*" },
    { import = "lazyvim.plugins.extras.lang.json", version = "*" },
    { import = "lazyvim.plugins.extras.lang.markdown", version = "*" },
    { import = "lazyvim.plugins.extras.lang.nix", version = "*" },
    { import = "lazyvim.plugins.extras.lang.nushell", version = "*" },
    { import = "lazyvim.plugins.extras.lang.php", version = "*" },
    { import = "lazyvim.plugins.extras.lang.python", version = "*" },
    { import = "lazyvim.plugins.extras.lang.rust", version = "*" },
    { import = "lazyvim.plugins.extras.lang.yaml", version = "*" },
    { import = "lazyvim.plugins.extras.lang.sql", version = "*" },
    { import = "lazyvim.plugins.extras.lang.toml", version = "*" },
    { import = "lazyvim.plugins.extras.lang.typescript", version = "*" },
    { import = "lazyvim.plugins.extras.lang.yaml", version = "*" },
    { import = "lazyvim.plugins.extras.lang.omnisharp", version = "*" },
    { import = "lazyvim.plugins.extras.lang.prisma", version = "*" },
    { import = "lazyvim.plugins.extras.lang.zig", version = "*" },

    -- Linting
    { import = "lazyvim.plugins.extras.linting.eslint", version = "*" },

    -- AI extras
    { import = "lazyvim.plugins.extras.ai.copilot-chat", version = "*" },

    -- Coding extras
    { import = "lazyvim.plugins.extras.coding.luasnip", version = "*" },
    { import = "lazyvim.plugins.extras.coding.mini-surround", version = "*" },
    { import = "lazyvim.plugins.extras.coding.yanky", version = "*" },

    -- DAP stuff
    { import = "lazyvim.plugins.extras.dap.core", version = "*" },
    { import = "lazyvim.plugins.extras.dap.nlua", version = "*" },

    -- Editor stuff
    { import = "lazyvim.plugins.extras.editor.dial", version = "*" },
    { import = "lazyvim.plugins.extras.editor.harpoon2", version = "*" },
    { import = "lazyvim.plugins.extras.editor.illuminate", version = "*" },
    { import = "lazyvim.plugins.extras.editor.mini-diff", version = "*" },
    { import = "lazyvim.plugins.extras.editor.mini-move", version = "*" },
    { import = "lazyvim.plugins.extras.editor.refactoring", version = "*" },
    { import = "lazyvim.plugins.extras.editor.fzf", version = "*" },
    { import = "lazyvim.plugins.extras.editor.telescope", version = "*" },
    { import = "lazyvim.plugins.extras.editor.overseer", version = "*" },
    -- { import = "lazyvim.plugins.extras.editor.inc-rename", version = "*" },

    -- Formatting stuff
    { import = "lazyvim.plugins.extras.formatting.black", version = "*" },
    { import = "lazyvim.plugins.extras.formatting.prettier", version = "*" },

    -- LSP stuff
    { import = "lazyvim.plugins.extras.lsp.neoconf", version = "*" },
    { import = "lazyvim.plugins.extras.lsp.none-ls", version = "*" },

    -- Test stuff
    { import = "lazyvim.plugins.extras.test.core", version = "*" },

    -- Utils
    { import = "lazyvim.plugins.extras.util.dot", version = "*" },
    { import = "lazyvim.plugins.extras.util.mini-hipatterns", version = "*" },
    { import = "lazyvim.plugins.extras.util.dot", version = "*" },

    -- Own config/plugins
    { import = "plugins" },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  -- checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
