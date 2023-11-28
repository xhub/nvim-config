vim.cmd('compiler gams')
vim.cmd('tcd %:p:h')

local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = vim.api.nvim_get_current_buf(), -- Specify a buffer number for buffer local mappings to show only in buffers
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

vim.api.nvim_create_user_command("GamsOpenLst", function()
   local fname = vim.fn.expand('%:r') .. '.lst';
   if vim.fn.filereadable(fname) ~= 0 then
      vim.cmd('vsplit +view ' .. fname)
   else
      vim.api.nvim_echo({{'Could find LST file ' .. fname, 'ErrorMsg'}}, false, {})
   end
end, {})

local mappings = {
   -- ["r"] = {"<cmd>lua vim.api.nvim_set_current_dir(vim.fn.expand('%:h')); require('fine-cmdline').open({default_value = 'make'})<cr>",   "run GAMS"},
   ["L"] = {"<cmd>GamsOpenLst<CR>",      "open LST file"},
   r = {
      name = "Run GAMS",
      ["r"] = {"<cmd>lua require('fine-cmdline').open({default_value = 'GamsRun emp=reshop'})<CR>",   "run GAMS with EMP=reshop"},
      ["n"] = {"<cmd>lua require('fine-cmdline').open({default_value = 'GamsRun '})<CR>",   "run GAMS"},

   },
}

which_key.register(mappings, opts)
