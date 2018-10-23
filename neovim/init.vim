" ==============================================================================
"                                   Vim-Plug
" ==============================================================================
" ----------- Get OS -------
" get the directory for this config file, resolving symlinks
if has("win32")
  " resolve() works correct in Windows Neovim but not Windows Vim:
  " https://github.com/vim/vim/issues/147
  " use ~\.vim\plugged instead
  let g:conf_dir = $HOME . '\\.vim'
else
  let g:conf_dir = fnamemodify(resolve(expand('$MYVIMRC')), ':p:h')
endif

" ----------- vim-plug grabber -------
if has("win32")
  if empty(glob('~\AppData\Local\nvim\autoload\plug.vim'))
    (New-Object Net.WebClient).DownloadFile(
      'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim',
      $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(
        "~\AppData\Local\nvim\autoload\plug.vim"
      )
    )
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
else
  if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endif

" ==============================================================================
"                                   Vim-Plug
" ==============================================================================
if has("win32")
  let g:plug_dir = g:conf_dir . '\\plugged'
else
  let g:plug_dir = g:conf_dir . '/plugged'
endif
call plug#begin(g:plug_dir)

  " ----------- Colorschemes -----------
  Plug 'altercation/vim-colors-solarized'
  Plug 'junegunn/seoul256.vim'
  Plug 'w0ng/vim-hybrid'
  Plug 'jnurmine/Zenburn'
  Plug 'morhetz/gruvbox'
  Plug 'freeo/vim-kalisi'
  Plug 'tomasr/molokai'
  Plug 'baskerville/bubblegum'
  Plug 'joshdick/onedark.vim'
  Plug 'chriskempson/base16-vim'

  " ----------- Interface --------------
  Plug 'itchyny/lightline.vim'
  Plug 'mike-hearn/base16-vim-lightline'
  Plug 'taohexxx/lightline-buffer'
  Plug 'gcmt/taboo.vim'

  Plug 'edkolev/tmuxline.vim'

  Plug 'mhinz/vim-startify'

  Plug 'ryanoasis/vim-devicons'

  " ----------- Movement ---------------
""  Plug 'terryma/vim-multiple-cursors'
  Plug 'tpope/vim-surround'

  " ----------- Tools ------------------
  " Deoplete (requires async)
  if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  elseif v:version >= 800
    Plug 'Shougo/deoplete.nvim'
    " These two required by Deoplete in Vim8
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif
  Plug 'tpope/vim-speeddating'          " increment for dates
  Plug 'tpope/vim-fugitive'             " for git

  Plug 'kassio/neoterm'                 " wrapper for Vim8/Neovim terminal

  Plug 'justinmk/vim-dirvish'
""  Plug 'kristijanhusak/vim-dirvish-git' " major slow down

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/vim-easy-align'

  Plug 'tpope/vim-eunuch'               " UNIX helpers (e.g. SudoWrite;Chmod)

  " ----------- Utilities --------------
  Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
  Plug 'itchyny/calendar.vim'

  " =========== Code ===================
  Plug 'Raimondi/delimitMate'
  Plug 'w0rp/ale'
  " Plug 'autozimu/LanguageClient-neovim', {
  "     \ 'branch': 'next',
  "     \ 'do': 'bash install.sh',
  "     \ }
  " ----------- C/C++ ------------------
  Plug 'vim-scripts/DoxygenToolkit.vim'
  Plug 'rhysd/vim-clang-format'
  " ----------- python -----------------

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
if has("win32")
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
