local keymap = vim.keymap

vim.g.mapleader = " "

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")
keymap.set("n", "J", "mzJ`z")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")
keymap.set("x", "p", [["_dP]])
keymap.set({ "n", "v" }, "<leader>y", [["+y]])
keymap.set("i", "<C-c>", "<Esc>")
keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/.local/bin/tmux-sessionizer<CR>")
keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>")
keymap.set("n", "<Tab>", ";")
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")
keymap.set("i", "<C-BS>", "<C-w>")
keymap.set("i", "<C-h>", "<C-w>")
keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
-- keymap.set("n", "<A-e>", "<cmd>Ex<CR>")

-- save
keymap.set({"n", "v", "i"}, "<C-s>", "<Esc><cmd>w<CR>")
-- keymap.set({"n", "v", "i"}, "<C-s>", "<nop>")
keymap.set({"n", "i"}, "<C-l>", "<Esc>A;<Esc>")
keymap.set("i", "<C-r>", "<Esc>O")
keymap.set("n", "<leader>d", "Vd<cmd>w<CR>")

-- custom snippets
keymap.set("n", "<leader>rc",
    "iconst Template = () => {<CR>return (<CR><div>Hello from Template</div><CR>);<CR>};<CR><CR>export default Template;<Esc>=gg[[:%s/Template/")
