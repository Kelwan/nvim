return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		defaults = {
			path_display = {
				"truncate",
				"filename_first",
			},
		},
	},
}
