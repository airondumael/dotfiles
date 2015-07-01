set nocompatible " not vi compatible

" --------------------------------------------------------------------
" Load pathogen
" --------------------------------------------------------------------
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

"--------------------------------------------------------------------
syntax on
set showmatch
set go-=L
set guioptions-=T
set guioptions-=r
set linespace=8
set showmode
set mouse=a
set colorcolumn=80,100,120
set clipboard=unnamed
set undolevels=1000
set history=1000
set shell=/bin/zsh
set tabstop=4
set softtabstop=4
set smarttab
set expandtab
set shiftwidth=4
set shiftround
set autoindent
set smartindent
set foldenable
set foldmethod=indent
set foldlevelstart=99
set wildmenu
set wildmode=list:longest
set number
set ignorecase
set smartcase
set timeout timeoutlen=500 ttimeoutlen=0
set visualbell
set noerrorbells
set hidden
set tags=./tags,tags,$HOME
set splitbelow
set splitright
set showcmd
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set encoding=utf-8
set list " show unprintable characters
set listchars=tab:▸\              " Char representing a tab
set listchars+=extends:❯          " Char representing an extending line
set listchars+=precedes:❮         " Char representing an extending line in the other direction
set listchars+=nbsp:␣             " Non breaking space
set listchars+=trail:·            " Show trailing spaces as dots
set showbreak=↪                  " Show wraped lines with this char
set fillchars+=vert:\             " Don't show pipes in vertical splits
set ruler
set showmode
set scrolljump=5
set wrap
set incsearch
set hlsearch
set linebreak
set nohidden
highlight Search cterm=underline
set autoread
set ttyfast
set lazyredraw

"augroup CursorLineOnlyInActiveWindow
"    autocmd!
"    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
"    autocmd WinLeave * setlocal nocursorline
"augroup END

" vim can autodetect this based on $TERM (e.g. 'xterm-256color')
" but it can be set to force 256 colors
" set t_Co=256
if &t_Co < 256
    colorscheme lizard
    set nocursorline " looks bad in this mode
else
    set t_Co=256
    set background=dark
    colorscheme lizard256
endif

set guifont=Source\ Code\ Pro\ for\ Powerline:h14

filetype plugin indent on " enable file type detection
set autoindent

autocmd BufWritePre * :%s/\s\+$//e

" ---------------------------------------------------------------------
"  Mappings
"  --------------------------------------------------------------------

let mapleader = ","
let g:mapleader = ","

nnoremap ; :

nmap <C-b> :NERDTreeToggle<cr>

map <leader>bd :BufOnly<cr>

nmap <leader>w :w!<cr>
imap <leader>w <esc>:w!<cr>i
nmap <leader>p :CtrlP<cr>
nmap <leader>b :CtrlPBuffer<cr>

nnoremap j gj
nnoremap k gk

nmap <leader>m :b#<cr>
nmap <leader>h <C-w>h
nmap <leader>j <C-w>j
nmap <leader>k <C-w>k
nmap <leader>l <C-w>l
nmap <left> <C-w>h
nmap <down> <C-w>j
nmap <up> <C-w>k
nmap <right> <C-w>l

nmap <leader>t :set ts=2 sts=2 noet<cr>:retab!<cr>:set ts=4 sts=4 et<cr>:retab<cr>

" ----------------------------------------------------------------------
" GoDoc
" ---------------------------------------------------------------------
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

au FileType go nmap <Leader>gb <Plug>(go-doc-browser)

au FileType go nmap <Leader>i <Plug>(go-info)

au FileType go nmap <Leader>e <Plug>(go-rename)

" VIM GO
"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:go_fmt_command = "goimports"

let g:go_fmt_autosave = 0 "1 to enable

let g:go_play_open_browser = 0 "1 to enable




" ----------------------------------------------------------------------
" NerdTree
" ---------------------------------------------------------------------
let g:go_fmt_command = "goimports"
let g:go_bin_path = '/usr/local/bin'

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

