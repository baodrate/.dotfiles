" ==============================================================================
"                                   Vim-Plug
" ==============================================================================

" ----------- vim-plug grabber -------
let firstrun=0
if has("win32")
  if empty(glob('~\AppData\Local\nvim\autoload\plug.vim'))
    (New-Object Net.WebClient).DownloadFile(
      'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim',
      $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
        "~\AppData\Local\nvim\autoload\plug.vim"
      )
    )
    autocmd VimEnter * PlugInstall
  endif
elseif has("unix")
  if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
  endif
endif

if has("win32")
  call plug#begin('~\AppData\Local\nvim\plugged')
elseif has("unix")
  call plug#begin('~/.config/nvim/plugged')
endif

" ----------- Colorschemes -----------
" Plug 'godlygeek/csapprox' " Make gvim-only colorschemes work in terminal vim
Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/seoul256.vim'
Plug 'w0ng/vim-hybrid'
Plug 'jnurmine/Zenburn'
Plug 'morhetz/gruvbox'
Plug 'freeo/vim-kalisi'
Plug 'tomasr/molokai'
Plug 'baskerville/bubblegum'

" ----------- Interface --------------
" Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-startify'

" ----------- Movement ---------------
Plug 'terryma/vim-multiple-cursors'

" ----------- Tools ------------------
" Plug 'ctrlpvim/ctrlp.vim'
if has('nvim')
    Plug 'benekastah/neomake'
    Plug 'Shougo/deoplete.nvim'
    " Plug 'Shougo/neocomplcache.vim'   "in case deoplete not ready for prime-time
elseif has('patch-8.0.0027')
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
    " Plug 'Shougo/neocomplcache.vim'   "in case deoplete not ready for prime-time
    Plug 'benekastah/neomake'
else
    " Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-completer' }
endif
" Plug 'scrooloose/syntastic'
Plug 'tpope/vim-speeddating'          " increment for dates
Plug 'tpope/vim-fugitive'             " for git
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jeetsukumaran/vim-filebeagle'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/vim-easy-align'

" ----------- Utilities --------------
Plug 'vimwiki/vimwiki'
Plug 'itchyny/calendar.vim'
Plug 'uguu-org/vim-matrix-screensaver'

" ----------- Code -------------------
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'tpope/vim-surround'
Plug 'Raimondi/delimitMate'
" ----------- C/C++ ------------------
Plug 'rhysd/vim-clang-format'
if has('nvim')
    " Plug 'zchee/deoplete-clang'
endif
" ----------- Rust -------------------
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
" ----------- Other Filetypes --------
Plug 'jceb/vim-orgmode'
Plug 'godlygeek/tabular'              " required to come before vim-markdown
Plug 'plasticboy/vim-markdown'
Plug 'lervag/vimtex'
Plug 'ludovicchabant/vim-gutentags'
" Plug 'xolox/vim-easytags'
" Plug 'xolox/vim-misc'               " required by vim-easytags
Plug 'majutsushi/tagbar'

call plug#end()

if 1 == firstrun
    :PlugInstall
endif


" ==============================================================================
"                                Source Settings
" ==============================================================================
if has("unix")
  source ~/.config/nvim/general.vim
  source ~/.config/nvim/mappings.vim
  source ~/.config/nvim/plugins.vim
else
  if has("win32")
    source ~\AppData\Local\nvim\general.vim
    source ~\AppData\Local\nvim\mappings.vim
    source ~\AppData\Local\nvim\plugins.vim
  endif
endif
if filereadable(".vimrc_proj")
    so .vimrc_proj
else
    if filereadable("../.vimrc_proj")
        so .vimrc_proj
    endif
endif
