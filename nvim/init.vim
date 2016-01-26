" ==============================================================================
" .vimrc
" ==============================================================================
if !has('nvim')
    set nocompatible
    set encoding=utf-8
endif
filetype plugin indent on
syntax on
" ==============================================================================
" plugins
" ==============================================================================
" ================
" vim-plug grabber
" ================
let firstrun=0
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif
" =======
" plugins
" =======
call plug#begin('~/.vim/plugged')
" ------------
" colorschemes
" ------------
" Plug 'godlygeek/csapprox' " Make gvim-only colorschemes work in terminal vim
Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/seoul256.vim'
Plug 'w0ng/vim-hybrid'
Plug 'jnurmine/Zenburn'
Plug 'morhetz/gruvbox'
" ---------
" interface
" ---------
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
" --------
" movement
" --------
Plug 'terryma/vim-multiple-cursors'
" -----
" tools
" -----
Plug 'terryma/vim-multiple-cursors'
" Plug 'ctrlpvim/ctrlp.vim'
if has('nvim')
    " Plug 'Shougo/deoplete.nvim'     "not ready for prime-time
    Plug 'Shougo/neocomplcache.vim'
    Plug 'benekastah/neomake'
else
    Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-completer' }
    Plug 'scrooloose/syntastic'
endif
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'jeetsukumaran/vim-filebeagle'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'
" ---------
" utilities
" ---------
Plug 'vimwiki/vimwiki'
Plug 'itchyny/calendar.vim'
Plug 'uguu-org/vim-matrix-screensaver'
" ----
" code
" ----
Plug 'vim-scripts/DoxygenToolkit.vim'
" Plug 'rhysd/vim-clang-format'
Plug 'majutsushi/tagbar'
" Plug 'xolox/vim-easytags'
" Plug 'xolox/vim-misc'       " required by vim-easytags
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-surround'
Plug 'Raimondi/delimitMate'
Plug 'rust-lang/rust.vim'
Plug 'godlygeek/tabular'    " required to come before vim-markdown
Plug 'plasticboy/vim-markdown'
" ----------------
" neovim exclusive
" ----------------
call plug#end()
" ====================
" vim-plug initializer
" ====================
if 1 == firstrun
    :PlugInstall
endif
" ==============================================================================
" options
" ==============================================================================
" ========
" mappings
" ========
map Y y$
let mapleader="\<Space>"
nnoremap <silent> \ <C-W>
nnoremap <leader><Space> za
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
" ------
" colors
" ------
let g:load_doxygen_syntax = 1
let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }
set background=dark
let g:gruvbox_italic=1
colorscheme gruvbox
nnoremap <silent> [oh :call gruvbox#hls_show()<CR>
nnoremap <silent> ]oh :call gruvbox#hls_hide()<CR>
nnoremap <silent> coh :call gruvbox#hls_toggle()<CR>
nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?
" colorscheme zenburn
" colorscheme solarized
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
set showtabline=2
set guioptions-=e
" ---------
" long-line 
" ---------
set autoindent
set textwidth=79
set formatoptions=c,q,r
" ==============
" plugin options
" ==============
" ----------------
" multiple-cursors
" ----------------
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
let g:multi_cursor_exit_from_insert_mode=0
" ------
" ctrl-p
" ------
" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlP'
" " 'c' - the directory of the current file.
" " 'r' - the nearest ancestor that contains one of these directories or files:
" "       .git .hg .svn .bzr _darcs
" " 'a' - like c, but only if the current working directory outside of CtrlP is
" "       not a direct ancestor of the directory of the current file.
" let g:ctrlp_working_path_mode = 'ra'
" let g:ctrlp_custom_ignore = {
"   \ 'dir':  '\v[\/]\.(git|hg|svn)$',
"   \ 'file': '\v\.(exe|so|dll)$',
"   \ }
" -------------
" youcompleteme
" -------------
let g:ycm_global_ycm_extra_conf         = "~/.vim/.ycm_extra_conf.py"
let g:EclimCompletionMethod             = 'omnifunc'
let g:ycm_confirm_extra_conf            = "0"
let g:ycm_always_populate_location_list = 1
" --------
" deoplete
" --------
let g:deoplete#enable_at_startup = 1
" -------------
" neocomplcache
" -------------
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
" -------
" neomake
" -------
if has('nvim')
  autocmd! BufWritePost * Neomake
endif
" ---------
" lightline
" ---------
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'LightLineModified',
      \   'readonly': 'LightLineReadonly',
      \   'fugitive': 'LightLineFugitive',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

function! LightLineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? '⭠ '._ : ''
  endif
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
set noshowmode
" -------
" vimwiki
" -------
let wiki_1 = {}
let wiki_1.path = '~/school.wiki/'
let wiki_1.index = 'Home'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'
let wiki_1.nested_syntaxes = {'python': 'python', 'c++': 'cpp'}
let wiki_2 = {}
let wiki_2.path = '~/project_docs/'
let wiki_2.index = 'main'
let g:vimwiki_list = [wiki_1, wiki_2]
let g:vimwiki_ext2syntax = {'.md': 'markdown', 
                          \ '.mkd': 'markdown',
                          \ '.wiki': 'media'}
" --------
" NERDTree
" --------
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }
map <C-m> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" ------
" tagbar
" ------
nmap <F8> :TagbarToggle<CR>
" --------
" calendar
" --------
let g:calendar_frame = 'default'
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1
" --------
" rust.vim
" --------
let g:rustfmt_autosave = 1
" --------
" terminal
" --------
" switch in and out of terminal window
tnoremap <F12> <C-\><C-n><C-w><C-p>
set switchbuf+=useopen
function! TermEnter()
  let bufcount = bufnr("$")
  let currbufnr = 1
  let nummatches = 0
  let firstmatchingbufnr = 0
  while currbufnr <= bufcount
    if(bufexists(currbufnr))
      let currbufname = bufname(currbufnr)
      if(match(currbufname, "term://") > -1)
        echo currbufnr . ": ". bufname(currbufnr)
        let nummatches += 1
        let firstmatchingbufnr = currbufnr
        break
      endif
    endif
    let currbufnr = currbufnr + 1
  endwhile
  if(nummatches >= 1)
    execute ":sbuffer ". firstmatchingbufnr
    startinsert
  else
    execute ":terminal"
  endif
endfunction
map <F12> :call TermEnter()<CR>
" ------------
" vim-markdown
" ------------
let g:vim_markdown_math=1
let g:vim_markdown_frontmatter=1
