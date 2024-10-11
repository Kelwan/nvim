-- Set guicursor for different modes with colors
vim.opt.guicursor = {
  "n-v-c:block-Cursor", -- Normal, Visual, Command mode: block cursor
  "i-ci:ver25-Cursor", -- Insert, Command-line insert: vertical bar cursor
  "r-cr:hor20-CursorReplace", -- Replace: horizontal underscore cursor
}
-- Define cursor highlights using vim.cmd
vim.cmd([[
  hi Cursor guifg=#5FAFFF guibg=NONE,
  hi CursorInsert guifg=#FF0000 guibg=NONE,
  hi CursorReplace guifg=#FFFF00 guibg=NONE
]])

local uname = vim.uv.os_uname()

vim.o.title = true

if uname.sysname == "Windows_NT" then
  vim.o.titlestring = "NeovideWin"
elseif uname.sysname == "Linux" then
  vim.o.titlestring = "NeovideLin"
end
