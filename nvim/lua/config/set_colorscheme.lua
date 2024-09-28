function ColorMyPencils(color)
	color = "tokyonight"
	vim.g.tokyonight_style = "night"
	vim.g.tokyonight_transparent = true
	vim.g.tokyonight_terminal_colors = true
	vim.g.tokyonight_italic_comments = true
	vim.g.tokyonight_italic_keywords = true
	vim.g.tokyonight_dim_inactive = true
	vim.cmd.colorscheme(color)
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end
ColorMyPencils()