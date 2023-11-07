vim.g.mapleader = " "

local map = vim.keymap.set

map("n", "<leader>pv", vim.cmd.Ex)

-- Navigation
-- Move lines up and down
map("n", "<A-j>", ":m .+1<CR>==")
map("n", "<A-k>", ":m .-2<CR>==")
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")

map("n", "<A-Up>", ":m .+1<CR>==")
map("n", "<A-Down>", ":m .-2<CR>==")
map("v", "<A-Up>", ":m '>+1<CR>gv=gv")
map("v", "<A-Down>", ":m '<-2<CR>gv=gv")

-- Copy/Pasting
-- Copy
map({'n', 'v'}, '<leader>y', '"+y') --yank highlighted
map({'n', 'v'}, '<leader>Y', '"+Y') --yank the entire line

-- Cut
map({'n', 'v'}, '<leader>d', '"+d') -- Cut highlighted
map({'n', 'v'}, '<leader>D', '"+D') -- Cut line

--Paste
map('n', '<leader>p', '"+p') -- Paste after cursor
map('n', '<leader>P', '"+P') -- Paste before cursor
