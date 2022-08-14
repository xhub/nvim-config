vim.api.nvim_set_var('vimwiki_global_ext', 0)
vim.api.nvim_set_var('vimwiki_map_prefix', '<Leader>v')
require('telescope').load_extension('vw')
vim.cmd([[
let wiki_1 = {}
let wiki_1.path = '~/vimwiki/general/'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.wiki'

let wiki_2 = {}
let wiki_2.path = '~/vimwiki/research/'
let wiki_2.syntax = 'markdown'
let wiki_2.ext = '.wiki'

let wiki_3 = {}
let wiki_3.path = '~/vimwiki/spi/'
let wiki_3.syntax = 'markdown'
let wiki_3.ext = '.wiki'

let wiki_4 = {}
let wiki_4.path = '~/vimwiki/programming/'
let wiki_4.syntax = 'markdown'
let wiki_4.ext = '.wiki'

let g:vimwiki_list = [wiki_1, wiki_2, wiki_3, wiki_4]
let g:vimwiki_ext2syntax = {'.wiki': 'markdown'}
]])

