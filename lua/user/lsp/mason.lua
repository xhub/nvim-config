require('mason').setup()
require('mason-lspconfig').setup()

local lsp_defaults = {
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  on_attach = require("user.lsp.handlers").on_attach,
}

local lspconfig = require('lspconfig')

-- inject everything
lspconfig.util.default_config = vim.tbl_deep_extend(
  'force',
  lspconfig.util.default_config,
  lsp_defaults
)

-- START server-specific config

local extended_schemas = require("user.lsp.settings.jsonls")

lspconfig.jsonls.setup {
  on_attach = lsp_defaults.on_attach,
  settings = {
    json = {
      schemas = extended_schemas,
    },
  },
  setup = {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
        end,
      },
    },
  },
}

lspconfig.lua_ls.setup {
  on_attach = lsp_defaults.on_attach,
	settings = {

		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
}

lspconfig.ltex.setup({
  on_attach = lsp_defaults.on_attach,
  settings = {
    { "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex" , "text"},
  }
})

lspconfig.texlab.setup({
  on_attach = lsp_defaults.on_attach,
})

lspconfig.clangd.setup({
  on_attach = lsp_defaults.on_attach,
})

lspconfig.bashls.setup({
  on_attach = lsp_defaults.on_attach,
})

lspconfig.cmake.setup({
  on_attach = lsp_defaults.on_attach,
})

-- From https://github.com/fredrikekre/.dotfiles/blob/master/.config/nvim/init.vim

-- Julia LSP (LanguageServer.jl)
local REVISE_LANGUAGESERVER = false
lspconfig.julials.setup({
--    on_new_config = function(new_config, _)
--        local julia = vim.fn.expand("~/.julia/environments/nvim-lspconfig/bin/julia")
--        if REVISE_LANGUAGESERVER then
--            new_config.cmd[5] = (new_config.cmd[5]):gsub("using LanguageServer", "using Revise; using LanguageServer; if isdefined(LanguageServer, :USE_REVISE); LanguageServer.USE_REVISE[] = true; end")
--        elseif require'lspconfig'.util.path.is_file(julia) then
--            new_config.cmd[1] = julia
--        end
--    end,
    -- This just adds dirname(fname) as a fallback (see nvim-lspconfig#1768).
    root_dir = function(fname)
        local util = require'lspconfig.util'
        return util.root_pattern 'Project.toml'(fname) or util.find_git_ancestor(fname) or
               util.path.dirname(fname)
    end,
    on_attach = function(client, bufnr)
        lsp_defaults.on_attach(client, bufnr)
        -- Disable automatic formatexpr since the LS.jl formatter isn't so nice.
        vim.bo[bufnr].formatexpr = ''
    end,
})


-- Python

lspconfig.pyright.setup({
  on_attach = lsp_defaults.on_attach,
})

