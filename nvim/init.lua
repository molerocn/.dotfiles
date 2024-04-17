local vim = vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('juancamr-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
})

-- remap
vim.g.mapleader = " "
vim.keymap.set("v", "K", "k")
vim.keymap.set("v", "J", "j")
vim.keymap.set("v", "R", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "N", ":m '>+1<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("x", "p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/.local/bin/tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>")
vim.keymap.set("n", "<Tab>", ";")
vim.keymap.set("i", "<C-BS>", "<C-w>")
vim.keymap.set("i", "<C-h>", "<C-w>")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "s", "<Esc><cmd>w<CR>")
vim.keymap.set("n", "<A-e>", function()
    local command = "/" .. vim.fn.expand("%:t:r")
    vim.cmd("Ex")
    vim.cmd(command)
end)

vim.keymap.set('i', '<C-y>', 'copilot#Accept("\\<CR>")', {
	expr = true,
	replace_keycodes = false
})
vim.cmd [[let g:copilot_no_tab_map = v:true]]
vim.cmd [[let g:copilot_filetypes = {
	      \ 'markdown': v:false,
	      \ 'text': v:false,
	      \ }]]

vim.keymap.set({ "n", "v", "i" }, "<C-s>", "<Esc><cmd>w<CR>")
vim.keymap.set("n", "<C-z>", "<cmd>q<CR>")
vim.keymap.set({ "n", "i" }, "<C-l>", "<Esc>A;<Esc>")
vim.keymap.set("i", "<C-r>", "<Esc>O")

-- options
vim.opt.guicursor = ""
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
vim.opt.splitright = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.cmd("au FileType netrw nmap <buffer> a %")
vim.cmd("au FileType netrw nmap <buffer> h -")
vim.cmd("au FileType netrw nmap <buffer> r R")
vim.cmd("au FileType netrw nmap <buffer> v <nop>")
vim.cmd("au FileType netrw nmap <buffer> s <nop>")
vim.cmd("au FileType netrw nmap <buffer> o <nop>")
vim.cmd("au FileType netrw nmap <buffer> t <nop>")
vim.cmd("au FileType netrw nmap <buffer> p <nop>")
vim.cmd("set background=dark")

local treesitter_languages = { "javascript", "typescript", "python", "lua", "cpp", "markdown", "astro" }
local lsp_servers = { "clangd", "lua_ls", "pyright", "tsserver", "astro", "gopls" }

local function lazy_load(plugin)
    vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
        group = vim.api.nvim_create_augroup("BeLazyOnFileOpen" .. plugin, {}),
        callback = function()
            local file = vim.fn.expand("%")
            local condition = file ~= "NvimTree_1" and file ~= "[lazy]" and file ~= ""
            if condition then
                vim.api.nvim_del_augroup_by_name("BeLazyOnFileOpen" .. plugin)
                if plugin ~= "nvim-treesitter" then
                    vim.schedule(function()
                        require("lazy").load({ plugins = plugin })
                        if plugin == "nvim-lspconfig" then
                            vim.cmd("silent! do FileType")
                        end
                    end, 0)
                else
                    require("lazy").load({ plugins = plugin })
                end
            end
        end,
    })
end


