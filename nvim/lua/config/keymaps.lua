-- Additional keymaps that depend on plugins
local keymap = vim.keymap.set

-- Grep mappings (Telescope live_grep on word under cursor / selection)
keymap("n", "<Leader>g", function()
  require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })
end, { silent = true })
keymap("v", "<Leader>g", '"hy:Telescope grep_string search=<C-r>h<CR>')

-- Subvert mappings (requires tpope/vim-abolish plugin)
keymap("v", "<Leader>s", '"hy:%Subvert/<C-r>h//gc<left><left><left>')
keymap("n", "<Leader>s", '"hyiw:%Subvert/<C-r>h//gc<left><left><left>')
