return {
    {
        "junegunn/goyo.vim",
        event = "VeryLazy",
        config = function()
            -- You can add any specific Goyo configuration here if needed
            vim.cmd([[
                " Example configuration for Goyo
                " Auto-enable Goyo for markdown files
                autocmd FileType markdown Goyo
                " Customize Goyo appearance
                let g:goyo_width = 90
                let g:goyo_height = 90
            ]])
        end,
    },
}
