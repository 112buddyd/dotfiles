local map = vim.keymap.set

map("n", "<Tab>", "<cmd>:bn<cr>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>:bp<cr>", { desc = "Prev buffer" })

map('n', 'gK', function()
  local new_config = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = 'Toggle diagnostic virtual_lines' })
