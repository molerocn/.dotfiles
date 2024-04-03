return {
    "epwalsh/obsidian.nvim",
    version = "*",
    ft = "markdown",
    dependencies = { "nvim-lua/plenary.nvim", },
    config = function ()
        require("obsidian").setup ({
            ui = { enable = false },
            disable_frontmatter = true,
            workspaces = {
                { name = "personal", path = "~/personal/second_mind" },
            },
            templates = {
                subdir = "templates",
                date_format = "%d/%m/%Y",
                time_format = "%H:%M",
            },
            attachments = {
                img_folder = "./assets/"
            }
        })
        vim.keymap.set("n", "<M-l>", "<cmd>ObsidianOpen<CR>")
        vim.keymap.set("n", "<M-t>", "<cmd>ObsidianTemplate<CR>")
        vim.keymap.set("n", "<leader>op", "<cmd>ObsidianPasteImg<CR>")
    end
}
