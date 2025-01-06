-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
    theme = "catppuccin",

    -- hl_override = {
    -- 	Comment = { italic = true },
    -- 	["@comment"] = { italic = true },
    -- },
}

M.options = {
    options = {
        fixeol = true,
    },
}

M.plugins = {}

M.autocommands = function()
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function()
            local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
            if #lines == 0 or lines[#lines] ~= "" then
                vim.api.nvim_buf_set_lines(0, -1, -1, false, { "" })
            end
        end,
    })
end

return M
