return {
	{
		"stevearc/oil.nvim",
		opts = {},
		keys = {
			{
				"<leader>d",
				function()
					require("oil").open(vim.fn.getcwd())
				end,
				{ desc = "Oil open current directory" },
			},
		},
	},
}
