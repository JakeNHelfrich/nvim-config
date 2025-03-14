vim.keymap.set("n", "<leader>ll", "<cmd>Lazy<CR>")
vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<CR>")

local neotree = require("neo-tree.command")
vim.keymap.set("n", "<leader>ee", function()
	neotree.execute({
		action = "show",
		source = "filesystem",
		position = "left",
		toggle = true,
	})
end)
vim.keymap.set("n", "<leader>ef", function()
	neotree.execute({
		action = "focus",
		source = "filesystem",
		position = "left",
	})
end)

local telescope = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", telescope.find_files)
vim.keymap.set("n", "<leader>fb", telescope.current_buffer_fuzzy_find)
vim.keymap.set("n", "<leader>fs", telescope.lsp_dynamic_workspace_symbols)
vim.keymap.set("n", "<leader>ft", telescope.treesitter)
vim.keymap.set("n", "<leader>fg", telescope.live_grep)

vim.keymap.set("n", "gd", telescope.lsp_definitions)
vim.keymap.set("n", "gi", telescope.lsp_implementations)
vim.keymap.set("n", "gr", telescope.lsp_references)

