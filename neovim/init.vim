" ==============================================================================
"                                   Vim-Plug
" ==============================================================================

" ----------- vim-plug grabber -------
let firstrun=0
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')

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
    " function! DoRemote(arg)
    "     UpdateRemotePlugins
    " endfunction
    Plug 'Shougo/deoplete.nvim'
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
source ~/.dotfiles/neovim/general.vim
source ~/.dotfiles/neovim/mappings.vim
source ~/.dotfiles/neovim/plugins.vim
if filereadable(".vimrc_proj")
    so .vimrc_proj
else
    if filereadable("../.vimrc_proj")
        so .vimrc_proj
    endif
endif
