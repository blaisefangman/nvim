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
	--{'akinsho/bufferline.nvim'},
	{'nvim-treesitter/nvim-treesitter'},
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
