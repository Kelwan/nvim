local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Telescope find git files" })
vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>ff", function()
	require("kelwan.telescope-config").project_files()
end, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>ft", builtin.lsp_dynamic_workspace_symbols, { desc = "Telescope dyn workspace symbols" })

vim.keymap.set("n", "<leader>ss", builtin.lsp_document_symbols, { desc = "Telescope buffer symbols" })
vim.keymap.set("n", "grr", builtin.lsp_references, { desc = "Telescope LSP references" })

vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Telescope git commits" })
vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Telescope git branches" })
vim.keymap.set({ "n" }, "gd", "<cmd>Telescope lsp_definitions<cr>", { desc = "Goto Definition" })
