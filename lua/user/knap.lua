-- set shorter name for keymap function
local keymap = vim.api.nvim_set_keymap

-- F5 processes the document once, and refreshes the view
keymap('i','<F5>', '', { callback = function()
        require("knap").process_once()
    end, silent = true, noremap = true })
keymap('v','<F5>', '', { callback = function()
        require("knap").process_once()
    end,
    silent = true, noremap = true })
keymap('n','<F5>', '', { callback = function()
        require("knap").process_once()
    end, silent = true, noremap = true })

-- F6 closes the viewer application, and allows settings to be reset
keymap('i','<F6>', '', { callback = function()
        require("knap").close_viewer()
    end, silent = true, noremap = true })
keymap('v','<F6>', '', { callback = function()
        require("knap").close_viewer()
    end, silent = true, noremap = true })
keymap('n','<F6>', '', { callback = function()
        require("knap").close_viewer()
    end, silent = true, noremap = true })

-- F7 toggles the auto-processing on and off
keymap('i','<F7>', '', { callback = function()
        require("knap").toggle_autopreviewing()
    end, silent = true, noremap = true })
keymap('v','<F7>', '', { callback =function()
        require("knap").toggle_autopreviewing()
    end, silent = true, noremap = true })
keymap('n','<F7>', '', { callback = function()
        require("knap").toggle_autopreviewing()
    end, silent = true, noremap = true })

-- F8 invokes a SyncTeX forward search, or similar, where appropriate
keymap('i','<F8>', '', { callback = function()
        require("knap").forward_jump()
    end, silent = true, noremap = true })
keymap('v','<F8>', '', { callback = function()
        require("knap").forward_jump()
    end, silent = true, noremap = true })
keymap('n','<F8>', '', { callback = function()
        require("knap").forward_jump()
    end, silent = true, noremap = true })

local gknapsettings = {
    texoutputext = "pdf",
    textopdf = "pdflatex -synctex=1 -halt-on-error -interaction=batchmode %docroot%",
    textopdfviewerlaunch = "qpdfview --unique --instance neovim %outputfile%",
    textopdfviewerrefresh = "none",
    textopdfforwardjump = "qpdfview --unique --instance neovim %outputfile%#src:%srcfile%:%line%:%column%"
}
vim.g.knap_settings = gknapsettings
