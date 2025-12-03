return {
	"lewis6991/gitsigns.nvim",
	lazy = false,
	opts = {
		current_line_blame = true,
		current_line_blame_opts = {
			delayed = 0,
		},
	},
	keys = {
		{ "<leader>hs", "<cmd>Gitsigns stage_hunk<cr>", { desc = "Gitsigns stage hunk" } },
		{ "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Gitsigns reset hunk" } },
		{ "]h", "<cmd>Gitsigns next_hunk<cr>", desc = "Next Git Hunk" },
		{ "[h", "<cmd>Gitsigns prev_hunk<cr>", desc = "Previous Git Hunk" },
	},
}
