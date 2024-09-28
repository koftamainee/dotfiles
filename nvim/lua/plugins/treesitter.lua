return {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",  -- Automatically install/update parsers
        config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = "all",  -- Or a list of languages you want
                sync_install = false,
                highlight = {
                    enable = true,            -- Enable highlighting
                    additional_vim_regex_highlighting = false,
                },
                indent = {
                    enable = true,            -- Enable indentation
                },
            }
        end,
}
