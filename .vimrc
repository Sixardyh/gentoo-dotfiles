" Plugins
call plug#begin('~/.vim/plugged')
Plug 'junegunn/goyo.vim'
Plug 'morhetz/gruvbox'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'w0rp/ale'
Plug 'vim-airline/vim-airline'
Plug 'tomtom/tcomment_vim'
Plug 'dhruvasagar/vim-zoom'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'mhinz/vim-startify'
Plug 'ajh17/VimCompletesMe'
Plug 'vim-jp/vim-cpp'       "syntax highlighting for c and cpp
Plug 'vim-python/python-syntax'       "syntax highlighting for python
Plug 'vim-scripts/a.vim'
Plug 'wesQ3/vim-windowswap'
Plug 'reedes/vim-pencil'

call plug#end()

let mapleader=","       " leader is comma
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set encoding=utf-8
set scrolloff=7             " minimum amount of lines to keep above and under current line
set expandtab			    " Make tabs spaces
set number                  " line numbers
set showcmd			        " show command in bottom bar
set wildmenu            	" visual autocomplete for command menu
set wildmode=longest:list,full
set lazyredraw          	" redraw only when we need to.
set showmatch           	" highlight matching [{()}]
set incsearch               " search as characters are entered
set hlsearch   		        " highlight matches
set splitbelow              " open new splits to the top
set splitright              " open new splits to the right
set completeopt-=preview    " hide preview windows
set nocompatible
set mouseshape+=n:beam      " Use i-beam in GVim
set clipboard=unnamed
set timeoutlen=1000
set ttimeoutlen=0
set nomodeline              " exploit nstuff

filetype plugin on
" turn off search highlight
nnoremap <leader>h :nohlsearch<CR>
" highlight last inserted text
nnoremap gV `[v`]i
" save session (windows, etc.)
nnoremap <leader>s :mksession! <Bar> :SSave <CR>
" switch panes faster
nnoremap <C-l> <C-W><C-l>
nnoremap <C-h> <C-W><C-h>
nnoremap <C-k> <C-W><C-k>
nnoremap <C-j> <C-W><C-j>
" insert hard tab instead of spaces
inoremap <C-t> <C-V><Tab>
" save as root
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
" activate spellchecking
cnoremap spellfr setlocal spell spelllang=fr
" toggle NERDTree
map <F2> :NERDTreeToggle<CR>
" toggle Goyo
map <F4> :Goyo<CR>

" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Autogroups
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn

    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType c setlocal tabstop=8
    autocmd FileType c setlocal shiftwidth=8
    autocmd FileType c setlocal softtabstop=8
    autocmd FileType c setlocal foldmethod=indent
    autocmd FileType c setlocal foldlevel=0
    autocmd FileType cpp setlocal colorcolumn=87
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd FileType python let b:vcm_tab_complete = "python"
    autocmd FileType python setlocal colorcolumn=87
    autocmd FileType tex call pencil#init({'wrap': 'soft'})

    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufNewFile,BufRead /*.rasi setf css
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
    autocmd BufEnter *.asm ALEDisableBuffer
    autocmd BufEnter *.asm setlocal tabstop=8
    autocmd BufEnter *.asm setlocal shiftwidth=8
    autocmd BufEnter *.asm setlocal softtabstop=8
    " clear all trailing whitespaces on save
    autocmd BufWritePre * %s/\s\+$//e
    autocmd ColorScheme gruvbox hi SpellBad cterm=Underline ctermfg=red
    autocmd ColorScheme gruvbox hi SpellCap cterm=Underline ctermfg=red
    autocmd ColorScheme gruvbox hi SpellLocal cterm=Underline ctermfg=red
    autocmd ColorScheme gruvbox hi SpellRare cterm=Underline ctermfg=red
augroup END

" Color stuff
set termguicolors      " terminal true colours
set background=dark    " Setting dark mode
let g:gruvbox_italic = 1
let g:gruvbox_contrast_dark = "hard"
colorscheme gruvbox
syntax enable


" Backup in /tmp
" set backup
" set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" set backupskip=/tmp/*,/private/tmp/*
" set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" set writebackup

" ale config
let g:ale_python_flake8_options = '--ignore=E701,E501,W391,E741,E722,W503,E129'
let g:airline#extensions#ale#enabled = 1

" GUI options
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

" hide mode in bottom bar (status line already show it)
set noshowmode

" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 1

" python-syntax settings
let g:python_highlight_all = 1

