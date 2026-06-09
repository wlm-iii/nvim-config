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

vim.keymap.set("n", "<leader>tn", ":$tabnew<CR>", { desc = "Open new tab" })
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { desc = "Close current tab" })
vim.keymap.set("n", "<leader>to", ":tabonly<CR>", { desc = "Close all other tabs" })
vim.keymap.set("n", "<leader>tl", ":tabn<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<leader>th", ":tabp<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "<leader>tH", "<cmd>-tabmove<cr>", { desc = "Move tab left" })
vim.keymap.set("n", "<leader>tL", "<cmd>+tabmove<cr>", { desc = "Move tab right" })

for i = 1, 9 do
    vim.keymap.set("n", "<leader>t" .. i, i .. "gt", {
        desc = "Go to tab " .. i,
    })
end

vim.keymap.set("n", "<leader>m", function()
        if vim.o.mouse == "" then
            vim.opt.mouse = "a"
            vim.notify("Mouse enabled")
        else
            vim.opt.mouse = ""
            vim.notify("Mouse disabled")
        end
    end,
    { desc = "Toggle mouse", }
)
