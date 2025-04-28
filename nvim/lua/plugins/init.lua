return {
  {
    "vyfor/cord.nvim",
    lazy = false,
    build = ":Cord update",
    -- opts = {}
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    lazy = false, -- This plugin is already lazy
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "kyazdani42/nvim-tree.lua",
    opts = {
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
      view = {
        -- width = vim.o.columns, -- Set width to full screen
        side = "left", -- You can also set "right" if preferred
        number = true, -- Optional: Disable line numbers
        relativenumber = true, -- Optional: Disable relative numbers
      },
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  -- Добавляем конфигурацию для Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "cpp", "c", "python", "lua", "bash", "rust", "go", "javascript", "typescript" }, -- Здесь можно добавить все языки
        highlight = {
          enable = true, -- Включаем подсветку синтаксиса
          disable = {}, -- Список языков, которые не будут использовать Treesitter
        },
        indent = {
          enable = true, -- Включаем автоотступы с помощью Treesitter
          disable = { "cpp" }, -- Язык C++ отключен от индентации для Treesitter (если нужно)
        },
        autotag = {
          enable = true, -- Включаем автоматическое закрытие тегов в HTML/XML
        },
      }

      -- Регистрируем расширение для .tpp файлов
      vim.filetype.add {
        extension = {
          tpp = "cpp", -- Ожидаем, что .tpp файлы будут распознаваться как C++
        },
      }
    end,
  },
}
