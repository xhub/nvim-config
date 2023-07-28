-- -- hook to nvim-lspconfig
-- require("grammar-guard").init()
-- 
-- -- setup LSP config
-- require("lspconfig").grammar_guard.setup({
--   cmd = { vim.fn.getenv("HOME") ..'/.local/share/nvim/mason/bin/ltex-ls' }, -- add this if you install ltex-ls yourself
--   settings = {
--     ltex = {
-- --      enabled = { "latex", "tex", "bib", "markdown", "text" },
--       enabled = { "bib", "markdown", "text" },
--       language = "en",
--       -- diagnosticSeverity = "information",
--       dignosticSeverity = "hint",
--       sentenceCacheSize = 2000,
--       additionalRules = {
--         enablePickyRules = true,
--         motherTongue = "fr",
--       },
--       trace = { server = "verbose" },
--       dictionary = { ["en-US"] = { ":" .. vim.fn.getenv("HOME") .. "/.vim-spell-en.utf-8.add" } },
--       disabledRules = {},
--       hiddenFalsePositives = {},
--     },
--   },
-- })


require('goto-preview').setup({
  default_mappings = true;
})

vim.g.vimtex_view_method = 'sioyek'

-- local lspconfig = require("lspconfig")

-- This assumes `ccls` exists on path
-- lspconfig.ccls.setup {}
