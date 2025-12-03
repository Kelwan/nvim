return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 999,
		opts = {
			style = "moon",
		},
		init = function()
			vim.cmd("colorscheme tokyonight")
		end,
	},
}
