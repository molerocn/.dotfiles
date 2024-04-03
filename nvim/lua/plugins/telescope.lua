return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    config = function()
        local builtin = require("telescope.builtin")
        local action_set = require("telescope.actions.set")
        local keymap = vim.keymap

        require("telescope").setup({
            defaults = {
                file_ignore_patterns = { "node_modules", "build", ".git", "dist", ".obsidian" },
                mappings = { i = { ["<C-u>"] = false, } },
            },
            pickers = { find_files = { hidden = true } }
        })

        keymap.set("n", "<C-p>", "<cmd>Telescope find_files<CR>", {})
        keymap.set("n", "<leader>ps", function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        -- change theme
        keymap.set("n", "<leader>th", function()
            builtin.colorscheme()
        end)
    end,
}
