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
					typescript = { stop_after_first = true, "prettierd", "prettier" },
					javascript = { stop_after_first = true, "prettierd", "prettier" },
					typescriptreact = { stop_after_fist = true, "prettierd", "prettier" },
					json = { stop_after_first = true, "prettierd", "prettier" },
				},
			})
		end,
	},
}
