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

"" Themes
" Plug 'flazz/vim-colorschemes'
Plug 'ntk148v/vim-horizon'
Plug 'sainnhe/gruvbox-material'
" Plug 'chriskempson/base16-vim'
" Plug 'phanviet/vim-monokai-pro'
" Plug 'joshdick/onedark.vim'
Plug 'dracula/vim', { 'as': 'dracula' }

""" Utilities
Plug 'preservim/nerdcommenter'
Plug 'voldikss/vim-floaterm'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdcommenter'

" Lightline
Plug 'itchyny/lightline.vim'

" Prettier
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'

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

colorscheme dracula

" highlight Normal cterm=NONE gui=NONE ctermbg=233 ctermfg=252 guibg=NONE guifg=NONE
" highlight Pmenu cterm=NONE gui=NONE ctermbg=233 ctermfg=252 guifg=#ffffff guibg=#4f4f4f

"'' Definitions ''"
let loaded_matchparen = 1
let mapleader = " "
let g:netrw_browse_split = 2
let g:vrfr_rg = 'true'
let g:netrw_banner = 0
let g:netrw_winsize = 25


"'' VIM Keymaps ''"
nmap <leader>h :wincmd h<CR>
nmap <leader>j :wincmd j<CR>
nmap <leader>k :wincmd k<CR>
nmap <leader>l :wincmd l<CR>

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

autocmd FileType js,ts,graphql,rs :call GoCoc()
endif


"'' Floatterm ''"
if filereadable(expand("~/.vim/plugged/vim-floaterm/plugin/floaterm.vim"))
  nnoremap <leader>fr :FloatermNew<CR>
  nnoremap <leader>ft :FloatermNew --wintype=floating --autoclose=2<CR>
endif


"'' Harpoon ''"
if filereadable(expand("~/.vim/plugged/harpoon/plugin/harpoon.vim"))
  nmap <Leader>bf :call GotoBuffer(0)<CR>
endif


"'' Lightline ''"
if filereadable(expand("~/.vim/plugged/lightline.vim/plugin/lightline.vim"))
  let g:lightline = {'colorscheme' : 'dracula'}
endif


"'' Prettier ''"
if filereadable(expand("~/.vim/plugged/vim-prettier/plugin/prettier.vim"))
  let g:prettier#config#bracket_spacing = 'true'
  let g:prettier#config#jsx_bracket_same_line = 'false'
  let g:prettier#autoformat = 0

  autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.py,*.rs PrettierAsync
endif


"'' Telescope ''"
if filereadable(expand("~/.vim/plugged/telescope.nvim/plugin/telescope.vim"))
  nnoremap <Leader>pw :lua require'telescope.builtin'.find_files{}<CR>
endif
