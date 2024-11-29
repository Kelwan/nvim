return {
	{
		"stevearc/oil.nvim",
		opts = {
			default_file_explorer = true,
		},
		lazy = false,
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
