return {
    'rust-lang/rust.vim',
    ft = 'rust', -- Load the plugin only for Rust files
    config = function()
        -- Enable automatic formatting with rustfmt
        vim.g.rustfmt_autosave = 1

        -- Configure rust.vim-specific options
        vim.g.rust_clip_command = 'wl-clipboard -selection clipboard'
        vim.g.rust_recommended_style = 1
    end
}
