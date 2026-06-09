require("vim._core.ui2").enable({})

vim.pack.add({
    { src = "https://github.com/ellisonleao/gruvbox.nvim" },
})

require("gruvbox").setup({})
vim.cmd.colorscheme("gruvbox")

require("options")
require("keymaps")
require("commands")
require("pack")
require("treesitter")
