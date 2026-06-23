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

vim.keymap.set("n", "<leader>tn", "<cmd>$tabnew<CR>", { desc = "Open new tab" })
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "Close current tab" })
vim.keymap.set("n", "<leader>to", "<cmd>tabonly<CR>", { desc = "Close all other tabs" })
vim.keymap.set("n", "<leader>tl", "<cmd>tabn<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<leader>th", "<cmd>tabp<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "<leader>tH", "<cmd>-tabmove<CR>", { desc = "Move tab left" })
vim.keymap.set("n", "<leader>tL", "<cmd>+tabmove<CR>", { desc = "Move tab right" })

for i = 1, 9 do
    vim.keymap.set("n", "<leader>" .. i, i .. "gt", {
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

vim.keymap.set("n", "<leader>s", "<cmd>set spell<CR>", { desc = "Toggle spell check" })
