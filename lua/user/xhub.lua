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

-- From https://www.reddit.com/r/neovim/comments/17xbsym/comment/k9nuwol
-- For lines
vim.opt.list = true

vim.opt.listchars = { leadmultispace = "│   ", multispace = "│ ", tab = "│ ", }

-- spell checking
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"

-- TODO: configure ltex
-- local words = {}
-- for word in io.open(vim.fn.stdpath("config") .. "/spell/en.utf-8.add", "r"):lines() do
-- 	table.insert(words, word)
-- end
-- TODO: use this function in the dictionary: https://miikanissi.com/blog/grammar-and-spell-checker-in-nvim/

-- local lspconfig = require("lspconfig")

-- This assumes `ccls` exists on path
-- lspconfig.ccls.setup {}
