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

local function bzl_override()
	vim.ui.input({}, function(input)
		if not input then
			return
		end
		vim.cmd("!bzl_override " .. input)
	end)
end

vim.keymap.set("n", "gb", bzl_override, { desc = "Bazel local override" })

vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "Open Oil" })
