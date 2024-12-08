local ok, dapui = pcall(require, 'dapui')
if not ok then
    return
end

dapui.setup({
    layouts = {
        -- Changing the layout order will give more space to the first element
        {
            -- You can change the order of elements in the sidebar
            elements = {
                -- { id = "scopes", size = 0.25, },
                { id = 'stacks', size = 0.50 },
                { id = 'breakpoints', size = 0.20 },
                { id = 'watches', size = 0.20 },
                { id = 'console', size = 0.10 },
            },
            size = 56,
            position = 'right', -- Can be "left" or "right"
        },
        {
            elements = {
                { id = 'repl', size = 1 },
            },
            size = 30,
            position = 'bottom', -- Can be "bottom" or "top"
        },
    },
    controls = {
        icons = {
            pause = '',
            play = ' (F5)',
            step_into = ' (F6)',
            step_over = ' (F7)',
            step_out = ' (F8)',
            step_back = ' (F9)',
            run_last = ' (F10)',
            terminate = ' (F12)',
            disconnect = ' ([l]d)',
        },
    },
})

local dap = require('dap')

dap.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function(e)
--    require('dap.utils').info(
--        string.format(
--            "program '%s' was terminated.",
--            vim.fn.fnamemodify(e.config.program, ':t')
--        )
--    )
    dapui.close()
end
--[[
dap.listeners.before.event_exited['dapui_config'] = function()
    dapui.close()
end
]]



