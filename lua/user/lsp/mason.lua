require('mason').setup()
require('mason-lspconfig').setup()

local lsp_defaults = {
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = require('cmp_nvim_lsp').update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  ),
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

lspconfig.sumneko_lua.setup {
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


