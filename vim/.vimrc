" Vim Settings ----------------------------------------------------------{{{

" basic options
set nocompatible    " no backwards compatibility with vi
set noswapfile      " do not create swap files
set nowrap          " do not wrap text
set showmode        " always display current mode
set showcmd         " show partially typed commands
set autoread        " automatically load external changes to file
set hidden          " allow switching buffers without having to save current one
set backspace=indent,eol,start  " allow backspace over everything
set splitbelow      " always create new horizontal splits below the current window
set splitright      " always create new vertical splits to the right of the current window
set foldenable      " allow folds to be created
set foldmethod=syntax   " use language syntax to automatically define folds
set foldlevelstart=99    " do not fold any code by default
set completeopt=longest,menuone,preview " provide completion options, default to longest, show even if only one option and show a preview if available

" tabs / spaces
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab

" search
set ignorecase      " case insensitive search
set nohlsearch      " do not highlight search results
set incsearch       " start highlighting results as I'm typing

" indentation
set autoindent      " use indentation from previous line on current line
set smartindent     " enable smart indenting

" display
set number           " display line numbers
set relativenumber   " display relative line numbers
set cursorline       " highlight the current line
set ruler            " show current location in file
set showmatch        " briefly jump to matching bracket if visible on screen
set lazyredraw       " avoid redrawing the screen unless necessary (improves performance when running macros)
set scrolloff=10     " always keep 10 lines above/below the cursor in view when scrolling
set sidescrolloff=10 " always keep 10 characters to the left/right of the cursor in view when scrolling sideways
set laststatus=2     " always display the status line
set textwidth=80     " use this in the colorcolumn setting
set colorcolumn=+1   " highlight the column right after &textwidth
" }}}

" Set <Leader> ----------------------------------------------------------{{{
let mapleader=","
" }}}

" Custom Keybindings ----------------------------------------------------{{{

" map jk to Escape, and Escape to no operation
inoremap jk <ESC>
vnoremap jk <ESC>
tnoremap jk <C-\><C-n>
inoremap <ESC> <nop>
vnoremap <ESC> <nop>

" map <Space> to stop highlighting search results
nnoremap <Space> :noh<CR>

" map the arrow keys to no operation
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" convenience shortcuts to edit my vimrc and reload it
nnoremap <Leader>ev :vsplit $HOME/.vimrc<CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>
" }}}

" Install plugins -------------------------------------------------------{{{
call plug#begin('~/.vim/plugged')

" themes / colorschemes
Plug 'vim-airline/vim-airline'
Plug 'hzchirs/vim-material'
Plug 'ryanoasis/vim-devicons'

" editor
Plug 'scrooloose/nerdtree'
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'

" miscellaneous
Plug 'mhinz/vim-startify'

call plug#end()
" }}}

" Plugin Settings -------------------------------------------------------{{{

" >> vim-airline ----------------------------------------{{{
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='material'
" }}}

" >> NERDTree -------------------------------------------{{{
nnoremap <Leader>b :NERDTreeToggle<CR>
" }}}

" >> fzf ------------------------------------------------{{{
nnoremap <c-b> :Buffers<CR>
nnoremap <c-t> :Files<CR>
nnoremap <c-t><c-g> :GFiles?<CR>
" }}}

" >> theme - gotham "-----------------------------------------------{{{

if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
    set termguicolors
endif

let g:material_style='oceanic'
set background=dark
colorscheme vim-material
syntax enable
filetype plugin indent on

set t_8b=[48;2;%lu;%lu;%lum
set t_8f=[38;2;%lu;%lu;%lum

if &term =~ '256color'
	set t_ut=   " prevent erase from using the terminal background color
endif
" }}}

" >> OmniSharp "------------------------------------------------------{{{
let g:OmniSharp_server_stdio = 1
let g:OmniSharp_server_path = '/mnt/c/DevTools/omnisharp.http.win-x64/OmniSharp.exe'
let g:OmniSharp_translate_cygwin_wsl = 1
let g:OmniSharp_selector_ui = 'fzf'
let g:OmniSharp_timeout = 5
" }}}

" }}}

" filetype specific settings --------------------------------------------{{{

" vim -------------------------------------------------------------------{{{
augroup filetype_vim
    autocmd!

    " use {{{ & }}} as markers to detect folds
    " default to all folds closed
    autocmd FileType vim setlocal foldmethod=marker foldmarker={{{,}}} foldlevelstart=0
augroup END
" }}}

" }}}
