-- Local and global leaders
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Tell Neovim I have a Nerd font installed
vim.g.have_nerd_font = true

-- LazyVim auto format
vim.g.autoformat = true

-- LazyVim root dir detection
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

vim.g.lazygit_config = true

-- Hide deprecation warnings
vim.g.deprecation_warnings = false

-- Show the current document symbols location from Trouble in lualine
vim.g.trouble_lualine = true

local opt = vim.opt

opt.autowrite = true -- Enable auto write
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect,popup,fuzzy"
opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.cursorlineopt = "line,number" -- Highlight the cursor line and the number of the line
opt.expandtab = true -- Use spaces instead of tabs
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
opt.foldlevel = 99
opt.formatexpr = "v:lua.require'lazyvim.util'.format.formatexpr()"
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Ignore case
opt.inccommand = "split" -- preview incremental substitute
opt.laststatus = 3 -- global statusline
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup bleng
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 8 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = "en,fr" -- Check spelling for English and French
opt.spellsuggest = "best"
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.statuscolumn = [[%!v:lua.require'snacks'.statuscolumn()]]
opt.tabstop = 2 -- Number of spaces tabs count for
opt.softtabstop = 2
opt.termguicolors = true -- True color support
opt.timeoutlen = 300 -- Lower than default (1000) to quickly trigger which-key
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 50 -- Save swap file and trigger CursorHold
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap
opt.autoindent = true -- Copy indent from previous line
opt.copyindent = true -- Copy the structure of the previous line's indent
opt.autoread = true -- Automatically reload file if modified outside of Neovim
opt.hlsearch = true -- Highlight on search
opt.incsearch = true -- Incremental highlighting on search

if vim.fn.has("nvim-0.10") == 1 then
  opt.smoothscroll = true
  opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
  opt.foldmethod = "expr"
  opt.foldtext = ""
else
  opt.foldmethod = "indent"
  opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

vim.g.snacks_animate = false
