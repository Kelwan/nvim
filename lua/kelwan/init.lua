require("kelwan.remap")

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.clipboard = "unnamedplus"
vim.opt.relativenumber = true

vim.opt.title = true

local _, _, wslenv_err = vim.uv.os_getenv("WSLENV", 1)
if wslenv_err ~= nil and wslenv_err == "ENOENT" then
	vim.g.wslenv = false
	vim.opt.titlestring = "NeovideWin"
else
	vim.g.wslenv = true
	vim.opt.titlestring = "NeovideLin"
end

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ timeout = 90 })
	end,
})
