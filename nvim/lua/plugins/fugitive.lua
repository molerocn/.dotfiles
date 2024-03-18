return {
    "tpope/vim-fugitive",
    lazy = false,
    config = function()
        vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>4j")
        vim.keymap.set("n", "<leader>gl", "<cmd>Git log --oneline --decorate --graph --all<CR>")
        vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
        vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
    end,
}
