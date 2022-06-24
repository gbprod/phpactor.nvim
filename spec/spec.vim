set rtp+=.
set rtp+=vendor/plenary.nvim/

runtime plugin/plenary.vim
runtime plugin/phpactor.lua

lua require('plenary.busted')
lua require('phpactor').setup()

