local function treesitter_config()
	local parsers = require("nvim-treesitter.parsers").get_parser_configs()
	---@diagnostic disable-next-line: inject-field
	parsers.nu = {
		install_info = {
			url = "https://github.com/nushell/tree-sitter-nu.git",
			files = { "src/parser.c" },
			branch = "main",
			requires_generate_from_grammar = false,
		},
	}
	---@diagnostic disable-next-line: inject-field
	parsers.bazelrc = {
		install_info = {
			url = "https://github.com/zaucy/tree-sitter-bazelrc.git",
			files = { "src/parser.c" },
			branch = "main",
			requires_generate_from_grammar = false,
		},
	}
	---@diagnostic disable-next-line: inject-field
	parsers.ecsact = {
		install_info = {
			url = "https://github.com/ecsact-dev/tree-sitter-ecsact.git",
			files = { "src/parser.c" },
			branch = "main",
			generate_requires_npm = false,
			requires_generate_from_grammar = false,
		},
	}
	require("nvim-treesitter.configs").setup({
		ensure_installed = { "c", "cpp", "c_sharp", "lua" },
		sync_install = false,
		auto_install = true,
		highlight = {
			enable = true,
		},
	})
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
		config = treesitter_config,
	},
}
