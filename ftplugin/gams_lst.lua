-- local status_ok, which_key = pcall(require, "which-key")
-- if not status_ok then
--   return
-- end

-- local opts = {
--   mode = "n", -- NORMAL mode
--   prefix = "<leader>",
--   buffer = vim.api.nvim_get_current_buf(), -- Specify a buffer number for buffer local mappings to show only in tex buffers
--   silent = true, -- use `silent` when creating keymaps
--   noremap = true, -- use `noremap` when creating keymaps
--   nowait = true, -- use `nowait` when creating keymaps
-- }
-- 
-- local mappings = {
--    -- ["r"] = {"<cmd>lua vim.api.nvim_set_current_dir(vim.fn.expand('%:h')); require('fine-cmdline').open({default_value = 'make'})<cr>",   "run GAMS"},
--    ["L"] = {"<cmd>vsplit %:r.lst <cr> ",      "open LST file"},
--    r = {
--       name = "Run GAMS",
--       ["r"] = {"<cmd>lua vim.env.RHP_NO_STOP = '1'; vim.env.RHP_NO_BACKTRACE= '1'; require('fine-cmdline').open({default_value = 'lcd %:h <bar> make emp=reshop'})<cr>",   "run GAMS with EMP=reshop"},
--       ["n"] = {"<cmd>lua vim.env.RHP_NO_STOP = '1'; vim.env.RHP_NO_BACKTRACE= '1'; require('fine-cmdline').open({default_value = 'lcd %:h <bar> make '})<cr>",   "run GAMS"},
-- 
--    },
-- }
-- 
-- which_key.register(mappings, opts)

-- Matches Input   /path/to/model.gms
-- Doesn't work ... since it is at the end
--vim.opt_local.errorformat:append {'%PInput%[%\\ ]%#%f'}


