return {
    "windwp/nvim-ts-autotag",
    init = function()
        require("juancamr.utils").lazy_load("nvim-ts-autotag")
    end,
    config = function()
        require("nvim-ts-autotag").setup()
    end
}
