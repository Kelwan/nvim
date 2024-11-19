local lsp_setup_handlers = {
	function(server_name)
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
		})
	end,
	["clangd"] = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		require("lspconfig").clangd.setup({
			capabilities = capabilities,
			filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
		})
	end,
}

return {
	{
		"williamboman/mason.nvim",
		opts = {},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				automatic_installation = true,
				ensure_installed = {
					"lua_ls",
				},
			})
			lsp_setup_handlers[1]("starpls")
			require("mason-lspconfig").setup_handlers(lsp_setup_handlers)
			require("lspconfig").nushell.setup({})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("lspconfig").clangd.setup({})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = { "hrsh7th/cmp-nvim-lsp" },
		config = function()
			local cmp = require("cmp")
			local cmp_kinds = {
				Text = "  ",
				Method = "  ",
				Function = "  ",
				Constructor = "  ",
				Field = "  ",
				Variable = "  ",
				Class = "  ",
				Interface = "  ",
				Module = "  ",
				Property = "  ",
				Unit = "  ",
				Value = "  ",
				Enum = "  ",
				Keyword = "  ",
				Snippet = "  ",
				Color = "  ",
				File = "  ",
				Reference = "  ",
				Folder = "  ",
				EnumMember = "  ",
				Constant = "  ",
				Struct = "  ",
				Event = "  ",
				Operator = "  ",
				TypeParameter = "  ",
			}
			cmp.setup({
				---@diagnostic disable-next-line: missing-fields
				formatting = {
					format = function(_, vim_item)
						---@diagnostic disable-next-line: return-type-mismatch
						if vim_item == nil then
							return vim_item
						end
						vim_item.kind = (cmp_kinds[vim_item.kind] or "") .. vim_item.kind
						return vim_item
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<Right>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping.confirm({ select = true }),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{
						name = "lazydev",
						group_index = 0, -- set group index to 0 to skip loading LuaLS completions
					},
				}),
				experimental = {
					ghost_text = true,
				},
			})
		end,
	},
}
