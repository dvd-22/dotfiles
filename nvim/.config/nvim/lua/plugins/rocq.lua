return {
    -- 1. Coqtail handles syntax highlighting and filetype mapping
    {
        "whonore/Coqtail",
        ft = "coq",
        init = function()
            -- Prevent Coqtail from conflicting with our LSP keybinds
            vim.g.coqtail_no_mappings = 1

            -- Force .v files to map cleanly to coq filetype
            vim.filetype.add({
                extension = {
                    v = "coq",
                },
            })
        end,
    },

    -- 2. Companion UI Client to display the panels
    {
        "tomtomjhj/vsrocq.nvim",
        dependencies = { "neovim/nvim-lspconfig", "whonore/Coqtail" },
        ft = "coq",
        config = function()
            -- Correct initialization routine
            require("vsrocq").setup({})
        end,
    },

    -- 3. Language Server Client engine connection
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                vscoq = {
                    mason = false,
                    autostart = true,
                },
            },
        },
        -- Corrected string command mappings inside your keys table
        keys = {
            { "<localleader>p", "<cmd>VsRocq panels<cr>", desc = "Rocq: Toggle Proof Panel", ft = "coq" },
            { "<localleader>n", "<cmd>VsRocq stepForward<cr>", desc = "Rocq: Step Forward", ft = "coq" },
            { "<localleader>b", "<cmd>VsRocq stepBackward<cr>", desc = "Rocq: Step Backward", ft = "coq" },
            { "<localleader>t", "<cmd>VsRocq interpretToPoint<cr>", desc = "Rocq: Interpret to Cursor", ft = "coq" },
        },
    },
}
