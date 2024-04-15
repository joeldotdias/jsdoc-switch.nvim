local lsp = require("lspconfig")
local H = {}

function H.switch(flag)
    for _, client in pairs(vim.lsp.get_active_clients()) do
        local client_is_tsserver = vim.tbl_contains({ "tsserver" }, client.name)
        if client_is_tsserver then
            local capabilities = client.config.capabilities
            local settings = client.config.settings
            if settings.implicitProjectConfiguration == nil then
                settings.implicitProjectConfiguration = {}
            end
            local new_opt = flag or not settings.implicitProjectConfiguration.checkJs
            settings.implicitProjectConfiguration.checkJs = new_opt

            vim.lsp.stop_client(client.id)
            client.rpc.terminate()

            lsp.tsserver.setup({
                settings = settings,
                capabilities = capabilities,
            })

            local message = "JSDoc is now turned " .. (new_opt and "on" or "off")
            vim.print(message)
        end
    end
end

function H.jsdoc_key(keymap, flag)
    vim.keymap.set("n", keymap, function()
        H.switch(flag)
    end)
end

return H
