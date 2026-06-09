vim.pack.add({
    { src = "https://github.com/ellisonleao/gruvbox.nvim" },
    { src = "https://github.com/nvim-mini/mini.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/saghen/blink.cmp",                 version = "v1.10.2" },
    { src = "https://github.com/romus204/tree-sitter-manager.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/chomosuke/typst-preview.nvim",     version = "v1.*" },
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
})

--- gruvbox ---
require("gruvbox").setup({
})

vim.o.background = "dark"
vim.cmd.colorscheme("gruvbox")

--- mini icons ---
require("mini.icons").setup({
    style = "glyph",
})

--- mini notify ---
require("mini.notify").setup({
    autocorrect = { enable = false }
})

--- mini surround ---
require("mini.surround").setup()

--- oil ---
require("oil").setup({
    default_file_explorer = true,

    columns = {
        "icon",
    },

    win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "nvic",
    },

    lsp_file_methods = {
        enabled = true,
        timeout_ms = 1000,
        autosave_changes = false
    },

    constrain_cursor = "editable",

    keymaps = {
        ["<CR>"] = "actions.select",
        ["<C-s>"] = { "actions.select", opts = { vertical = true } },
        ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
        ["<C-t>"] = { "actions.select", opts = { tab = true } },
        ["<C-c>"] = { "actions.close", mode = "n" },
    },

    float = {
        padding = 8,
        max_width = 0,
        max_height = 0,
        border = "rounded",
        -- win_options = {
        --   winblend = 0,
        --   winhighlight = "NormalFloat:Normal,FloatBorder:Normal",
        -- },
        get_win_title = nil,
        preview_split = "auto",
        override = function(conf)
            return conf
        end,
    },
})

vim.keymap.set("n", [[\]], function()
    require("oil").toggle_float()
end, { desc = "Toggle Oil float" })

--- blink completion ---
require("blink.cmp").setup({
    keymap = {
        preset = "default",
    },

    appearance = {
        nerd_font_variant = "mono",
    },

    completion = {
        menu = {
            direction_priority = { "s", "n" },
            max_height = 8,
        },

        documentation = {
            auto_show = true,
        },
    },

    sources = {
        default = {
            "lsp",
            "path",
            "snippets",
            "buffer",
        },
    },

    fuzzy = {
        implementation = "prefer_rust",
    },

    signature = {
        enabled = true,
    },
})

--- tree-sitter-manager ---
require("tree-sitter-manager")

--- lsp ---
require("lsp")

--- whichkey ---
require("which-key").setup({
    preset = "classic",

    delay = function(ctx)
        return ctx.plugin and 0 or 200
    end,

    icons = {
        mappings = true,
    },

    win = {
        border = "rounded",
    },
})

--- gitsigns ---
require("gitsigns").setup({
    signs = {
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
    },

    signs_staged_enable = true,
    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,

    current_line_blame = false,

    preview_config = {
        border = "rounded",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
    },
})

--- lualine ---
require("lualine").setup({})

--- typst preview ---
require("typst-preview").setup({
    debug = false,

    dependencies_bin = {
        tinymist = vim.fn.exepath("tinymist"),
        webscoat = vim.fn.exepath("websocat"),
    }
})
