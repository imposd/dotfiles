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

call plug#begin('~/.vim/plugged')
"" Language Support
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim'
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
Plug 'ThePrimeagen/harpoon'
Plug 'tpope/vim-fugitive'

"" Prettier
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

"" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'

"" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

call plug#end()

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
set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']


"'' Keymaps ''"
nmap <leader>h :wincmd h<CR>
nmap <leader>j :wincmd j<CR>
nmap <leader>k :wincmd k<CR>
nmap <leader>l :wincmd l<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <leader>pv :Vex!<CR>


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

"'' NVIM LSP ''"
if filereadable(expand("~/.vim/plugged/nvim-lspconfig/plugin/lspconfig.vim"))
  lua require'lspconfig'.bashls.setup{ on_attach=require'completion'.on_attach }
  lua require'lspconfig'.dockerls.setup{ on_attach=require'completion'.on_attach }
  lua require'lspconfig'.gopls.setup{ on_attach=require'completion'.on_attach }
  lua require'lspconfig'.html.setup{ on_attach=require'completion'.on_attach }
  lua require'lspconfig'.jsonls.setup{ on_attach=require'completion'.on_attach }
  lua require'lspconfig'.rust_analyzer.setup{ on_attach=require'completion'.on_attach }
  lua require'lspconfig'.tsserver.setup{ on_attach=require'completion'.on_attach }
  lua require'lspconfig'.vuels.setup{ on_attach=require'completion'.on_attach }
  lua require'lspconfig'.ccls.setup{ on_attach=require'completion'.on_attach }

  set completeopt=menuone,noinsert,noselect

  autocmd BufWritePre *.go, lua, ts vim.lsp.buf.formatting()

  nnoremap <leader>vd :lua vim.lsp.buf.definition()<CR>
  nnoremap <leader>vi :lua vim.lsp.buf.implementation()<CR>
  nnoremap <leader>vsh :lua vim.lsp.buf.signature_help()<CR>
  nnoremap <leader>vrr :lua vim.lsp.buf.references()<CR>
  nnoremap <leader>vrn :lua vim.lsp.buf.rename()<CR>
  nnoremap <S-l> :lua vim.lsp.buf.hover()<CR>
  nnoremap <leader>vca :lua vim.lsp.buf.code_action()<CR>
  nnoremap <leader>vsd :lua vim.lsp.util.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>
  nnoremap <leader>vn :lua vim.lsp.diagnostic.goto_next()<CR>
  nnoremap <leader>vll :lua vim.lsp.diagnostic.set_loclist()<CR>
  nnoremap <leader>xl :lua vim.lsp.buf.code_action()<CR>
endif

"'' Floatterm ''"
if filereadable(expand("~/.vim/plugged/vim-floaterm/plugin/floaterm.vim"))
  nnoremap <leader>fr :FloatermNew<CR>
  nnoremap <leader>ft :FloatermNew --wintype=floating --autoclose=2<CR>
endif


"'' Harpoon ''"
if filereadable(expand("~/.vim/plugged/harpoon/plugin/harpoon.vim"))
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
  nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
  nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
  nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>
endif
