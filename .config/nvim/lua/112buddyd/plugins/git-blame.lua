return {
 "f-person/git-blame.nvim",
  setup = {
    enable = false,
  },
  config = function()
		vim.keymap.set("n", "<leader>gb", "<cmd>GitBlameToggle<cr>", { desc = "Toggle git blame" })
		vim.keymap.set("n", "<leader>go", "<cmd>GitBlameOpenCommitURL<cr>", { desc = "Open related commit" })
  end,
}
