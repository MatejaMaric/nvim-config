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
-- vim.cmd [[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   augroup end
-- ]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
-- packer.init {
--   display = {
--     open_fn = function()
--       return require("packer.util").float { border = "rounded" }
--     end,
--   },
-- }

-- Install your plugins here
return packer.startup(function(use)

  -- Packer
  use "wbthomason/packer.nvim" -- Have packer manage itself

  -- Colorschemes
  use "ellisonleao/gruvbox.nvim"
  use "Mofiqul/vscode.nvim"

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  -- use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "williamboman/mason.nvim" -- new version of nvim-lsp-installer
  use "williamboman/mason-lspconfig.nvim" -- needed by mason.nvim
  use "neovim/nvim-lspconfig" -- enable LSP
  use { "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" } -- for formatters and linters

  -- Telescope
  use { "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim", "BurntSushi/ripgrep" } }

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }

  -- Autopairs
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter

  use "numToStr/Comment.nvim" -- Easily comment stuff
  use "JoosepAlviste/nvim-ts-context-commentstring"

  use "lewis6991/gitsigns.nvim"

  use { "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" }

  -- `moll/vim-bbye` is not really required, but it gives you a well behaving `Bdelete` (instead of `bdelete`)
  use { "akinsho/bufferline.nvim", tag = "v2.*", requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" } }

  use "lukas-reineke/indent-blankline.nvim"

  use "folke/which-key.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

