return {
	{
		'EdenEast/nightfox.nvim'
	},

	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' },
	},

	{
		'nvim-treesitter/nvim-treesitter',
		opts = {
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline"
			},

			sync_install = false,
			auto_install = true,

			highlight = {
				enable = true,
			},

			indent = {
				enable = true,
			}
		},

		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		    	"hrsh7th/cmp-buffer",
		    	"hrsh7th/cmp-path",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip",
		},
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
				      	['<C-f>'] = cmp.mapping.scroll_docs(4),
				      	['<C-Space>'] = cmp.mapping.complete(),
				      	['<C-e>'] = cmp.mapping.abort(),
				      	['<CR>'] = cmp.mapping.confirm({ select = true }),
				    }),
				sources = cmp.config.sources({
					{ name = "nvim_lsp"},
					{ name = "vsnip"},
				}, {
					{ name = "buffer" },
				})
			})
		end

	},

	{
		'neovim/nvim-lspconfig',
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			require("lspconfig").clangd.setup({
				capabilities = capabilities
			})
			require("lspconfig").ts_ls.setup({
				capabilities = capabilities
			})
			require("lspconfig").tsp_server.setup({
				capabilities = capabilities
			})
			require("lspconfig").eslint.setup({
				capabilities = capabilities
			})
			require("lspconfig").kotlin_language_server.setup({
				capabilities = capabilities
			})
			require("lspconfig").lua_ls.setup({
				capabilities = capabilities,
				on_init = function(client)
					if client.workspace_folders then
						local path = client.workspace_folders[1].name
						if path ~= vim.fn.stdpath("config") and (vim.loop.fs_stat(path.."/.luarc.json") or vim.loop.fs_stat(path.."/.luarc.jsonc")) then
							return
						end
					end
					client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
						runtime = { version = "LuaJIT" },
						workspace = {
							checkThirdParty = false,
							library = { vim.env.VIMRUNTIME }
						},
					})
				end,
				settings = {
					Lua = {},
				}
			})
		end
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			close_if_last_window = true,
			filesystem = {
				follow_current_file = {
					enabled = true,
					leave_dirs_open = true,
				},
			},
		},
	},

    {
        "kdheepak/lazygit.nvim",
        dependencies = {
			"nvim-lua/plenary.nvim",
        },
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
    },
}
