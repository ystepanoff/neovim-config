local lint = require("lint")

lint.linters_by_ft = {
    lua = { "luacheck" },
    python = { "pylint" },
    haskell = { "hlint" },
}

lint.linters.luacheck.args = {
    unpack(lint.linters.luacheck.args),
    "--globals",
    "love",
    "vim",
}

lint.linters.pylint.cmd = vim.fn.expand("$HOME/.config/nvim/lua/configs/lint/pylint.sh")
lint.linters.pylint.args = {
    function()
        return vim.api.nvim_buf_get_name(0)
    end,
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    callback = function()
        lint.try_lint()
    end,
})
