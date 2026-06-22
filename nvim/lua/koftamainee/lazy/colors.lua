function ColorMyPencils(color)
	color = color or "tokyodark"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
	{
		"tiagovla/tokyodark.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			transparent_background = true,
			gamma = 1.00,
			styles = {
				comments = { italic = true },
				keywords = { italic = true },
				identifiers = { italic = true },
				functions = {},
				variables = {},
			},
			terminal_colors = true,
		},
		config = function(_, opts)
			require("tokyodark").setup(opts)
			ColorMyPencils()
		end,
	},
}
