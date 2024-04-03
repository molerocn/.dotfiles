return {
    'windwp/nvim-autopairs',
    lazy = false,
    config = function()
        local autopairs = require('nvim-autopairs')
        autopairs.setup()
        autopairs.disable()
    end
}
