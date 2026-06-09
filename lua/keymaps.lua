vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set("n", "<Esc>", ":nohl<CR>", {
    desc = "Clear search highlighting",
    silent = true
})

vim.keymap.set("n", "<leader>w", ":write<CR>", {
    desc = "Write buffer"
})

vim.keymap.set("n", "<leader>q", ":quit<CR>", {
    desc = "Quit buffer"
})

vim.keymap.set("n", "<leader>u", function()
    vim.cmd.packadd("nvim.undotree")
    require("undotree").open()
end, { desc = "Toggle Builtin Undotree" })
