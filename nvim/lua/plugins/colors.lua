return {
    "ellisonleao/gruvbox.nvim",
    dependencies = { "projekt0n/github-nvim-theme" },
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

        -- -- theming
        -- local current_hour = tonumber(os.date("%H"))
        -- print(current_hour)
        -- if current_hour <= 6 or current_hour >= 17 then
        --     vim.cmd.colorscheme("gruvbox")
        -- else
        --     vim.cmd.colorscheme("github_light_default")
        -- end
        --
    end,
}
