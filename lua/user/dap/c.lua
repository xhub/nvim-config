local ok, dap = pcall(require, 'dap')
if not ok then
   return
end

dap.adapters.gdb = {
   type = "executable",
   command = "gdb",
   args = { "--interpreter=dap", "--eval-command", "'set print pretty on'",
   "-iex", 'set debug dap-log-file /tmp/gdb-dap.log'}
   --[[
    args = {
        '-iex',
        'set debug dap-log-file /tmp/gdb-dap.log',
        '--quiet',
        '--interpreter=dap',
    },
]]
}

dap.configurations.c = {
   {
      name = "Launch",
      type = "gdb",
      request = "launch",
      program = function()
         return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = "${workspaceFolder}",
      stopAtBeginningOfMainSubprogram = false,
   },
   {
      name = "Select and attach to process",
      type = "gdb",
      request = "attach",
      program = function()
         return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      pid = function()
         local name = vim.fn.input('Executable name (filter): ')
         return require("dap.utils").pick_process({ filter = name })
      end,
      cwd = '${workspaceFolder}'
   },
   {
      name = 'Attach to gdbserver :1234',
      type = 'gdb',
      request = 'attach',
      target = 'localhost:1234',
      program = function()
         return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}'
   },
   {
      name = 'Attach to process by PID (GDB)',
      type = 'gdb',
      request = 'attach',
      pid = function()
         return tonumber(vim.fn.input('PID: '))
      end,
      cwd = '${workspaceFolder}'
   },
}
