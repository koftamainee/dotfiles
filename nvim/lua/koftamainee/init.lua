require "koftamainee.set"
require "koftamainee.remap"
require "koftamainee.lazy_init"

local augroup = vim.api.nvim_create_augroup
local koftamainee_group = augroup("koftamainee", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

function R(name)
  require("plenary.reload").reload_module(name)
end

autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.hl.on_yank {
      higroup = "IncSearch",
      timeout = 40,
    }
  end,
})

autocmd("LspAttach", {
  group = koftamainee_group,
  callback = function(e)
    local opts = { buffer = e.buf }
    local float_opts = { border = "rounded", winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder" }

    vim.lsp.inlay_hint.enable(true)

    vim.keymap.set("n", "gd", function()
      vim.lsp.buf.definition()
    end, vim.tbl_extend("force", opts, { desc = "Go to definition" }))

    vim.keymap.set("n", "gt", function()
      vim.lsp.buf.type_definition()
    end, vim.tbl_extend("force", opts, { desc = "Go to type definition" }))

    vim.keymap.set("n", "gI", function()
      vim.lsp.buf.implementation()
    end, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))

    vim.keymap.set("n", "<leader>th", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, vim.tbl_extend("force", opts, { desc = "Toggle inlay hints" }))

    vim.keymap.set("n", "K", function()
      if vim.bo[e.buf].filetype == "rust" then
        vim.cmd.RustLsp { "hover", "actions" }
      else
        vim.lsp.buf.hover(float_opts)
      end
    end, vim.tbl_extend("force", opts, { desc = "Hover" }))

    vim.keymap.set("n", "<leader>vws", function()
      vim.lsp.buf.workspace_symbol()
    end, vim.tbl_extend("force", opts, { desc = "Workspace symbols" }))

    vim.keymap.set("n", "<leader>vd", function()
      vim.diagnostic.open_float()
    end, vim.tbl_extend("force", opts, { desc = "Open diagnostic" }))

    vim.keymap.set("n", "<leader>vca", function()
      vim.lsp.buf.code_action()
    end, vim.tbl_extend("force", opts, { desc = "Code action" }))

    vim.keymap.set("n", "<leader>vrr", function()
      vim.lsp.buf.references()
    end, vim.tbl_extend("force", opts, { desc = "References" }))

    vim.keymap.set("n", "<leader>vrn", function()
      vim.lsp.buf.rename()
    end, vim.tbl_extend("force", opts, { desc = "Rename" }))

    vim.keymap.set("i", "<C-h>", function()
      vim.lsp.buf.signature_help(float_opts)
    end, vim.tbl_extend("force", opts, { desc = "Signature help" }))

    vim.keymap.set("n", "[d", function()
      vim.diagnostic.jump {
        count = 1,
        on_jump = function()
          vim.diagnostic.open_float { source = true }
        end,
      }
    end, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
    vim.keymap.set("n", "]d", function()
      vim.diagnostic.jump {
        count = -1,
        on_jump = function()
          vim.diagnostic.open_float { source = true }
        end,
      }
    end, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
  end,
})
