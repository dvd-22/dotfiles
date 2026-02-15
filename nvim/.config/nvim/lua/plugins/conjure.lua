return {
    "Olical/conjure",
    ft = { "clojure", "fennel", "python", "lua", "racket" }, -- Filetypes to enable
    lazy = true,
    init = function()
        -- Map the prefix to a key of your choice (default is <localleader>)
        -- Example: vim.g["conjure#mapping#prefix"] = ","

        -- Disable specific features if they conflict with other plugins
        -- Example: vim.g["conjure#mapping#doc_word"] = false
    end,
}
