local tree = require("neo-tree")

vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>")
vim.keymap.set("n", "<leader>fe", "<Cmd>Neotree focus<CR>")

tree.setup({
    close_if_last_window = true,
    filesystem = {
        filtered_items = {
            hide_gitignored = true,
            never_show_by_pattern = {
                "*.meta", -- Hide Unity meta files
            }
        }
    }
})
