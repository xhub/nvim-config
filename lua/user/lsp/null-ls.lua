local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

-- Matches Solution report and get 
--      SOLVER XXX     FROM LINE LLL
-- **** SOLVER STATUS     XX
-- **** MODEL STATUS      XX
-- %C%mFROM LINE %*\\d, --> not working
local efm_lst = '%I%>Solution Report%[%^F]%#From line %l,%-C,%C%[ ]%#%m%[ ]%#FROM LINE%[ ]%#%*\\d,%-C%[%^%#]%[%^%#]%[%^%#]%[%^%#]%.%#,%C%>%[%#]%[%#]%[%#]%[%#] %m,%-Z'

-- Ignore lines not starting with **** 
--              starting with ****, but without any '$'
--              Start are empty
--              That start with a number
--              Short lines (less than 3 char)
efm_lst = efm_lst .. ',%-G%[%^%#]%[%^%#]%[%^%#]%[%^%#]%.%#,%-G%[%#]%[%#]%[%#]%[%#] %[%^%$]%#,%-G,%-G%[ ]%#%l%.%#,%-G%.,%-G%.%.,%-G%.%.%.'

-- Matches ****    $XX
--        {**** XX ERRMSG
--        {**** ERRMSG}}
--           LL
-- Note, we ignore multiple errors on the same line ...
efm_lst = efm_lst .. ',%E%>%[%#]%[%#]%[%#]%[%#]%. %p%$%n%.%#,%C%>%[%#]%[%#]%[%#]%[%#] %*\\d %[%\\ ]%#%m,%C%>%[%#]%[%#]%[%#]%[%#]%[ ]%#%m,%Z%[ ]%#%l%.%#'


-- Matches Input   **** Exec Error at line LL: ERRMSG
efm_lst = efm_lst .. ',%[%#]%[%#]%[%#]%[%#] Exec %trror at line %l: %m'

-- Define a custom source for null-ls for GAMS file
local quickfix_gams = {
   method = { null_ls.methods.DIAGNOSTICS_ON_OPEN, null_ls.methods.DIAGNOSTICS_ON_SAVE },
   name = "quickfix-GAMS_LST",
   filetypes = { "gams" }, -- Adjust the filetypes as needed

   generator = {
      -- params is documented here: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/MAIN.md#params
      fn = function(params)
         local s_tbl =
         {
            ['E'] = vim.lsp.protocol.DiagnosticSeverity.Error,
            ['W'] = vim.lsp.protocol.DiagnosticSeverity.Warning,
            ['I'] = vim.lsp.protocol.DiagnosticSeverity.Information,
         }

         -- Run gams with action "compile" on save
         if (params.method == null_ls.methods.DIAGNOSTICS_ON_SAVE) then
            vim.cmd('GamsRun action=c')
         end

         local diagnostics = {}

         local lst_fname = vim.fn.expand('%:p:r') .. '.lst'
         if vim.fn.filereadable(lst_fname) == 0 then
            vim.api.nvim_echo({{'No diagnostics: could not find LST file ' .. lst_fname, 'WarningMsg'}}, false, {})
            return diagnostics
         end

         local efm_save = vim.o.efm
         vim.o.efm = efm_lst

         -- replace with setqflist
         vim.cmd('cgetfile ' .. lst_fname)
         local qfitems = vim.fn.getqflist({items = 1, nr = '$'}).items
         local quickfix_list = vim.tbl_filter(function(e) return e.valid == 1 end, qfitems)

         vim.o.efm = efm_save

         for _, entry in ipairs(quickfix_list) do
            local rownr = entry.lnum;
            local severity = s_tbl[entry.type]
            if not severity then severity = vim.lsp.protocol.DiagnosticSeverity.Information end

            -- In the LST, we could only get the linenumber +1 for errors
            if rownr > 0 then
               if severity == vim.lsp.protocol.DiagnosticSeverity.Error and (entry.nr and entry.nr > 0) then
                  rownr = rownr - 1
               end
            else
               rownr = vim.api.nvim_buf_line_count(params.bufnr)
            end

            -- It is more pleasing to have a bit of space for the info part

            local msg;
            if severity == vim.lsp.protocol.DiagnosticSeverity.Information then
               msg = string.gsub(entry.text, "\n", "\n  ");
            else
               msg = entry.text;
            end

            -- see :h diagnostic-structure
            -- IDEA: add user_data
            local diagnostic = {
               row = rownr,
               col = entry.col,
               message = msg,
               severity = severity,
               source = 'LST file',
            }

            table.insert(diagnostics, diagnostic)
         end

         return diagnostics
      end,
   },
}

-- Register the custom source with null-ls
null_ls.register(quickfix_gams)

null_ls.setup({
	debug = true,
   on_attach = require("user.lsp.handlers").on_attach,
	sources = {
		formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.stylua,
      diagnostics.checkmake,
--      quickfix_gams,
    --  diagnostics.codespell,
    -- diagnostics.flake8
	},
})
