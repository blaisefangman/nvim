require('user.plugins')

vim.opt.mouse = 'a'
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false
vim.opt.clipboard = "unnamedplus"

-- Disabling italic comments because Windows Terminal can't handle italics right now
vim.g.everforest_disable_italic_comment = 1
vim.cmd.colorscheme('everforest')

-- Tried unsuccessfully to get true and false to be italicized
--
-- vim.api.nvim_set_hl(0, "@boolean", { italic = true })
-- settings = vim.api.nvim_get_hl(0, { name = "@boolean" })
-- settings.italic = true
-- vim.api.nvim_set_hl(0, "@boolean", settings)

-- Set font for Neovim QT
-- Font for Neovim.exe is the Terminal Default
vim.opt.guifont = "CommitMono Nerd Font:h12"
