vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = "Format local buffer" })
vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, { desc = "Show line diagnostics" })

vim.diagnostic.config({
    virtual_text = true,
    update_in_insert = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = " ",
        },
    },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()

vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } }
        }
    }
})

vim.lsp.enable({
    "lua_ls",
    "nil",
    "pyright",
    "clangd",
    "tinymist",
})
