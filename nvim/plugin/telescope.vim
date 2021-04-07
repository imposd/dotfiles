  nnoremap <Leader>pw :lua require'telescope.builtin'.find_files{}<CR>
  nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
  nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
  nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>