au FileType go nmap <Leader>gb <Plug>(go-doc-browser)


au FileType go nmap <Leader>s <Plug>(go-implements)

au FileType go nmap <Leader>i <Plug>(go-info)

au FileType go nmap <Leader>e <Plug>(go-rename)
" ----------------------------------------------------------------------
"  CtrlP
"  ---------------------------------------------------------------------
let g:ctrlp_use_caching = 0
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor

    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif
let g:ctrlp_working_path_mode = 'ra'


set wildignore+=*/vendor/**
set wildignore+=*/public/forum/**
set wildignore+=*/.git/**
set wildignore+=*/.sass-cache/**

" always center cursor
set so=999
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

autocmd FileType javascript noremap <buffer> <leader>w :call JsBeautify()<cr> :w!<cr>


" ---------------------------------------------------------------------
"  Goyo
"  --------------------------------------------------------------------
nnoremap <Leader>g1 :Goyo 120<CR>
nnoremap <Leader>g2 :Goyo 240<CR>
nnoremap <Leader>gq :Goyo!<CR>

function! s:goyo_enter()
endfunction

function! s:goyo_leave()
endfunction

let g:goyo_margin_top=2
let g:goyo_margin_bottom=2
let g:goyo_width=120

autocmd! User GoyoEnter
autocmd! User GoyoLeave
autocmd  User GoyoEnter nested call <SID>goyo_enter()
autocmd  User GoyoLeave nested call <SID>goyo_leave()

" ---------------------------------------------------------------------
"  Syntastic
"  --------------------------------------------------------------------
let g:syntastic_check_on_open=1
let g:syntastic_javascript_checkers = ['jsxhint']
let g:jsx_ext_required = 0

" ---------------------------------------------------------------------
"  NERDTree
"  --------------------------------------------------------------------
augroup AuNERDTreeCmd
    autocmd!
augroup end

" ---------------------------------------------------------------------
"  GitGutter
"  --------------------------------------------------------------------
let g:gitgutter_max_signs = 1024


" ---------------------------------------------------------------------
"  The Silver Searcher
"  --------------------------------------------------------------------
let g:ackprg = 'ag --nogroup --nocolor --column'

" --------------------------------------------------------------------
"  EasyMotion
"  -------------------------------------------------------------------
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1
nmap s <Plug>(easymotion-s)
nmap <leader><leader>j <Plug>(easymotion-j)
nmap <leader><leader>k <Plug>(easymotion-k)

" -------------------------------------------------------------------
"  MultiCursor
"  ------------------------------------------------------------------
let g:multi_cursor_exit_from_visual_mode = 0
let g:multi_cursor_exit_from_insert_mode = 0

"--------------------------------------------------------------------
" Vim-Airline
" -------------------------------------------------------------------
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
"let g:airline_theme             = 'powerlineish'
"let g:airline_theme             = 'wombat'
let g:airline_enable_branch     = 1
let g:airline_enable_syntastic  = 1
let g:airline_detect_modified = 1
let g:airline_powerline_fonts = 1
let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : 'N ',
      \ 'i'  : 'I ',
      \ 'R'  : 'R ',
      \ 'c'  : 'C ',
      \ 'v'  : 'V ',
      \ 'V'  : 'V ',
      \ '' : 'V ',
      \ 's'  : 'S ',
      \ 'S'  : 'S ',
      \ '' : 'S ',
      \ }

" -------------------------------------------------------------------
"  Git Gutter
"  ------------------------------------------------------------------
let g:gitgutter_signs = 1
let g:gitgutter_escape_grep = 1
let g:gitgutter_map_keys = 0
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0
" -------------------------------------------------------------------
"  Enable overiding with ~/.vimrc.local
"  ------------------------------------------------------------------
let $LOCALFILE=expand("~/.vimrc.local")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif


hi Normal ctermbg=none
highlight NonText ctermbg=none
