function ColorMyPencils(color)
  color = color or "tokyodark"
  vim.cmd.colorscheme(color)

  local pal = require "tokyodark.palette"
  local fg = pal.fg

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { fg = fg, bg = pal.bg1 })
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = fg, bg = pal.bg1 })
  vim.api.nvim_set_hl(0, "Pmenu", { fg = fg, bg = pal.bg2 })
  vim.api.nvim_set_hl(0, "PmenuSel", { fg = fg, bg = pal.bg3 })
  vim.api.nvim_set_hl(0, "CmpDocumentation", { fg = fg, bg = pal.bg2 })
  vim.api.nvim_set_hl(0, "CmpDocumentationBorder", { fg = fg, bg = pal.bg2 })
  vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { fg = fg, bg = pal.bg3, bold = true })

  vim.api.nvim_set_hl(0, "CmpItemAbbr", { fg = fg })
  vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = pal.bg4, strikethrough = true })
  vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = pal.grey, italic = true })
  vim.api.nvim_set_hl(0, "CmpItemKind", { fg = pal.blue })
  vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = pal.purple })
  vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = pal.purple })
  vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = pal.cyan })
  vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = pal.cyan })
  vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = pal.blue })
  vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = pal.yellow })
  vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = pal.yellow })
  vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = pal.blue })
  vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = pal.cyan })
  vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = pal.yellow })
  vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = pal.green })
  vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = pal.red })
  vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = fg })
  vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = pal.yellow })
  vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = pal.blue })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    ColorMyPencils()
  end,
})

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
