require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "cmd enter command mode" })
map("i", "jk", "<esc>")

-- Add mapping for Telescope file finder
map("n", "<leader>pf", ":Telescope find_files<CR>", { desc = "Telescope file finder" })
map("n", "<leader>pw", ":Telescope live_grep<CR>", { desc = "Telescope find word" })
map("n", "<leader>pd", ":Telescope diagnostics<CR>", { desc = "Telescope find diagnostics" })

-- Add mapping for NvimTree full screen
map("n", "<leader>pv", ":NvimTreeToggle<CR>", { desc = "NvimTree full screen" })

-- Add mapping for LSP Code Actions
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "LSP Code Actions" })
