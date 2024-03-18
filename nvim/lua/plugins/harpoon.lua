return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        local keymap = vim.keymap

        harpoon:setup({ settings = { save_on_toggle = true } })

        keymap.set("n", "<C-g>", function()
            harpoon:list():append()
        end)
        keymap.set("n", "<C-e>", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end)
        keymap.set("n", "<C-h>", function()
            harpoon:list():select(1)
        end)
        keymap.set("n", "<C-t>", function()
            harpoon:list():select(2)
        end)
        keymap.set("n", "<C-n>", function()
            harpoon:list():select(3)
        end)
        keymap.set("n", "<C-m>", function()
            harpoon:list():select(4)
        end)
    end,
}
