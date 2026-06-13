-- Additional keymaps that depend on plugins
local keymap = vim.keymap.set

-- Grep mappings (requires yegappan/grep plugin)
keymap("v", "<Leader>g", '"hy:Grep <C-r>h')
keymap("n", "<Leader>g", '"hyiw:Grep <C-r>h')

-- Subvert mappings (requires tpope/vim-abolish plugin)
keymap("v", "<Leader>s", '"hy:%Subvert/<C-r>h//gc<left><left><left>')
keymap("n", "<Leader>s", '"hyiw:%Subvert/<C-r>h//gc<left><left><left>')
