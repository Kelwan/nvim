vim.g.mapleader = " "

vim.keymap.set({ "t", "i", "v" }, "<C-n>", "<C-\\><C-n>")
vim.keymap.set("n", "<leader>t", function()
	vim.cmd("vsplit")
end, { desc = "Vsplit tab" })

vim.keymap.set("n", "<leader>fc", function()
	require("telescope.builtin").find_files({
		cwd = vim.fn.stdpath("config"),
		prompt_title = "config",
	})
end, { desc = "Telescope Config" })
