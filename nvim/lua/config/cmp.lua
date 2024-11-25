-- lua/config/cmp.lua

local cmp = require('cmp')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = {
        -- Navigate completion menu
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, { "i", "s" }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { "i", "s" }),

        -- Confirm selection
        ['<CR>'] = cmp.mapping.confirm({ select = true }),

        -- Scroll through documentation
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-u>'] = cmp.mapping.scroll_docs(4),

        -- Manually trigger completion
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Close completion menu
        ['<C-e>'] = cmp.mapping.close(),
    },

    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
    })
})

-- Integration of autopairs with nvim-cmp
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)
