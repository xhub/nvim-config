-- refresh the buffer. Should have a way to disable it
vim.api.nvim_create_autocmd({"FocusGained","BufEnter","CursorHold","CursorHoldI"},{
   pattern = "*.lst",
   command = "if mode() != 'c' | checktime | endif"
})

-- Set filetype based on extension and the header
vim.api.nvim_create_autocmd("BufEnter", {
   pattern = "*.lst",
   callback = function()
      if vim.startswith(vim.fn.getline(1), 'GAMS') then
         vim.api.nvim_cmd({ cmd = 'setf', args = { 'gams_lst' } }, {})
      end
   end,
})

-- Set filetype based on extension and the header
vim.api.nvim_create_autocmd("BufEnter", {
   pattern = "*.[0-9]\\+",
   callback = function()
      if vim.startswith(string.lower(vim.fn.getline(1)), '$title') then
         vim.api.nvim_cmd({ cmd = 'setf', args = { 'gams' } }, {})
      end
   end,
})

-- TODO: this should update/rebuild a qflist, right now there is little control
vim.api.nvim_create_autocmd("BufRead", {
   pattern = "*.lst",
   callback = function()
      local ft = vim.fn.getbufvar(0, "filetype")
      if not ft == "gams_lst" then return end

      vim.cmd("cgetbuffer")
   end,
})

local lsp = vim.lsp
local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  return
end

-- Define a custom source for null-ls for LST file
local quickfix_gams_lst = {
   method = null_ls.methods.DIAGNOSTICS_ON_OPEN,
   name = "quickfix-LST",
   filetypes = { "gams_lst" }, -- Adjust the filetypes as needed

   generator = {
      fn = function(params)
         local s_tbl =
         {
            ['E'] = lsp.protocol.DiagnosticSeverity.Error,
         }
         -- Set of regular expressions
         local regex_set = {
            '^Solution Report',      -- Matches lines starting with 'start'
            'end$',        -- Matches lines ending with 'end'
            'pattern%d+',  -- Matches lines with 'pattern' followed by one or more digits
         }

         -- Function to process buffer line by line and check against regex
         local function process_buffer()
            local buffer_number = vim.fn.bufnr('%')  -- Get the buffer number of the current buffer
            local lines = vim.api.nvim_buf_get_lines(buffer_number, 0, -1, false)  -- Get all lines in the buffer

            for i, line in ipairs(lines) do
               for _, regex in ipairs(regex_set) do
                  if string.match(line, regex) then
                     print(string.format('Line %d matches regex: %s', i, regex))
                  end
               end
            end
         end

         vim.cmd('cgetbuffer')
         local qfitems = vim.fn.getqflist({items = 1, nr = '$'}).items
         local quickfix_list = vim.tbl_filter(function(e) return e.valid == 1 end, qfitems)

         local diagnostics = {}
         for _, entry in ipairs(quickfix_list) do
            local rownr = entry.lnum;
            -- In the LST, we could only get the linenumber +1
            if rownr > 0 then rownr = rownr - 1 else rownr = vim.api.nvim_buf_line_count(params.bufnr) end
            local severity = s_tbl[entry.type]
            if not severity then severity = lsp.diagnostics.DiagnosticSeverity.Information end

            local diagnostic = {
               row = rownr,
               col = entry.col,
               message = entry.text,
               severity = severity,
               source = 'quickfix-LST',
            }

            table.insert(diagnostics, diagnostic)
         end

         return diagnostics
      end,
   },
}

-- From: https://gist.githubusercontent.com/phelipetls/639a1b5f021d17c4124cccc83e518566/raw/0c63969a317c086f33ecf708f67d12e9a85f2ec8/async_make.lua

vim.api.nvim_create_user_command("GamsRun", function(args)
   local winnr = vim.fn.win_getid()
   local bufnr = vim.api.nvim_win_get_buf(winnr)

   -- local makeprg = vim.api.nvim_buf_get_option(bufnr, "makeprg")
   -- if not makeprg then return end

   local cmd = {"gams", vim.fn.expand('%:p')}
   vim.list_extend(cmd, args.fargs)

   local cwd = vim.fn.expand('%:p:h')

   local fname = vim.fn.bufname('%')

   vim.api.nvim_command("doautocmd QuickFixCmdPre")

   local lines = {""}

   local function on_event(job_id, data, event)
      if event == "stdout" or event == "stderr" then
         if data then
            vim.list_extend(lines, data)
         end
      end

      if event == "exit" then
         -- vim.fn.setqflist({}, " ", {
         --    title = "GAMS log",
         --    lines = lines,
         --    efm = vim.api.nvim_buf_get_option(bufnr, "errorformat")
         -- })
         -- vim.api.nvim_command("doautocmd QuickFixCmdPost")

         -- Read the LST file and update the diagnostic
         local lsp_method = 'textDocument/didOpen'
         local lsp_clients = vim.lsp.get_active_clients({bufnr = bufnr})
         -- TODO when neovim 10 is released, use the call below
         -- local lsp_clients = vim.lsp.get_clients({bufnr = bufnr, method = lsp_method})

         if not lsp_clients then return end

         for _,c in ipairs(lsp_clients) do
            c.notify(lsp_method, { textDocument = { uri = vim.uri_from_bufnr(bufnr) }})
         end
      end
   end

   local job_id =
   vim.fn.jobstart(
      cmd,
      {
         on_stderr = on_event,
         on_stdout = on_event,
         on_exit = on_event,
         stdout_buffered = false,
         stderr_buffered = false,
         cwd = cwd,
         env = { RHP_NO_STOP = 1, RHP_NO_BACKTRACE = 1 },
         pty = 1,
      }
   )
end, {nargs = '*', bar = true})

-- Register the custom source with null-ls
-- null_ls.register(quickfix_gams_lst)

-- Configure null-ls to use the sources
-- require("lspconfig")["null-ls"].setup {
--    sources = {
--       null_ls.builtins.diagnostics,
--       quickfix_gams_lst.name,
--       quickfix_gams.name,
--    },
-- }
