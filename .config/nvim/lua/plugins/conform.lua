return {
  {
    'stevearc/conform.nvim',
    opts = {
    formatters_by_ft = {
        -- lua = { "stylua" }, -- cant in AL2 due to GLIBC
        python = {
          "ruff_fix",
          "ruff_format",
          "ruff_organize_imports",
        },
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    },
  },
}
