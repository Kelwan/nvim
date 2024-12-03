vim.keymap.set({ "n", "i", "t" }, "<C-/>", function()
	vim.cmd(":ToggleTerm size=50 dir=gitdir direction=vertical")
end, { desc = "ToggleTerm open console" })
