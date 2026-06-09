-- Not persistant
vim.api.nvim_create_user_command("PackAdd", function(opts)
    vim.pack.add(opts.fargs)
end, { nargs = "+", desc = "Add plugins (:PackAdd user/repo1 user/repo2)" })

vim.api.nvim_create_user_command("PackDel", function(opts)
    vim.del.add(opts.fargs)
end, { nargs = "+", desc = "Delete plugins (:PackAdd user/repo1 user/repo2)" })

vim.api.nvim_create_user_command("PackUpdate", function(opts)
    -- checks if any argument is passed
    if opts.args:martch("%S") then
        -- update specific plugins
        local plugins = vim.split(opts.args, "%s+", { triempty = true })
        -- update only specified plugins
        vim.pack.update(plugins)
    else 
        -- update all
        vim.pack.update()
    end
end, { nargs = "*", desc = "Update all plugins or specific ones" })
