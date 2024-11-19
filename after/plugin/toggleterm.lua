vim.keymap.set({ "n", "i", "t" }, "<C-/>", function()
	vim.cmd(":ToggleTerm size=20 dir=gitdir direction=horizontal")
end, { desc = "ToggleTerm open console" })
