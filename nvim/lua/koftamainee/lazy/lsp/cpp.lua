return {
  "p00f/clangd_extensions.nvim",
  event = {
    "BufReadPre *.c",
    "BufNewFile *.c",
    "BufReadPre *.cpp",
    "BufNewFile *.cpp",
    "BufReadPre *.h",
    "BufNewFile *.h",
    "BufReadPre *.hpp",
    "BufNewFile *.hpp",
  },
  config = function()
    require("clangd_extensions").setup {
      ast = {
        role_icons = {},
        kind_icons = {},
      },
      inlay_hints = {
        inline = true,
        only_current_line = false,
        show_parameter_hints = true,
        show_variable_name = true,
        parameter_hints_prefix = "<- ",
        other_hints_prefix = "=> ",
      },
      type_hierarchy = {
        kind_icons = {},
      },
      symbol_info = {
        border = "rounded",
      },
    }
  end,
}
