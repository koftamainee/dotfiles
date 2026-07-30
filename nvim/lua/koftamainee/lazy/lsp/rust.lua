vim.g.rustaceanvim = {
  tools = {
    test_executor = "background",
    float_win_config = {
      auto_focus = true,
    },
  },
  server = {
    default_settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
          buildScripts = {
            enable = true,
          },
        },
        checkOnSave = true,
        procMacro = {
          enable = true,
        },
        check = {
          command = "clippy",
        },
        inlayHints = {
          bindingModeHints = { enable = true },
          closureCaptureHints = { enable = true },
          closureReturnTypeHints = { enable = "always" },
          discriminantHints = { enable = "always" },
          expressionAdjustmentHints = { enable = "always" },
          implicitDrops = { enable = true },
          lifetimeElisionHints = { enable = "always" },
          namedArguments = { enable = "always" },
          reborrowHints = { enable = "always" },
          typeHints = { enable = true },
          chainingHints = { enable = true },
          parameterHints = { enable = true },
        },
        imports = {
          granularity = {
            group = "module",
          },
          prefix = "self",
        },
        rustfmt = {
          extraArgs = { "+nightly" },
        },
      },
    },
  },
}

return {
  "mrcjkb/rustaceanvim",
  version = "^9",
  lazy = false,
}
