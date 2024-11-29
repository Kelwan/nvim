return {
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				format_on_save = {
					lsp_format = "fallback",
					timeout_ms = 500,
				},

				formatters_by_ft = {
					lua = { "stylua" },
					bzl = { "buildifier" },
					starlark = { "buildifier" },
					typescript = { { "prettierd", "prettierd" } },
					javascript = { { "prettierd", "prettierd" } },
					typescriptreact = { { "prettierd", "prettierd" } },
				},
			})
		end,
	},
}
