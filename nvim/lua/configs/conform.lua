local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    c = { "clang_format" },
    cpp = { "clang_format" },
    python = { "black" },
    go = { "gofmt" },
    rust = { "rustfmt" },
    bash = { "beautysh" },
    tex = { "latexindent" },
    cmake = { "cmake_format" },
    sql = { "sql_formatter" },
    haskell = { "ormolu" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
