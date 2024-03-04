local keybindings = require('user.keybindings')

local lazy = {}

function lazy.install(path)
  if not vim.loop.fs_stat(path) then
    print('Installing lazy.nvim....')
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      path,
    })
  end
end

function lazy.setup(plugins)
  if vim.g.plugins_ready then
    return
  end

  -- You can "comment out" the line below after lazy.nvim is installed
  lazy.install(lazy.path)

  vim.opt.rtp:prepend(lazy.path)

  require('lazy').setup(plugins, lazy.opts)
  vim.g.plugins_ready = true
end

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

lazy.setup({
  {'sainnhe/everforest'},
	{'nvim-lualine/lualine.nvim'},
	{'kyazdani42/nvim-web-devicons'},
	{'nvim-treesitter/nvim-treesitter'},
	{'williamboman/mason.nvim'},
	{'williamboman/mason-lspconfig.nvim'},
	{'neovim/nvim-lspconfig'},
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/cmp-nvim-lsp',
			'saadparwaiz1/cmp_luasnip',
			{
				'L3MON4D3/LuaSnip',
				dependencies = { "rafamadriz/friendly-snippets" },
			},
		}
	},
})

require('lualine').setup({
	options = {
		theme = 'everforest'
	}
})

require('nvim-treesitter.configs').setup({
	highlight = {
		enable = true,
	},
	ensure_installed = {
		'c',
		'cpp',
		'python',
		'lua',
		'gdscript',
		'c_sharp',
		'gitignore',
		'gitcommit',
		'gitattributes',
		'git_rebase',
		'git_config',
	},
})

vim.opt.completeopt = {'menu', 'menuone', 'noselect'}


local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  enabled = function()
    -- disable completion in comments
    local context = require 'cmp.config.context'
    -- keep command mode completion enabled when cursor is in a comment
    if vim.api.nvim_get_mode().mode == 'c' then
      return true
    else
      return not context.in_treesitter_capture("comment")
        and not context.in_syntax_group("Comment")
    end
  end,
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = keybindings.cmp_mapping(cmp, luasnip),
	sources = cmp.config.sources({
		{ name = 'path' },
		{ name = 'nvim_lsp' },
		{ name = 'buffer' },
		{ name = 'luasnip' }, -- For luasnip users.
	}),
})

-- Set configuration for specific filetype.
-- cmp.setup.filetype('gitcommit', {
--  sources = cmp.config.sources({
--    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
--  }, {
--    { name = 'buffer' },
--  })
--})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' },
		{ name = 'cmdline' },
	})
})


-- Set up lspconfig.
require('mason').setup({
  ui = {
    icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗"
		}
	}
})

require('mason-lspconfig').setup({
	ensure_installed = { 'lua_ls', 'rust_analyzer', 'clangd', 'pyright' },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig').gdscript.setup {
	capabilities = capabilities
}

require('lspconfig').lua_ls.setup {
	capabilities = capabilities
}

require('lspconfig').clangd.setup {
	capabilities = capabilities
}

require('lspconfig').pyright.setup {
	capabilities = capabilities
}

require('lspconfig').rust_analyzer.setup {
	capabilities = capabilities
}

require("luasnip.loaders.from_vscode").lazy_load()

local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = '✘'})
sign({name = 'DiagnosticSignWarn', text = ''})
sign({name = 'DiagnosticSignHint', text = ''})
sign({name = 'DiagnosticSignInfo', text = ''})
