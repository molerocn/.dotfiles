return {
    "neovim/nvim-lspconfig",
    init = function()
        require("juancamr.utils").lazy_load("nvim-lspconfig")
    end,
    dependencies = { "ray-x/lsp_signature.nvim" },
    config = function()
        local servers = require("juancamr.utils").lsp_servers
        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        table.remove(servers, 1)
        require("lsp_signature").setup()

        for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup({
                capabilities = capabilities,
            })
        end
        lspconfig.clangd.setup({
            capabilities = capabilities,
            cmd = { "clangd", "--offset-encoding=utf-16" },
        })
        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
        vim.keymap.set("n", "<leader>vl", vim.diagnostic.setloclist)

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                local opts = { buffer = ev.buf }
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
                vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
                vim.keymap.set("n", "<leader>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, opts)
                vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
                vim.keymap.set("n", "<leader>re", vim.lsp.buf.rename, opts)
                vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            end,
        })
    end,
}
