" enable syntax and coloring

syntax enable
set background=dark
colorscheme SolarizedDark
set encoding=utf-8

"call pathogen#infect()
"call pathogen#helptags()

" set line numbers:
set number

" set tabs to width of 2 spaces
set expandtab
set shiftwidth=4
set softtabstop=4

" Mac setup
set backspace=indent,eol,start
"Use TAB to complete when typing words, else inserts TABs as usual.
""Uses dictionary and source files to find matching words to complete.

set autoindent
set smartindent

" set tab completion in vim, ie. when using tabe
set wildmode=longest,list,full
set wildmenu

" highlight matching [{()}]
set showmatch

" improve searching
set incsearch           " search as characters are entered
set hlsearch            " highlight matches

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" move vertically by visual line, this will help us not skip over long lines that are wrapped
nnoremap j gj
nnoremap k gk

" highlight last inserted text, ie. highlight the last text insterted in "insert" mode
nnoremap gV `[v`]

" Show partial commands in the last line of the screen
set showcmd

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Enable use of the mouse for all modes
"set mouse=a

" Up the amount of undos:
set undolevels=5000           " 1000 undos

" Up the command history:
set history=400

" Scroll spacing
set scrolloff=7               " keep at least 10 lines above/below
set sidescrolloff=7           " keep at least 10 lines left/right

" Change our shell
set shell=zsh

" backups:
set backup
set writebackup

" Make split navigation way easier:
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Make swithcing buffers way easier:
nnoremap <s-h> :bp<cr>
nnoremap <s-l> :bn<cr>

" Show trailing whitespace and tabs obnoxiously
set list listchars=tab:▸\ ,trail:.
set list

fun! ToggleWhitespace()
    ToggleBadWhitespace
       if &list
                set nolist
        else
                set list listchars=tab:▸\ ,trail:.
                set list
        endif
endfun


" Keep all backup and temporary fies in one place:
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

" Airline Setup
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline_powerline_fonts = 1
let g:Powerline_symbols='unicode'
let g:airline_theme = 'simple'

" Rainbow plug
let g:rainbow_active = 1

" Vim Plug Area
call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'

" On-demand
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'luochen1990/rainbow'
Plug 'chrisbra/unicode.vim'
Plug 'ervandew/supertab'

call plug#end()
