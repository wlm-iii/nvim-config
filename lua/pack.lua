vim.pack.add({
    { src = "https://github.com/nvim-mini/mini.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/saghen/blink.cmp",                 version = "v1.10.2" },
    { src = "https://github.com/romus204/tree-sitter-manager.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/chomosuke/typst-preview.nvim",     version = "v1.*" },
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/folke/todo-comments.nvim" },
    { src = "https://github.com/Bekaboo/deadcolumn.nvim" },
})

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
        ["<Esc>"] = { "actions.close", mode = "n" },
    },

    float = {
        padding = 8,
        max_width = 0,
        max_height = 0,
        border = "rounded",
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
        implementation = "prefer_rust_with_warning",
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

require("which-key").add({
    { "<leader>/", group = "Telescope" },
    { "<leader>t", group = "Tabs" },
    { "<leader>p", group = "Previews" },
})

for i = 1, 9 do
    require("which-key").add({
        { "<leader>" .. i, hidden = true }
    })
end
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

--- telescope ---
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name = ev.data.spec.name
        local kind = ev.data.kind

        if name ~= "telescope-fzf-native.nvim" then
            return
        end

        if kind ~= "install" and kind ~= "update" then
            return
        end

        if vim.fn.executable("make") == 0 then
            vim.notify("make not found; cannot build telescope-fzf-native.nvim", vim.log.levels.WARN)
            return
        end

        local result = vim.system({ "make" }, {
            cwd = ev.data.path,
            text = true,
        }):wait()

        if result.code ~= 0 then
            vim.notify(
                "Failed to build telescope-fzf-native.nvim:\n" .. result.stderr,
                vim.log.levels.ERROR
            )
        end
    end,
})

vim.pack.add({
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    {
        src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
        name = "telescope-fzf-native.nvim",
    },
})

require("telescope").setup({
    defaults = {
        prompt_prefix = " ",
        selection_caret = "❯ ",
    },

    pickers = {
        find_files = {
            hidden = true,
        },
    },

    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
    },
})

local ok, err = pcall(require("telescope").load_extension, "fzf")
if not ok then
    vim.notify("Could not load Telescope fzf extension: " .. err, vim.log.levels.WARN)
end

vim.keymap.set('n', '<leader>/f', require("telescope.builtin").find_files, { desc = 'Find files' })
vim.keymap.set('n', '<leader>/g', require("telescope.builtin").live_grep, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>/b', require("telescope.builtin").buffers, { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>/h', require("telescope.builtin").help_tags, { desc = 'Help tags' })
vim.keymap.set('n', '<leader>/r', require("telescope.builtin").oldfiles, { desc = 'Recent files' })
vim.keymap.set('n', '<leader>//', function()
    require("telescope.builtin").current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = 'Fuzzily search in current buffer' })

--- typst preview ---
require("typst-preview").setup({
    debug = false,

    dependencies_bin = {
        tinymist = vim.fn.exepath("tinymist"),
        webscoat = vim.fn.exepath("websocat"),
    }
})

vim.keymap.set('n', '<leader>pt', '<cmd>TypstPreviewToggle<CR>', { desc = 'Preview Typst' })

--- todo-comments ---
require("todo-comments").setup()

vim.keymap.set('n', '<leader>/t', '<cmd>:TodoTelescope<CR>', { desc = 'Find Todos' })

--- deadcolumn ---
