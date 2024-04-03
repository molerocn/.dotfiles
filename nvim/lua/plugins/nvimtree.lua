return {
  "nvim-tree/nvim-tree.lua",
  lazy = false,
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    local function on_attach(bufnr)
      local api = require("nvim-tree.api")
      api.config.mappings.default_on_attach(bufnr)

      vim.keymap.del("n", "<C-e>", { buffer = bufnr })
      vim.keymap.del("n", "<C-t>", { buffer = bufnr })
    end

    require("nvim-tree").setup({
      on_attach = on_attach,
      actions = { open_file = { quit_on_open = true } },
      git = { enable = false },
      view = { width = 40 },
      renderer = {
        root_folder_label = false,
        highlight_git = false,
        highlight_opened_files = "none",
        indent_markers = { enable = false },
        icons = {
          show = { folder = false, file = false },
          glyphs = { folder = { arrow_open = "-", arrow_closed = "+" } }
        },
      },
    })

    local api = require("nvim-tree.api")
    api.events.subscribe(api.events.Event.FileCreated, function(file)
      vim.cmd("edit " .. file.fname)
    end)
    vim.keymap.set({ "n", "i" }, "<A-e>", "<Esc><cmd>NvimTreeFindFile<CR><C-w>ozz")
  end,
}
