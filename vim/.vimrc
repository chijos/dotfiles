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
set hlsearch        " highlight search results
set incsearch       " start highlighting results as I'm typing

" indentation
set autoindent      " use indentation from previous line on current line
set smartindent     " enable smart indenting

" display
set number          " display line numbers
set relativenumber  " display relative line numbers
set cursorline      " highlight the current line
set ruler           " show current location in file
set showmatch       " briefly jump to matching bracket if visible on screen
set lazyredraw      " avoid redrawing the screen unless necessary (improves performance when running macros)
set scrolloff=5     " always keep 5 lines above/below the cursor in view when scrolling
set sidescrolloff=5 " always keep 5 characters to the left/right of the cursor in view when scrolling sideways
set laststatus=2    " always display the status line
set textwidth=80    " use this in the colorcolumn setting
set colorcolumn=+1  " highlight the column right after &textwidth
" }}}

" Set <Leader> ----------------------------------------------------------{{{
let mapleader=","
" }}}

" Custom Keybindings ----------------------------------------------------{{{

" map jk to Escape, and Escape to no operation
inoremap jk <ESC>
vnoremap jk <ESC>
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

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" themes / colorschemes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ayu-theme/ayu-vim'

" editor
Plug 'scrooloose/nerdtree'
Plug 'Yggdroot/indentLine'
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'vim-syntastic/syntastic'
Plug 'jiangmiao/auto-pairs'
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif

" C#
Plug 'OrangeT/vim-csharp', { 'for': [ 'cs' ] }
Plug 'OmniSharp/omnisharp-vim', { 'for': [ 'cs' ] }
Plug 'Robzz/deoplete-omnisharp', { 'for': [ 'cs' ] }

" Javascript / Typescript
Plug 'pangloss/vim-javascript', { 'for': [ 'javascript', 'typescript' ] }
Plug 'leafgarland/typescript-vim', { 'for': [ 'javascript', 'typescript' ] }

" PowerShell
Plug 'PProvost/vim-ps1', { 'for': [ 'ps1' ] }

call plug#end()
" }}}

" Plugin Settings -------------------------------------------------------{{{

" >> vim-gitgutter --------------------------------------{{{
let g:gitgutter_enable=1
let g:gitgutter_signs=1
" }}}

" >> vim-airline ----------------------------------------{{{
let g:airline_powerline_fonts=1
let g:airline_theme='ayu_mirage'
" }}}

" >> NERDTree -------------------------------------------{{{
nnoremap <Leader>b :NERDTreeToggle<CR>
" }}}

" >> fzf ------------------------------------------------{{{
nnoremap <c-t> :Files<CR>
nnoremap <c-t><c-g> :GFiles?<CR>
" }}}

" >> ayu "-----------------------------------------------{{{
syntax enable
filetype plugin indent on
set termguicolors " enable true colors support
set background=dark
let ayucolor="mirage"
set t_Co=256
if has('nvim')
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
colorscheme ayu
if &term =~ '256color'
	set t_ut=   " prevent erase from using the terminal background color
endif
" }}}

" >> indentLine ----------------------------------------{{{
let g:indentLine_char='|'
let g:indentLine_first_char='|'
let g:indentLine_showFirstIndentLevel=1
let g:indentLine_setColors=0
" }}}

" >> OmniSharp -----------------------------------------{{{
let g:OmniSharp_server_path='/mnt/c/DevTools/omnisharp.http-win-x64/OmniSharp.exe'
let g:OmniSharp_translate_cygwin_wsl=1
let g:OmniSharp_selector_ui='fzf'
set previewheight=5
augroup omnisharp_commands
    autocmd!

    " Keybindings
    autocmd FileType cs nnoremap <Leader>gd :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap <Leader>fu :OmniSharpFindUsages<CR>
    autocmd FileType cs nnoremap <Leader><Space> :OmniSharpGetCodeActions<CR>
    autocmd FileType cs nnoremap <F2> :OmniSharpRename<CR>
    autocmd FileType cs nnoremap <C-e><C-f> :OmniSharpCodeFormat<CR>

    " Add new .cs files to the nearest project on save
    autocmd BufWritePost *.cs call OmniSharp#AddToProject()

    " Show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()
augroup END
" }}}

" >> syntastic -----------------------------------------{{{
let g:syntastic_cs_checkers=['code_checker']
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

augroup syntastic_commands
    autocmd!

    " Run syntastic check automatically when change events are detected
    autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck
augroup END
" }}}

" >> deoplete ------------------------------------------{{{
let g:deoplete#enable_at_startup=1
let g:deoplete#sources={}
autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
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

" csharp / vb -----------------------------------------------------------{{{
augroup filetype_csharp_vb
    autocmd!
    
    " use { & } as markers to detect folds in cs files
    " default to all folds open
    autocmd FileType cs setlocal foldmethod=marker foldmarker={,} foldlevel=99

    " use indentation to detect folds in vb files
    " default to all folds open
    autocmd FileType vb setlocal foldmethod=indent foldlevel=99
augroup END
" }}}

" }}}
