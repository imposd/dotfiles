  nnoremap <C-m> :lua require("harpoon.mark").add_file()<CR>
  nnoremap <leader><C-r> :lua require("harpoon.mark").rm_file()<CR>
  nnoremap <C-e> :lua require("harpoon.ui").toggle_quick_menu()<CR>
  nnoremap <C-h> :lua require("harpoon.ui").nav_file(1)<CR>
  nnoremap <C-y> :lua require("harpoon.ui").nav_file(2)<CR>
  nnoremap <C-n> :lua require("harpoon.ui").nav_file(3)<CR>
  nnoremap <C-s> :lua require("harpoon.ui").nav_file(4)<CR>
  nnoremap <leader><C-d> :lua require("harpoon.mark").clear_all()<CR>
  nnoremap <leader>tu :lua require("harpoon.term").gotoTerminal(1)<CR>
  nnoremap <leader>te :lua require("harpoon.term").gotoTerminal(2)<CR>
  nnoremap <leader>cu :lua require("harpoon.term").sendCommand(1, 1)<CR>
 
