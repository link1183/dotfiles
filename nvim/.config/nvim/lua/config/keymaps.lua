local map = LazyVim.safe_keymap_set

-- moving to the beginning or the end of the window
map({ "n", "v" }, "gg", "gg0")
map({ "n", "v" }, "G", "Gzz")
map("i", "jj", "<esc>")

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<cmd> NvimTmuxNavigateLeft<CR>", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<cmd> NvimTmuxNavigateDown<CR>", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<cmd> NvimTmuxNavigateUp<CR>", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<cmd> NvimTmuxNavigateRight<CR>", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
map("n", "<A-Down>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-Up>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-Down>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-Up>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- buffers
map("n", "<C-Tab>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next Buffer" })

-- open bookmarks
map("n", "<leader>bm", "<cmd>BrowserBookmarks<cr>", {
  desc = "Fuzzy search browser bookmarks",
})

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / Clear hlsearch / Diff Update" }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zz'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward].'zz'", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward].'zz'", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zz'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward].'zz'", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward].'zz'", { expr = true, desc = "Prev Search Result" })
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- save file
vim.api.nvim_set_keymap("n", "<C-s>", "<cmd>w<cr>", { noremap = true, silent = true })

--keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- highlights under cursor
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
map("n", "<leader>uI", "<cmd>InspectTree<cr>", { desc = "Inspect Tree" })

-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other Window", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })
map("n", "<leader>w-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>w|", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
