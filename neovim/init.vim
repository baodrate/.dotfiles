" ==============================================================================
"                                   Vim-Plug
" ==============================================================================
" ----------- Get OS -------
if !exists("g:os")
  if has("win64") || has("win32") || has("win16")
    let g:os = "Windows"
  else
    let g:os = substitute(system('uname'), '\n', '', '')
  endif
endif

" get the directory for this config file, resolving symlinks
if g:os ==? 'Windows'
  " resolve() works correct in Windows Neovim but not Windows Vim:
  " https://github.com/vim/vim/issues/147
  " use ~\.vim\plugged instead
  let g:conf_dir = $HOME . '\\.vim'
else
  let g:conf_dir = fnamemodify(resolve(expand('$MYVIMRC')), ':p:h')
endif

" ----------- vim-plug grabber -------
if g:os ==? 'Windows'
  if empty(glob('~\AppData\Local\nvim\autoload\plug.vim'))
    (New-Object Net.WebClient).DownloadFile(
      'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim',
      $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
        "~\AppData\Local\nvim\autoload\plug.vim"
      )
    )
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
elseif g:os ==? 'Linux' || g:os ==? 'Darwin'
  if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endif

" ==============================================================================
"                                   Vim-Plug
" ==============================================================================
if g:os ==? 'Windows'
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
  Plug 'joshdick/onedark.vim'

  " ----------- Interface --------------
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'airblade/vim-gitgutter'
  Plug 'mhinz/vim-startify'

  " ----------- Movement ---------------
  Plug 'terryma/vim-multiple-cursors'
  Plug 'tpope/vim-surround'

  " ----------- Tools ------------------
  " Neomake (requires async)
  if has('nvim') || v:version >= 800
    Plug 'benekastah/neomake'
  endif
  " Deoplete (requires async)
  if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  elseif v:version >= 800
    Plug 'Shougo/deoplete.nvim'
    " These two required by Deoplete in Vim8
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif
  " Plug 'w0rp/ale'                     " Asynchronous Lint Engine
  Plug 'tpope/vim-speeddating'          " increment for dates
  Plug 'tpope/vim-fugitive'             " for git

  " TODO: use justinmk/vim-dirvish instead of FileBeagle?
  Plug 'jeetsukumaran/vim-filebeagle'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/vim-easy-align'

  " ----------- Utilities --------------
  Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
  Plug 'itchyny/calendar.vim'

  " =========== Code ===================
  Plug 'Raimondi/delimitMate'
  " ----------- C/C++ ------------------
  Plug 'vim-scripts/DoxygenToolkit.vim'
  Plug 'rhysd/vim-clang-format'
  if has('nvim')
      " Plug 'zchee/deoplete-clang'
  endif
  " ----------- nand2tetris ------------
  Plug 'sevko/vim-nand2tetris-syntax'
  " ----------- Rust -------------------
  Plug 'rust-lang/rust.vim'
  Plug 'racer-rust/vim-racer'
  " ----------- Other Filetypes --------
  Plug 'jceb/vim-orgmode'
  Plug 'godlygeek/tabular'              " required to come before vim-markdown
  Plug 'plasticboy/vim-markdown'
  Plug 'lervag/vimtex'
  " Plug 'ludovicchabant/vim-gutentags'
  " Plug 'xolox/vim-easytags'
  " Plug 'xolox/vim-misc'               " required by vim-easytags
  " Plug 'majutsushi/tagbar'

call plug#end()

" ==============================================================================
"                                Source Settings
" ==============================================================================
if g:os ==? "Windows"
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