-- plugins
require("lazy").setup({
    {
        "neovim/nvim-lspconfig",
        init = function()
            lazy_load("nvim-lspconfig")
        end,
        dependencies = { "ray-x/lsp_signature.nvim" },
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            table.remove(lsp_servers, 1)
            require("lsp_signature").setup()

            for _, lsp in ipairs(lsp_servers) do
                lspconfig[lsp].setup({
                    capabilities = capabilities,
                })
            end
            lspconfig.clangd.setup({
                capabilities = capabilities,
                cmd = { "clangd", "--offset-encoding=utf-16" },
            })
            vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
            vim.keymap.set("n", "<leader>vl", vim.diagnostic.setloclist)

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                    local opts = { buffer = ev.buf }
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
                    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
                    vim.keymap.set("n", "<leader>wl", function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts)
                    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
                    vim.keymap.set("n", "<leader>re", vim.lsp.buf.rename, opts)
                    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                    vim.keymap.set('n', '<A-f>', function()
                        vim.lsp.buf.format { async = true }
                    end, opts)
                end,
            })
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        lazy = false,
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            local luasnip = require("luasnip")
            local cmp = require("cmp")
            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "path" },
                }),
                mapping = cmp.mapping.preset.insert({
                    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                    ["<Tab>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-y>"] = cmp.config.disable,
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
                completion = { completeopt = "menu,menuone,noinsert" },
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        lazy = false,
        cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
        dependencies = { "williamboman/mason-lspconfig.nvim" },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({ ensure_installed = lsp_servers })
        end,
    },
    {
        "github/copilot.vim",
        lazy = false,
        cmd = "Copilot"
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = false,
        priority = 1000,
        config = function()
            require("rose-pine").setup({
                disable_background = true,
                styles = { italic = false }
            })
            vim.cmd.colorscheme("rose-pine")
        end,
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        lazy = false,
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")

            harpoon:setup({ settings = { save_on_toggle = true } })

            vim.keymap.set("n", "<C-g>", function()
                harpoon:list():append()
            end)
            vim.keymap.set("n", "<C-e>", function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end)
            vim.keymap.set("n", "<C-h>", function()
                harpoon:list():select(1)
            end)
            vim.keymap.set("n", "<C-t>", function()
                harpoon:list():select(2)
            end)
            vim.keymap.set("n", "<C-n>", function()
                harpoon:list():select(3)
            end)
            vim.keymap.set("n", "<C-m>", function()
                harpoon:list():select(4)
            end)
        end,
    },
    {
        "folke/trouble.nvim",
        lazy = false,
        config = function()
            require("trouble").setup({
                icons = false,
                fold_open = "-",
                fold_closed = "+",
                indent_lines = false,
                signs = {
                    error = "E",
                    warning = "W",
                    hint = "H",
                    information = "I"
                },
                use_diagnostic_signs = false
            })

            vim.keymap.set("n", "<leader>tr", "<cmd>TroubleToggle<cr>")
            vim.keymap.set("n", "[d", function()
                require("trouble").previous({ skip_groups = true, jump = true })
            end)
            vim.keymap.set("n", "]d", function()
                require("trouble").next({ skip_groups = true, jump = true })
            end)
        end,
    },
    {
        "mbbill/undotree",
        cmd = "UndotreeToggle"
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        cmd = "Telescope",
        dependencies = { "nvim-lua/plenary.nvim" },
        lazy = false,
        config = function()
            local builtin = require("telescope.builtin")

            require("telescope").setup({
                defaults = {
                    file_ignore_patterns = { "node_modules", "build", ".git", "dist", ".obsidian" },
                    mappings = { i = { ["<C-u>"] = false, } },
                },
                pickers = { find_files = { hidden = true } }
            })

            vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<CR>", {})
            vim.keymap.set("n", "<leader>ps", function()
                builtin.grep_string({ search = vim.fn.input("Grep > ") })
            end)
            -- change theme
            vim.keymap.set("n", "<leader>th", function()
                builtin.colorscheme()
            end)
        end,
    },
    {
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
            init = function()
                lazy_load("nvim-treesitter")
            end,
            config = function()
                local configs = require("nvim-treesitter.configs")

                configs.setup({
                    ensure_installed = treesitter_languages,
                    sync_install = false,
                    highlight = { enable = true },
                    indent = { enable = true },
                })
            end,
        },
        {
            "nvim-treesitter/nvim-treesitter-context",
            init = function()
                lazy_load("nvim-treesitter-context")
            end,
            config = function()
                require("treesitter-context").setup()
            end,
        }
    },
    {
        "tpope/vim-fugitive",
        lazy = false,
        config = function()
            vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>")
            vim.keymap.set("n", "<leader>gp", "<cmd>Git push<CR>")
            vim.keymap.set("n", "<leader>gl", "<cmd>Git log --oneline --decorate --graph --all<CR>")
            vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
            vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
        end,
    },
    {
        "epwalsh/obsidian.nvim",
        version = "*",
        ft = "markdown",
        dependencies = { "nvim-lua/plenary.nvim", },
        config = function()
            require("obsidian").setup({
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
    },
    {
        "windwp/nvim-ts-autotag",
        lazy = false,
    }
}, { defaults = { lazy = true } })
