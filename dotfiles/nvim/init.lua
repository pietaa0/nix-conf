vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " "

require("nvim-treesitter").setup()

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

require("tokyonight").setup({
	style = "night",
	transparent = true,
	terminal_colors = true,
	dim_inactive = true,

	styles = {
		comments = { italic = true },
		keywords = { italic = false },
		functions = { bold = false },
		variables = {},
	},
})

vim.cmd("colorscheme tokyonight")

local capabilities = require("cmp_nvim_lsp").default_capabilities()
vim.lsp.config("*", {
	capabilities = capabilities,
})

vim.lsp.config("rust_analyzer", {
	settings = {
		["rust_analyzer"] = {
			cargo = { allFeatures = true },
			checkOnSave = { command = "clippy" },
		},
	},
})

vim.lsp.enable({ "pyright", "rust_analyzer", "ts_ls", "lua_ls", "nil_ls", "jsonls", "marksman" })

local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
})

require("conform").setup({
	formatters_by_ft = {
		rust = { "rustfmt" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		json = { "prettier" },
		markdown = { "prettier" },
		nix = { "nixpkgs_fmt" },
		lua = { "stylua" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})

local augend = require("dial.augend")
require("dial.config").augends:register_group({
	default = {
		augend.integer.alias.decimal,
		augend.integer.alias.hex,
		augend.date.alias["%Y/%m/%d"],
		augend.constant.alias.bool,
	},
})

require("nvim-autopairs").setup({})
require("gitsigns").setup()
require("oil").setup()
require("render-markdown").setup()
require("mini.ai").setup({
	n_lines = 500,
})
require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()
require("mini.comment").setup()
require("mini.move").setup()
require("mini.surround").setup()

vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files)
vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>d", vim.diagnostic.setloclist)
vim.keymap.set("n", "-", "<CMD>Oil<CR>")
vim.keymap.set("n", "<C-a>", function()
	require("dial.map").manipulate("increment", "normal")
end)
vim.keymap.set("n", "<C-x>", function()
	require("dial.map").manipulate("decrement", "normal")
end)
