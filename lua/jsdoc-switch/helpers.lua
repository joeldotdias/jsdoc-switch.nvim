local H = {}

function H.switch(flag)
    local ok, lspconfig = pcall(require, "lspconfig")
    if not ok then
        vim.notify("jsdoc-switch.nvim did not find nvim-lspconfig", vim.log.levels.ERROR)
        return
    end

    for _, client in pairs(vim.lsp.get_active_clients()) do
        local client_is_tsserver = vim.tbl_contains({ "tsserver" }, client.name)
        if client_is_tsserver then
            local capabilities = client.config.capabilities
            local settings = client.config.settings
            if settings.implicitProjectConfiguration == nil then
                settings.implicitProjectConfiguration = {}
            end

            local new_opt = flag == nil and (not settings.implicitProjectConfiguration.checkJs) or flag
            settings.implicitProjectConfiguration.checkJs = new_opt

            vim.lsp.stop_client(client.id)
            client.rpc.terminate()

            lspconfig.tsserver.setup({
                settings = settings,
                capabilities = capabilities,
            })

            if require("jsdoc-switch.config").notify then
                vim.notify("JSDoc is now turned " .. (new_opt and "on" or "off"), vim.log.levels.INFO)
            end

        end
    end
end

function H.jsdoc_key(keymap, flag)
    vim.keymap.set("n", keymap, function()
        H.switch(flag)
    end)
end

return H
