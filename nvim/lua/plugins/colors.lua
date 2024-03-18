return {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("gruvbox").setup({
            transparent_mode = true,
            contrast = "hard",
            italic = {
                strings = false,
                emphasis = false,
                comments = true,
                operators = false,
                folds = true,
            },
        })

        vim.cmd.colorscheme("gruvbox")
    end,
}
