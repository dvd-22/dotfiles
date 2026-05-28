return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            -- 1. Register the custom server with LazyVim's setup
            setup = {
                prolog_lsp = function(_, opts)
                    local configs = require("lspconfig.configs")
                    if not configs.prolog_lsp then
                        configs.prolog_lsp = {
                            default_config = {
                                cmd = {
                                    "swipl",
                                    "-g",
                                    "use_module(library(lsp_server)).",
                                    "-g",
                                    "lsp_server:main",
                                    "-t",
                                    "halt",
                                    "--",
                                    "stdio",
                                },
                                filetypes = { "prolog" },
                                root_dir = require("lspconfig.util").root_pattern("pack.pl", ".git", "init.pl"),
                            },
                        }
                    end
                end,
            },
            -- 2. Ensure it's in the servers list to trigger setup
            servers = {
                prolog_lsp = {},
            },
        },
    },
}
