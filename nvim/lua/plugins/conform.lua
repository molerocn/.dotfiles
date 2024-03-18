return {
    'stevearc/conform.nvim',
    lazy = false,
    config = function()
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                python = { "ruff_format" },
                typescript = { "prettierd" },
                typescriptreact = { "prettierd" },
            },
        })
        vim.keymap.set("n", "<A-f>", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 500,
            })
        end)
    end
}
