return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "stevearc/conform.nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/nvim-cmp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim",
      "b0o/schemastore.nvim",
      "j-hui/fidget.nvim",
    },

    config = function()
      local cmp = require "cmp"
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("fidget").setup {}
      require("mason").setup {}

      require("mason-lspconfig").setup {
        ensure_installed = {
          "lua_ls",
          "clangd",
          "gopls",
          "pyright",
          "bashls",
          "texlab",
          "dockerls",
          "neocmake",
          "jsonls",
          "yamlls",
          "taplo",
          "buf_ls",
          "elixirls",
          "zls",
        },
      }

      vim.lsp.config("*", { capabilities = capabilities })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
          },
        },
      })

      vim.lsp.config("clangd", {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
        },
      })

      vim.lsp.config("buf_ls", {
        cmd = { "buf", "lsp", "serve", "--log-format=text" },
        filetypes = { "proto", "buf-config" },
        root_markers = { "buf.yaml", ".git" },
      })

      vim.lsp.config("elixirls", {
        filetypes = { "elixir", "eelixir", "heex" },
        settings = {
          elixirLS = {
            dialyzerEnabled = false,
            enableTestLenses = false,
          },
        },
      })

      local schemastore_ok, schemastore = pcall(require, "schemastore")
      local yamlls_settings = {
        yaml = {
          schemaStore = {
            enable = not schemastore_ok,
            url = "https://www.schemastore.org/api/json/catalog.json",
          },
          schemas = {},
        },
      }
      if schemastore_ok then
        yamlls_settings.yaml.schemas = schemastore.yaml.schemas()
      end
      vim.lsp.config("yamlls", { settings = yamlls_settings })

      vim.lsp.config("taplo", {
        cmd = { "taplo", "lsp", "stdio" },
        filetypes = { "toml" },
        single_file_support = true,
        settings = {
          evenBetterToml = {
            schema = {
              enabled = true,
            },
          },
        },
      })

      vim.lsp.enable {
        "lua_ls",
        "clangd",
        "gopls",
        "pyright",
        "bashls",
        "texlab",
        "dockerls",
        "neocmake",
        "jsonls",
        "yamlls",
        "taplo",
        "buf_ls",
        "elixirls",
        "ocamllsp",
      }

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
      end

      cmp.setup {
        enabled = function()
          if vim.bo.buftype == "prompt" then
            return false
          end
          local context = require "cmp.config.context"
          return not context.in_treesitter_capture "string" and not context.in_syntax_group "String"
        end,
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = vim.tbl_extend("force", cmp.config.window.bordered(), {
            border = "rounded",
            scrollbar = false,
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel",
          }),
          documentation = vim.tbl_extend("force", cmp.config.window.bordered(), {
            border = "rounded",
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
          }),
        },
        formatting = {
          format = require("lspkind").cmp_format {
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
          },
        },
        mapping = cmp.mapping.preset.insert {
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<CR>"] = cmp.mapping.confirm { select = true },
          ["<C-Space>"] = cmp.mapping.complete(),
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp", group_index = 1 },
          { name = "crates", group_index = 1 },
          { name = "luasnip", group_index = 1 },
        }, {
          { name = "buffer", group_index = 2 },
        }),
      }

      vim.diagnostic.config {
        -- i fint it kinda annoing to see long lines of rust-analyzer diagnostics
        -- in my code
        -- virtual_text = false,
        -- fuck it i changed my mind
        virtual_text = {
          prefix = " ",
          spacing = 4,
        },
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          header = "",
          prefix = "",
        },
        signs = true,
      }
    end,
  },
  require "koftamainee.lazy.lsp.rust",
  require "koftamainee.lazy.lsp.crates",
  require "koftamainee.lazy.lsp.haskell",
  require "koftamainee.lazy.lsp.slang",
  require "koftamainee.lazy.lsp.cpp",
  require "koftamainee.lazy.lsp.go",
  require "koftamainee.lazy.lsp.ocaml",
}
