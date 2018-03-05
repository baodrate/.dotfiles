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

" ----------- Get OS -------
if !exists("g:os")
  if has("win64") || has("win32") || has("win16")
    let g:os = "Windows"
  else
    let g:os = substitute(system('uname'), '\n', '', '')
  endif
endif

" get the directory for this config file, resolving symlinks
if g:os == 'Windows'
  " resolve() works correct in Windows Neovim but not Windows Vim:
  " https://github.com/vim/vim/issues/147
  " use ~\.vim\plugged instead
  let g:conf_dir = $HOME . '\\.vim'
else
  let g:conf_dir = fnamemodify(resolve(expand('$MYVIMRC')), ':p:h')
endif

" ==============================================================================
"                                   Vim-Plug
" ==============================================================================
if g:os == 'Windows'
  let g:plug_dir = g:conf_dir . '\\plugged'
else
  let g:plug_dir = g:conf_dir . '/plugged'
endif
call plug#begin(g:plug_dir)

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
  Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
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
if g:os == "Windows"
  source ~\AppData\Local\nvim\general.vim
  source ~\AppData\Local\nvim\mappings.vim
  source ~\AppData\Local\nvim\plugins.vim
else
  source ~/.config/nvim/general.vim
  source ~/.config/nvim/mappings.vim
  source ~/.config/nvim/plugins.vim
endif
if filereadable(".vimrc_proj")
  so .vimrc_proj
else
  if filereadable("../.vimrc_proj")
    so .vimrc_proj
  endif
endif
