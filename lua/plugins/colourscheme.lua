return {
	{
		"navarasu/onedark.nvim",
		priority = 999,
		opts = {
			style = "cool",
		},
		init = function()
			vim.cmd("colorscheme onedark")
		end,
	},
}
