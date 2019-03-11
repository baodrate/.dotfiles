" ==============================================================================
"                                     essential
" ==============================================================================
" Don't require vi compatibility (should be default in Vim8 and neovim)
set nocompatible

" Filetype stuff
set encoding=utf-8

syntax on           " Syntax highlighting
set hidden          " Don't require unwritten buffers to be visible
set lazyredraw      " Don't update display while executing macros

" Writing to samba shares fail on neovim on mac
" (https://github.com/neovim/neovim/issues/6725)
set nofsync

" ==============================================================================
"                                     options
" ==============================================================================

" In :terminal, use neovim-remote instead of opening child nvim instance
if has('nvim')
  let $VISUAL = 'nvr -cc split --remote-wait'
endif

" from default 4000ms; mostly for vim-gitgutter
set updatetime=100

" ==========
" completion
" ==========
" Enable enhanced command-line completion. Presumes you have compiled with
" +wildmenu. See :help 'wildmenu'
set wildmenu
set wildmode=longest:list,full

" ======
" search
" ======
set showmatch       " jump to matching brace
set hlsearch        " highlight search matches
set incsearch       " jump to search result while typing
" case insensitive search (unless search terms contain uppercase characters)
set ignorecase
set smartcase

" live search/replace
set inccommand=nosplit

" ==========
" formatting
" ==========
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set backspace=indent,eol,start

autocmd Filetype python setlocal
      \ noexpandtab
      \ copyindent
      \ preserveindent
      \ softtabstop=0
      \ shiftwidth=4
      \ tabstop=4

" folding
" -------
set foldmethod=indent   " fold based on indent
" set foldmethod=syntax
set foldnestmax=4       " deepest fold is 10 levels
set nofoldenable        " dont fold by default
set foldlevel=1

" =========
" interface
" =========
set showcmd         " Show (partial) command in status line
set mouse=a
set relativenumber
set number

set nowrap

" Unprintable chars mapping
" -------------------------
if has('win32')
  " Windows doesn't like unicode characters... use ascii instead
  " These are the same listchars provided by TPope's Vim-Sensible
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
  " Windows' gvim doesn't open as unicode, so this will fail:
  " set showbreak=»
  " Instead, use this:
  let &showbreak="\u00bb\ "
else
  " alternative characters: → ‣ • · ↳ ↲ ⏎ ⟨⟩ «» ¬ ¶ ␣ …
  set listchars=tab:‣\ ,trail:•,precedes:«,extends:»
  " I use a unicode curly array with a <backslash><space>
  set showbreak=↪\
endif
set list

" colors
" ------
set background=dark
" if exists('+termguicolors')
"   let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
"   let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
"   set termguicolors             " send truecolor to term; mutually exclusive with base16colorspace
" else
"   let base16colorspace=256      " For base16-shell: Use colors from base16-shell-modified 256 colorspace
" endif
" For base16-shell: Use colors from base16-shell-modified 256 colorspace

let current_base16_theme_link = '~/.config/colors/current_base16_theme'

if ! exists('$BASE16_THEME')
  " check link in colors config directory
  " for gui apps that don't know env vars (on e.g. macOS)
  let current_theme_script=resolve(fnamemodify(current_base16_theme_link, ':p'))

  if filereadable(current_theme_script)
    let $BASE16_THEME = matchstr(current_theme_script, '^.*base16-\zs.*\ze.sh')
  else
    echo "Couldn't find $BASE16_THEME or ".current_base16_theme_link.", loading default: base16-classic-dark"
    let $BASE16_THEME = classic-dark
  endif
endif
let base16colorspace=256
colorscheme base16-$BASE16_THEME


" gvim
" ----
set guifont=DejaVu\ Sans\ Mono\ 8
" set guioptions-=m  " remove menu bar
" set guioptions-=T  " remove toolbar
" set guioptions-=r  " remove right-hand scroll bar
" set guioptions-=L  " remove left-hand scroll bar
set guioptions=ac   " autoselection and console only (no GUI prompt)
set splitbelow
set splitright

" tab and statusline
" ------------------
set laststatus=2
" set showtabline=2
set guioptions-=e
set noshowmode

" long-line
" ---------
set autoindent
set textwidth=79
set formatoptions=c,q,r
