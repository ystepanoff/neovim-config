local conform = require("conform")

conform.setup({
    log_level = vim.log.levels.DEBUG,

    formatters_by_ft = {
        lua = { "stylua" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        css = { "prettier" },
        html = { "prettier" },
        go = { "gofumpt", "golines" },
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

        -- HTML/CSS
        prettier = {
            prepend_args = {
                "--print-width",
                "120",
                "--prose-wrap",
                "preserve",
                "--html-whitespace-sensitivity",
                "strict",
            },
        },
    },

    format_on_save = {
        timeout_ms = 1000,
        async = false,
        lsp_fallback = true,
    },
})
