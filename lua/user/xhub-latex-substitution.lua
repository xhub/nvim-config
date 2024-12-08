-- local latex_symbols = {
--     ["\\in"] = "∈",
--     ["\\alpha"] = "α",
--     ["\\beta"] = "β",
--     ["\\gamma"] = "γ",
--     -- Add more LaTeX-to-Unicode mappings here
-- }
-- 
-- function ReplaceLatexOnSpaceTab()
--    vim.schedule(function()
--     local line = vim.api.nvim_get_current_line()
--     local cursor_pos = vim.api.nvim_win_get_cursor(0)
--     local col = cursor_pos[2] + 1  -- Adjust for 1-based indexing
-- 
--     for latex, unicode in pairs(latex_symbols) do
--         if line:sub(col - #latex, col - 1) == latex then
--             -- Replace LaTeX symbol with Unicode
--             vim.api.nvim_set_current_line(line:sub(1, col - #latex - 1) .. unicode .. line:sub(col))
--             vim.api.nvim_win_set_cursor(0, { cursor_pos[1], col - #latex + #unicode - 2 })
--             return
--         end
--     end
--    end)
--    return ""
-- end
-- 
-- -- Map Tab in insert mode to the ReplaceLatexOnTab function
-- vim.api.nvim_set_keymap("i", "<Space><Tab>", "v:lua.ReplaceLatexOnSpaceTab()", { expr = true, noremap = true })