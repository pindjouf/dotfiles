return {
    'rust-lang/rust.vim',
    ft = 'rust',
    config = function()
        vim.g.rustfmt_autosave = 1

        vim.g.rust_clip_command = 'wl-clipboard -selection clipboard'
        vim.g.rust_recommended_style = 1
    end
}
