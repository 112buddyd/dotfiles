vim.g.mapleader = " "

local map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

-- windows
map("n", "<leader>sv", "<C-w>v", "Split vertical")
map("n", "<leader>sh", "<C-w>s", "Split horizontal")
map("n", "<C-h>", "<C-w>h", "Move left")
map("n", "<C-l>", "<C-w>l", "Move right")
map("n", "<C-j>", "<C-w>j", "Move down")
map("n", "<C-k>", "<C-w>k", "Move up")

-- buffers
map("n", "<leader>bd", "<cmd>bd<cr>", "Delete buffer")
map("n", "<Tab>", "<cmd>bnext<cr>", "Next buffer")
map("n", "<S-Tab>", "<cmd>bprev<cr>", "Prev buffer")

-- misc
map("n", "<Esc>", "<cmd>nohlsearch<cr>", "Clear search highlight")
map("v", "<", "<gv", "Indent left")
map("v", ">", ">gv", "Indent right")

-- lsp (set on LspAttach)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
    vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover docs" }))
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename" }))
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Diagnostics" }))
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Prev diagnostic" }))
  end,
})


