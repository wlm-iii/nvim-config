require("tree-sitter-manager").setup({
    ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "markdown",
        "markdown_inline",
        "c",
        "cpp",
        "python",
        "bash",
        "json",
        "toml",
        "nix",
        "typst",
        "rust",
    },

    auto_install = false,

    highlight = true,

    border = "rounded",
})

local treesitter_filetypes = {
  "lua",
  "vim",
  "vimdoc",
  "markdown",
  "c",
  "cpp",
  "python",
  "bash",
  "sh",
  "json",
  "toml",
  "nix",
  "typst",
  "rust",
}

vim.treesitter.language.register("bash", "sh")

vim.api.nvim_create_autocmd("FileType", {
    pattern = treesitter_filetypes,
    callback = function(ev)
        local lang = vim.treesitter.language.get_lang(ev.match)
        if not lang then
            return
        end

        local ok, err = pcall(vim.treesitter.start, ev.buf, lang)
        if not ok then
            vim.notify(
                ("Tree-sitter unavailable for %s: %s"):format(ev.match, err),
                vim.log.levels.WARN
            )
            return
        end

        vim.wo.foldmethod = "expr"
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo.foldlevel = 99
    end,
})
