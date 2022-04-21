-- hook to nvim-lspconfig
require("grammar-guard").init()

-- setup LSP config
require("lspconfig").grammar_guard.setup({
  cmd = { vim.fn.getenv("HOME") ..'/.local/share/nvim/lsp_servers/ltex/ltex-ls/bin/ltex-ls' }, -- add this if you install ltex-ls yourself
  settings = {
    ltex = {
      enabled = { "latex", "tex", "bib", "markdown" },
      language = "en",
      diagnosticSeverity = "information",
      setenceCacheSize = 2000,
      additionalRules = {
        enablePickyRules = true,
        motherTongue = "en",
      },
      trace = { server = "verbose" },
      dictionary = { ["en-US"] = { ":" .. vim.fn.getenv("HOME") .. "/.vim-spell-en.utf-8.add" } },
      disabledRules = {},
      hiddenFalsePositives = {},
    },
  },
})

local lspconfig = require("lspconfig")

-- This assumes `ccls` exists on path
-- lspconfig.ccls.setup {}
