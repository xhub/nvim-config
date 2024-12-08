local ok, dap = pcall(require, 'dap')
if not ok then
   return
end

local ui = require "dapui"

-- dap.setup()
-- ui.setup()

dap.listeners.before.attach.dapui_config = function()
   ui.open()
end
dap.listeners.before.launch.dapui_config = function()
   ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
   ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
   ui.close()
end

-- configure dap-ui and language adapaters
require('user.dap.ui')
require('user.dap.c')

require('nvim-dap-virtual-text').setup({
   -- Use eol instead of inline
   virt_text_pos = "eol",
})

local ok_wk, wk = pcall(require, "which-key")

if ok_wk then

   wk.add({{ mode = { 'n' },
--      {"<leader>b", dap.toggle_breakpoint},
--      {"<leader>gb", dap.run_to_cursor},

      -- Eval var under cursor
      {"<leader>?", function() ui.eval(nil, { enter = true }) end, desc = 'DAP eval variable under cursor'},

      {"<F3>", dap.up},
      {"<F4>", dap.down},
      {"<F5>", dap.continue},
      {"<F6>", dap.step_into},
      {"<F7>", dap.step_over},
      {"<F8>", dap.step_out},
      {"<F9>", dap.step_back},
      {"<F12>", dap.restart},
   }})
end

local telescope_dap = require('telescope').load_extension('dap')

if telescope_dap then

   wk.add({
      {'<leader>D', group = "DAP debugger"},
--      { mode = { 'n', 'v' },
         {'<leader>D?', function() telescope_dap.commands({}) end, silent = true, desc = 'DAP builtin commands' },
         {'<leader>Dl', function() telescope_dap.list_breakpoints({}) end, silent = true, desc = 'DAP breakpoint list' },
         {'<leader>Df', telescope_dap.frames, silent = true, desc = 'DAP frames' },
         {'<leader>Dv', telescope_dap.variables, silent = true, desc = 'DAP variables' },
         {'<leader>Dc', telescope_dap.configurations, silent = true, desc = 'DAP debugger configurations' },
         {'<leader>Dr', dap.repl.open, noremap = true, silent = true, desc = 'DAP open REPL' },
         {'<leader>Dt', ui.toggle,  noremap = true, silent = true, desc = 'DAP toggle' },
--      }
   })
end

