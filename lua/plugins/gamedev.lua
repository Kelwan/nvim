local function is_private_header(filepath)
	local idx = string.find(filepath, "/Private/", 0, true)
	return idx ~= nil
end

local function get_header_include_string(prefixes, filepath)
	for _, prefix in ipairs(prefixes) do
		local _, idx = string.find(filepath, prefix, 0, true)
		if idx ~= nil then
			return string.sub(filepath, idx + 1)
		end
	end

	return filepath
end

local function get_header_module_name(filepath)
	local prefixes = { "/Public/", "/Classes/" }
	for _, prefix in ipairs(prefixes) do
		local idx = string.find(filepath, prefix, 0, true)
		if idx ~= nil then
			local dir = string.sub(filepath, 0, idx - 1)
			local dir_segments = vim.split(dir, "/", { plain = true })
			local module_name = dir_segments[#dir_segments]
			if module_name == "Source" then
				module_name = dir_segments[#dir_segments - 1]
			end
			return module_name
		end
	end

	local filepath_segments = vim.split(filepath, "/", { plain = true })
	return filepath_segments[#filepath_segments - 1]
end

local function telescope_unreal_headers()
	require("uproject").get_project_engine_info(vim.fn.getcwd(), function(info)
		if info == nil then
			vim.notify("cannot find unreal project", vim.log.levels.ERROR)
			return
		end
		local engine_dir = vim.fs.joinpath(info.install_dir, "Engine")
		local source_dir = vim.fs.joinpath(engine_dir, "Source")
		local plugins_dir = vim.fs.joinpath(engine_dir, "Plugins")
		local project_source_dir = vim.fs.joinpath(info.project_dir, "Source")
		local project_plugins_dir = vim.fs.joinpath(info.project_dir, "Plugins")
		local entry_display = require("telescope.pickers.entry_display")
		local finders = require("telescope.finders")
		local make_entry = require("telescope.make_entry")
		local pickers = require("telescope.pickers")
		local sorters = require("telescope.sorters")
		local previewers = require("telescope.previewers")
		local themes = require("telescope.themes")
		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")

		local displayer = entry_display.create({
			separator = " │ ",
			items = {
				{ width = 32 }, -- module name
				{ remaining = true }, -- header path
			},
		})

		--- @param entry {header_info: UnrealHeaderInfo}
		local function entry_display_fn(entry)
			return displayer({
				entry.header_info.module_name,
				entry.header_info.include_string,
			})
		end

		local function custom_entry_maker(filepath)
			filepath = string.gsub(filepath, "\\", "/")

			local entry = make_entry.gen_from_file({})(filepath)
			local private = is_private_header(filepath)
			local module_name = get_header_module_name(filepath)
			local include_string = get_header_include_string({ "/Public/", "/Classes/", "/Source/" }, filepath)
			--- @type UnrealHeaderInfo
			entry.header_info = {
				private = private,
				module_name = module_name,
				include_string = include_string,
			}
			entry.value = filepath
			entry.filename = filepath
			entry.ordinal = module_name .. " " .. include_string
			entry.display = entry_display_fn
			return entry
		end

		local find_command = {
			"fd",
			"--glob",
			"**/*.h",
			"-t",
			"f", -- files only
			"-E",
			"*.generated.h",
			"-E",
			"**/Thirdparty/*",
			"-E",
			"**/ThirdParty/*",
			"-E",
			"**/Binaries/*",
			"-E",
			"**/Private/*",
			"-E",
			"**/Internal/*",
			"-E",
			"**/Intermediate/*",
			"--search-path",
			source_dir,
			"--search-path",
			plugins_dir,
			"--search-path",
			project_source_dir,
			"--search-path",
			project_plugins_dir,
		}

		table.insert(find_command, "--")

		pickers
			.new(themes.get_ivy({}), {
				prompt_title = "Unreal Headers",
				finder = finders.new_oneshot_job(find_command, {
					entry_maker = custom_entry_maker,
					cwd = info.project_dir,
				}),
				previewer = previewers.vim_buffer_cat.new({}),
				sorter = sorters.get_fuzzy_file(),
				attach_mappings = function(prompt_bufnr, map)
					map("i", "<C-y>", function()
						--- @type {filename: string, header_info: UnrealHeaderInfo}
						local entry = action_state.get_selected_entry()
						vim.fn.setreg("m", entry.header_info.module_name)
						vim.fn.setreg("f", entry.filename)
						vim.fn.setreg("i", '#include "' .. entry.header_info.include_string .. '"\n')
						actions.close(prompt_bufnr)
					end)

					return true
				end,
			})
			:find()
	end)
end
return {
	{
		"zaucy/uproject.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"j-hui/fidget.nvim",
		},
		cmd = { "Uproject" },
		lazy = false,
		opts = {},
		keys = {
			{
				"<leader>uo",
				"<cmd>Uproject open<cr>",
				desc = "Open Unreal Editor",
			},
			{
				"<leader>uO",
				"<cmd>Uproject build open hide_output type_pattern=Editor wait<cr>",
				desc = "Build and Open",
			},
			{
				"<leader>ur",
				"<cmd>Uproject reload show_output<cr>",
				desc = "Reload Uproject",
			},
			{
				"<leader>up",
				"<cmd>Uproject play log_cmds=Log\\ Log<cr>",
				desc = "Play Game",
			},
			{
				"<leader>uP",
				"<cmd>Uproject play debug log_cmds=Log\\ Log<cr>",
				desc = "Play Game (debug)",
			},
			{
				"<leader>uB",
				"<cmd>Uproject build ignore_junk close_output_on_success type_pattern=Editor wait<cr>",
				desc = "Build",
			},
			{
				"<leader>ub",
				"<cmd>Uproject build type_pattern=Editor wait ignore_junk hide_output<cr>",
				desc = "Quick Build",
			},
			{
				"<leader>uu",
				"<cmd>Uproject show_output<cr>",
				desc = "Show Build Output",
			},
			{
				"<leader>uc",
				"<cmd>Uproject build_plugins type_pattern=Editor wait<cr>",
				desc = "Build Plugins",
			},
			{
				"<leader>uh",
				function()
					telescope_unreal_headers()
				end,
				desc = "Find unreal headers",
			},
			{
				"<leader>ut",
				function()
					local util = require("uproject.util")
					local filepath = vim.api.nvim_buf_get_name(0)
					if util.is_header_path(filepath) then
						local source_path = util.get_source_from_header(filepath)
						if source_path then
							vim.cmd.edit(source_path)
						end
					elseif util.is_source_path(filepath) then
						local header_path = util.get_header_from_source(filepath)
						if header_path then
							vim.cmd.edit(header_path)
						end
					end
				end,
				desc = "Toggle header/source",
			},
		},
	},
	{
		"https://github.com/ngemily/vim-vp4",
	},
}
