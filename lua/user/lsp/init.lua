local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "user.lsp.mason"
require("user.lsp.handlers").setup()
require "user.lsp.null-ls"

-- TODO: deduplicate from lsp/mason
local lsp_defaults = {
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  on_attach = require("user.lsp.handlers").on_attach,
}


-- TODO: this should be an array / list to allow for more projects
local gams_product = "/home/xhub/gamsdist/products"
lspconfig.ccls.setup {
  init_options = {
    cache = {
      directory = ".ccls-cache";
    };
  },

   on_new_config = function(config, root_dir)
      -- Check if the root_dir matches the specific project path
      if not root_dir:match(gams_product) then
         -- Disable the LSP server for other projects
         config.enabled = false
      end
   end,
}

lspconfig.clangd.setup({
   on_attach = lsp_defaults.on_attach,
   on_new_config = function(config, root_dir)
      -- Check if the root_dir matches the specific project path
      if root_dir:match(gams_product) then
         -- Disable clangd as we use ccls
         config.enabled = false
      end
   end,
})

local current_signature = function(width)
  if not packer_plugins["lsp_signature.nvim"] or packer_plugins["lsp_signature.nvim"].loaded == false then
    return ""
  end
  local sig = require("lsp_signature").status_line(width)
  return sig.label .. "🐼" .. sig.hint
end

vim.lsp.set_log_level("ERROR")
-- Need some work, very distracting
-- require "lsp_signature".setup({})
