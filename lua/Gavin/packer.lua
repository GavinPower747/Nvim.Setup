local ensure_packer = function()
  local fn = vim.fn
  local install_path =
    fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
      print('Installing packer.nvim plugin...')
    fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path,
    })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()
local status_ok, packer = pcall(require, 'packer')

if not status_ok then
    print('Plugin not loaded (CRUCIAL): ', 'packer')
    print('Automatic installation failed.', 'Follow installation instructions\
    in packer.nvim repo.')
    return
end

packer.startup(function(use)

    use 'wbthomason/packer.nvim' -- Packseption

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    })
    
    -- Treesitter
    use({
            'nvim-treesitter/nvim-treesitter',
            run = function()
                      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
                      ts_update()
                  end,
    })

    use('nvim-treesitter/playground')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')

    -- Completion
    use "hrsh7th/nvim-cmp"                    -- completion plugin
    use "hrsh7th/cmp-buffer"                  -- buffer completions
    use "hrsh7th/cmp-path"                    -- path completions
    use "hrsh7th/cmp-cmdline"                 -- cmdline completions
    use "saadparwaiz1/cmp_luasnip"            -- snippet completions
    use "hrsh7th/cmp-nvim-lua"                -- lua vim completions
    use "hrsh7th/cmp-nvim-lsp"                -- LSP completions
    use "hrsh7th/cmp-nvim-lsp-signature-help" -- function parameters completions

    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'L3MON4D3/LuaSnip'},     -- Required
        }
    }

    use "jose-elias-alvarez/null-ls.nvim"
    use "Hoffs/omnisharp-extended-lsp.nvim"

    -- File Explorer
    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            'DaikyXendo/nvim-material-icon',
            "MunifTanjim/nui.nvim",
        }
    }

    use 'nvim-lualine/lualine.nvim'
    use 'nvim-tree/nvim-web-devicons'
    use 'DaikyXendo/nvim-material-icon'

    use {
        'akinsho/bufferline.nvim',            -- tabline plugin
        tag = "v3.*",
        requires = 'nvim-tree/nvim-web-devicons'
    }

    use 'lukas-reineke/indent-blankline.nvim' -- showing indentation (especially
                                            -- usefull for Python)
    use 'famiu/bufdelete.nvim'

    -- Git
    use 'lewis6991/gitsigns.nvim'             -- Fancy git decorations
    use "sindrets/diffview.nvim"              -- Git diff view

    -- Misc
    use('windwp/nvim-autopairs')
    use { "danymat/neogen", tag = "*" } -- annotations (docstrings and shit)

    use({
        "iamcco/markdown-preview.nvim",       -- markdown preview
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    -- Debuggers
    use "mfussenegger/nvim-dap"

    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
    use 'theHamsta/nvim-dap-virtual-text'
    use 'mfussenegger/nvim-dap-python'
    use 'leoluz/nvim-dap-go'

    if packer_bootstrap then
        require('packer').sync()
    end
end)


