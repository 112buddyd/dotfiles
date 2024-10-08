return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			columns = { "icon" },
			keymaps = {
				["<C-h"] = false,
			},
			view_options = { show_hidden = true },
		})
		vim.keymap.set("n", "<leader>e", require("oil").toggle_float, { desc = "Toggle Oil float" })
	end,
}
