local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        css = { "prettier" },
        html = { "prettier" },
        go = { "gofumpt", "goimports-reviser", "golines" },
        python = { "isort", "black" },
        haskell = { "fourmolu", "stylish-haskell" },
    },

    formatters = {
        -- C/C++
        ["clang-format"] = {
            prepend_args = {
                "-style={ \
                    IndentWidth: 4, \
                    TabWidth: 4, \
                    UseTab: Never, \
                    AccessModifierOffset: 0, \
                    IndentAccessModifiers: true, \
                    PackConstructorInitializers: Never}",
            },
        },

        -- Go
        ["goimports-reviser"] = {
            prepend_args = { "-rm-unused" },
        },
        golines = {
            prepend_args = { "--max-len=80" },
        },

        -- Python
        black = {
            prepend_args = {
                "--fast",
                "--line-length",
                "80",
            },
        },
        isort = {
            prepend_args = {
                "--profile",
                "black",
            },
        },
    },

    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
    },
}

return options
