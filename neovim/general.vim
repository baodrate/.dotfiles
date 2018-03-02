" ==============================================================================
"                                     essential
" ==============================================================================
if !has('nvim')
    set nocompatible
    set encoding=utf-8
endif
filetype plugin indent on
syntax on

if has("unix")
  if (system('uname') =~ "darwin")  " for MacOS
    let g:python2_host_prog = '/usr/local/bin/python'
    let g:python3_host_prog = '/usr/local/bin/python3'
  endif
else
  if has ("win32")
    " let g:python2_host_prog = 'C:\Users\BaoT\AppData\Local\Programs\Python\Python36-32\python.exe'
    let g:python3_host_prog = 'C:\Users\BaoT\AppData\Local\Programs\Python\Python36-32\python.exe'
  endif
endif
" ==============================================================================
"                                     options
" ==============================================================================
" ------
" search
" ------
set showmatch       " jump to matching brace
set hlsearch        " highlight search matches
set incsearch       " jump to search result while typing
set ignorecase
set smartcase
" ==========
" formatting
" ==========
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set backspace=indent,eol,start

" autocmd Filetype python setlocal ts=4 sw=4 sts=4 tw=80 smarttab expandtab
autocmd Filetype python setlocal noexpandtab
    \ copyindent
    \ preserveindent
    \ softtabstop=0
    \ shiftwidth=4
    \ tabstop=4
" -------
" folding
" -------
set foldmethod=indent   "fold based on indent
" set foldmethod=syntax
set foldnestmax=4       "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1
" =========
" interface
" =========
set showcmd         " Show (partial) command in status line
set mouse=a
set relativenumber
set number
set ruler
set hidden          " use vim's buffers as they were meant to be used
set list          " Display unprintable characters f12 - switches
set listchars=tab:•\ ,trail:•,extends:»,precedes:« " Unprintable chars mapping
" ------
" colors
" ------
let g:load_doxygen_syntax = 1
let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }
set background=dark
" colorscheme gruvbox
" let g:gruvbox_italic=1
" nnoremap <silent> [oh :call gruvbox#hls_show()<CR>
" nnoremap <silent> ]oh :call gruvbox#hls_hide()<CR>
" nnoremap <silent> coh :call gruvbox#hls_toggle()<CR>
" nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
" nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
" nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?
" colorscheme kalisi
" colorscheme zenburn
" colorscheme solarized
" colorscheme molokai
" let g:molokai_original = 0
colorscheme bubblegum-256-dark
" colorscheme hybrid
" let g:hybrid_use_Xresources = 1
" colorscheme seoul256
" let g:seoul256_background = 236
if !has("gui_running") && !has("nvim")
    set t_Co=256
endif
" ----
" gvim
" ----
set guifont=DejaVu\ Sans\ Mono\ 8
" set guifont=DejaVu\ Sans\ Mono\ 8
"set guioptions-=m  " remove menu bar
"set guioptions-=T  " remove toolbar
"set guioptions-=r  " remove right-hand scroll bar
"set guioptions-=L  " remove left-hand scroll bar
set guioptions=ac   " autoselection and console only (no GUI prompt)
set splitbelow
set splitright
" ------------------
" tab and statusline
" ------------------
set laststatus=2
" set showtabline=2
set guioptions-=e
set noshowmode
" ---------
" long-line
" ---------
set autoindent
set textwidth=79
set formatoptions=c,q,r
