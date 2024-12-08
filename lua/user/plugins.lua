local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use { "nvim-tree/nvim-tree.lua", requires = { "nvim-tree/nvim-web-devicons" }}
  use { "akinsho/bufferline.nvim", branch = "main" }
  use "moll/vim-bbye"
  use "nvim-lualine/lualine.nvim"
  use { "akinsho/toggleterm.nvim", branch = "main" }
  use "ahmedkhalf/project.nvim"
  use "lewis6991/impatient.nvim"
  use "goolord/alpha-nvim"
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  use "folke/which-key.nvim"

  -- Colorschemes
  -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  use "lunarvim/darkplus.nvim"

  -- cmp plugins
  use({
    "hrsh7th/nvim-cmp",  -- The completion plugin
    requires = {
      { "kdheepak/cmp-latex-symbols" }, -- for latex symbols
    },
    sources = {
      { name = "latex_symbols" },
    },
  })
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/mason.nvim" -- simple to use language server installer
  use "williamboman/mason-lspconfig.nvim" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "nvimtools/none-ls.nvim" -- for formatters and linters

  -- Telescope
  use "nvim-telescope/telescope.nvim"

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "hiphish/rainbow-delimiters.nvim" -- rainbow parentheses

  -- Git
  use "lewis6991/gitsigns.nvim"


  -- CUSTOM 
  use {
      "brymer-meneses/grammar-guard.nvim",
      requires = {
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim"
      }
    }
  use "ray-x/lsp_signature.nvim"
   use {
      "rmagatti/goto-preview",
      config = function()
         require('goto-preview').setup {}
      end
   }

  -- for latex
  use "frabjous/knap"
  use "lervag/vimtex"
  use "evesdropper/luasnip-latex-snippets.nvim"

  -- for comments
  use {
    "danymat/neogen",
    config = function()
        require('neogen').setup {}
    end,
    requires = "nvim-treesitter/nvim-treesitter",
    -- Uncomment next line if you want to follow only stable versions
    -- tag = "*"
  }

  -- more snipppets
  use "honza/vim-snippets"
  -- surround-like plugin
  use { "nvim-treesitter/nvim-treesitter-textobjects",
        requires = { "nvim-treesitter/nvim-treesitter" } }

  -- Subsitution
   use "tpope/vim-abolish"

  -- vimwiki
  use "vimwiki/vimwiki"
  use "ElPiloto/telescope-vimwiki.nvim"

  -- diff plugins
  use "will133/vim-dirdiff"
  use { 'sindrets/diffview.nvim',
    requires = 'nvim-lua/plenary.nvim' }

   -- telescope extensions
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }


   use { 'naegelejd/vim-swig' } -- Support more filetypes

   use { 'VonHeikemen/fine-cmdline.nvim', requires = { {'MunifTanjim/nui.nvim'} } } -- For nice floating cmdline

   use { 'milanglacier/yarepl.nvim' }

   -- DAP
   use { "mfussenegger/nvim-dap",
      requires = {
         "rcarriga/nvim-dap-ui",
         "theHamsta/nvim-dap-virtual-text",
         "nvim-neotest/nvim-nio",
         'nvim-telescope/telescope-dap.nvim',
         "williamboman/mason.nvim",
      }
   }

   -- For nice notification
   use 'rcarriga/nvim-notify'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
