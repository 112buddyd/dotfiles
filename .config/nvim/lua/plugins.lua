vim.pack.add({
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/echasnovski/mini.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/mfussenegger/nvim-dap" },
  { src = "https://github.com/mfussenegger/nvim-dap-python" },
  { src = "https://github.com/rcarriga/nvim-dap-ui" },
  { src = "https://github.com/nvim-neotest/nvim-nio" }, -- required by dap-ui
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/williamboman/mason.nvim" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
  { src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
  { src = "https://github.com/hrsh7th/cmp-buffer" },
  { src = "https://github.com/hrsh7th/cmp-path" },
  { src = "https://github.com/mfussenegger/nvim-lint" },
  { src = "https://github.com/folke/flash.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/kdheepak/lazygit.nvim" },
})

-- lazygit
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

-- treesitter
local ok, ts = pcall(require, "nvim-treesitter.configs")
if ok then
  ts.setup({
    ensure_installed = { "javascript", "typescript", "python", "rust", "json", "yaml", "toml", "markdown", "lua", "vim", "vimdoc" },
    auto_install = true,
    highlight = { enable = true },
  })
end

-- flash
require("flash").setup()
vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash jump" })

-- nvim-cmp
local cmp = require("cmp")
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"]      = cmp.mapping.confirm({ select = true }),
    ["<C-e>"]     = cmp.mapping.abort(),
    ["<C-n>"]     = cmp.mapping.select_next_item(),
    ["<C-p>"]     = cmp.mapping.select_prev_item(),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "buffer" },
  }),
})

-- nvim-lint
local lint = require("lint")
lint.linters_by_ft = {
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  python     = { "ruff" },
}
vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
  callback = function() lint.try_lint() end,
})

-- render-markdown
require("render-markdown").setup()

-- mason
require("mason").setup()
require("mason-tool-installer").setup({
  ensure_installed = {
    -- formatters
    "prettierd", "ruff", "taplo",
    -- lsp
    "typescript-language-server", "basedpyright", "rust-analyzer",
    "json-lsp", "yaml-language-server", "marksman", "eslint_d",
  },
  auto_update = true,
})

-- lsp
vim.lsp.enable({ "ts_ls", "basedpyright", "rust_analyzer", "jsonls", "yamlls", "taplo", "marksman" })

-- conform
require("conform").setup({
  formatters_by_ft = {
    javascript  = { "prettierd" },
    typescript  = { "prettierd" },
    json        = { "prettierd" },
    yaml        = { "prettierd" },
    markdown    = { "prettierd" },
    python      = { "ruff_format" },
    rust        = { "rustfmt" },
    toml        = { "taplo" },
  },
  format_on_save = { timeout_ms = 500, lsp_fallback = true },
})

-- dap
local dap = require("dap")
local dapui = require("dapui")

require("dap-python").setup("/Users/buddy/.local/share/mise/installs/python/3.14.3/bin/python3")

dapui.setup()
dap.listeners.after.event_initialized["dapui"] = function() dapui.open() end
dap.listeners.before.event_terminated["dapui"] = function() dapui.close() end
dap.listeners.before.event_exited["dapui"] = function() dapui.close() end

vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>dc", dap.continue,          { desc = "Continue" })
vim.keymap.set("n", "<leader>di", dap.step_into,         { desc = "Step into" })
vim.keymap.set("n", "<leader>do", dap.step_over,         { desc = "Step over" })
vim.keymap.set("n", "<leader>dO", dap.step_out,          { desc = "Step out" })
vim.keymap.set("n", "<leader>dt", dapui.toggle,          { desc = "Toggle DAP UI" })

-- gitsigns
require("gitsigns").setup({
  on_attach = function(bufnr)
    local gs = require("gitsigns")
    local map = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
    end
    map("]h", gs.next_hunk, "Next hunk")
    map("[h", gs.prev_hunk, "Prev hunk")
    map("<leader>hs", gs.stage_hunk, "Stage hunk")
    map("<leader>hr", gs.reset_hunk, "Reset hunk")
    map("<leader>hp", gs.preview_hunk, "Preview hunk")
    map("<leader>hb", gs.blame_line, "Blame line")
  end,
})

-- mini
require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.statusline").setup()
require("mini.tabline").setup()
require("mini.trailspace").setup()
require("mini.icons").setup()

-- which-key
require("which-key").setup()

-- oil
require("oil").setup()
vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "File explorer" })

-- colorscheme
vim.cmd.colorscheme("catppuccin-mocha")

-- telescope
local tb = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", tb.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", tb.live_grep,  { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", tb.buffers,        { desc = "Buffers" })
vim.keymap.set("n", "<leader>fs", tb.lsp_document_symbols, { desc = "Find symbols" })

