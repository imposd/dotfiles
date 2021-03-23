"'' VIM PRE-PLUG ''"
syntax on
set guicursor=
set noshowmatch
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set cmdheight=2
set updatetime=50
set shortmess+=c
set colorcolumn=85

"'' START PLUG ''"
call plug#begin('~/.vim/plugged')
"" Language Support
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

"" Themes
Plug 'flazz/vim-colorschemes'
Plug 'gruvbox-community/gruvbox'
Plug 'chriskempson/base16-vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }

""" Utilities
Plug 'preservim/nerdcommenter'
Plug 'voldikss/vim-floaterm'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdcommenter'
Plug 'ThePrimeagen/harpoon'
Plug 'tpope/vim-fugitive'

" Prettier
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'



call plug#end()
"'' END PLUG ''"


"'' VIM POST-PLUG ''"
"This executes the command silently and ignores errors
let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

let g:gruvbox_invert_selection='0'

colorscheme challenger_deep

highlight Normal cterm=NONE gui=NONE ctermbg=233 ctermfg=252 guibg=NONE guifg=NONE
highlight Pmenu cterm=NONE gui=NONE ctermbg=233 ctermfg=252 guifg=#ffffff guibg=#4f4f4f

"'' Definitions ''"
let loaded_matchparen = 1
let mapleader = " "
let g:netrw_browse_split = 2
let g:vrfr_rg = 'true'
let g:netrw_banner = 0
let g:netrw_winsize = 25
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
highlight clear CursorLineNR


"'' VIM Keymaps ''"
nmap <leader>h :wincmd h<CR>
nmap <leader>j :wincmd j<CR>
nmap <leader>k :wincmd k<CR>
nmap <leader>l :wincmd l<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <leader>pv :Vex!<CR>


if filereadable(expand("~/.vim/plugged/coc.nvim/plugin/coc.vim"))
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

func GoCoC()
  :CocEnable
  inoremap <buffer> <silent><expr> <TAB>
              \ pumvisible() ? "\<C-n>" :
              \ <SID>check_back_space() ? "\<TAB>" :
              \ coc#refresh()

  inoremap <buffer> <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
  inoremap <buffer> <silent><expr> <C-space> coc#refresh()

  nmap <buffer> <leader>gd <Plug>(coc-definition)
  nmap <buffer> <leader>gy <Plug>(coc-type-definition)
  nmap <buffer> <leader>gi <Plug>(coc-implementation)
  nmap <buffer> <leader>gr <Plug>(coc-references)
  nmap <buffer> <leader>rr <Plug>(coc-rename)
  nnoremap <buffer> <leader>cr :CocRestart
endfun

nnoremap <silent> L :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')
nmap <leader>rn <Plug>(coc-rename)

fun! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

autocmd BufWritePre * :call TrimWhitespace()

autocmd FileType js,ts,graphql,gql,rs :call GoCoc()
endif

let s:hidden_all = 0
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction

nnoremap <S-h> :call ToggleHiddenAll()<CR>

"'' Go ''"
if filereadable(expand("~/.config/nvim/plugged/vim-go/plugin/go.vim"))
  let g:go_code_completion_enabled = 0
  let g:go_fmt_command = "goimports"
  let g:go_gpls_enabled = 0
  let g:go_doc_keywordprg_enabled = 0

  let g:go_highlight_array_whitespace_error = 0
  let g:go_highlight_chan_whitespace_error = 0
  let g:go_highlight_extra_types = 0
  let g:go_highlight_space_tab_error = 0
  let g:go_highlight_trailing_whitespace_error = 0
  let g:go_highlight_operators = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_function_parameters = 1
  let g:go_highlight_function_calls = 1
  let g:go_highlight_types = 1
  let g:go_highlight_fields = 1
  let g:go_highlight_build_constraints = 1
  let g:go_highlight_generate_tags = 1
  let g:go_highlight_variable_declarations = 1
  let g:go_highlight_variable_assignments = 1
endif


"'' Floatterm ''"
if filereadable(expand("~/.vim/plugged/vim-floaterm/plugin/floaterm.vim"))
  nnoremap <leader>fr :FloatermNew<CR>
  nnoremap <leader>ft :FloatermNew --wintype=floating --autoclose=2<CR>
endif


"'' Harpoon ''"
if filereadable(expand("~/.vim/plugged/harpoon/plugin/harpoon.vim"))
  nnoremap <C-m> :lua require("harpoon.mark").add_file()<CR>
  nnoremap <C-e> :lua require("harpoon.ui").toggle_quick_menu()<CR>
  nnoremap <C-h> :lua require("harpoon.ui").nav_file(1)<CR>
  nnoremap <C-t> :lua require("harpoon.ui").nav_file(2)<CR>
  nnoremap <C-n> :lua require("harpoon.ui").nav_file(3)<CR>
  nnoremap <C-s> :lua require("harpoon.ui").nav_file(4)<CR>
  nnoremap <C-g> :lua require("harpoon.mark").rm_file()<CR>
  nnoremap <leader><C-r> :lua require("harpoon.mark").shorten_list()<CR>
  nnoremap <leader><C-d> :lua require("harpoon.mark").clear_all()<CR>
  nnoremap <leader>r :lua require("harpoon.mark").promote()<CR>
  nnoremap <leader>tu :lua require("harpoon.term").gotoTerminal(1)<CR>
  nnoremap <leader>te :lua require("harpoon.term").gotoTerminal(2)<CR>
  nnoremap <leader>cu :lua require("harpoon.term").sendCommand(1, 1)<CR>
  nnoremap <leader>ce :lua require("harpoon.term").sendCommand(1, 2)<CR>
endif


"'' Prettier ''"
if filereadable(expand("~/.vim/plugged/vim-prettier/plugin/prettier.vim"))
  let g:prettier#config#bracket_spacing = 'true'
  let g:prettier#config#jsx_bracket_same_line = 'false'
  let g:prettier#autoformat = 0

  autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.py PrettierAsync
endif


"'' Telescope ''"
if filereadable(expand("~/.vim/plugged/telescope.nvim/plugin/telescope.vim"))
  nnoremap <Leader>pw :lua require'telescope.builtin'.find_files{}<CR>
endif
