" ==============================================================================
"                                  Init Settings
" ==============================================================================
" -------------- Get OS --------------
" get the directory for this config file, resolving symlinks
if has("win32")
  " resolve() works correct in Windows Neovim but not Windows Vim:
  " https://github.com/vim/vim/issues/147
  " use ~\.vim\plugged instead
  let g:conf_dir = $HOME . '\\.vim'
else
  let g:conf_dir = fnamemodify(resolve(expand('$MYVIMRC')), ':p:h')
endif

let s:settings = {}
let s:settings.is_win = has('win32') || has('win64')
if s:settings.is_win
  set shellslash
endif

" ------------ Set Paths -------------
if s:settings.is_win
  let s:settings.cache_dir = expand('~/AppData/Local')
  let s:settings.config_dir = expand('~/AppData/Local')
else
  let s:settings.cache_dir = expand('~/.cache')
  let s:settings.config_dir = expand('~/.config')
endif
let s:settings.nvim_dir = s:settings.cache_dir . '/nvim'
let s:settings.dein_dir = s:settings.cache_dir . '/dein'
let s:settings.dein_repo_dir = s:settings.dein_dir . '/repos/github.com/Shougo/dein.vim'

" ------------ Bootstrap -------------
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:settings.dein_repo_dir)
    execute '!git clone --depth 1 https://github.com/Shougo/dein.vim ' . s:settings.dein_repo_dir 
  endif
  execute 'set rtp^=' . fnamemodify(s:settings.dein_repo_dir, ':p')
endif

" ==============================================================================
"                                  Load Plugins
"  ==============================================================================


if dein#load_state(s:settings.dein_dir)
  call dein#begin(s:settings.dein_dir)

  call dein#add('haya14busa/dein-command.vim', { 'on_cmd': 'Dein' })

  " colorschemes {{{
  call dein#add('iCyMind/NeoSolarized')
  call dein#add('mhartington/oceanic-next')
  " }}}

  call dein#add('Shougo/denite.nvim', { 'on_cmd': 'Denite' })

  " deoplete {{{
  call dein#add('Shougo/deoplete.nvim', { 'on_if': 'has("nvim") && has("python3")' })
  call dein#add('Shougo/neco-vim', { 'depends': ['deoplete.nvim'] })
  " }}}

  " ----------- Colorschemes -----------
  " call dein#add('altercation/vim-colors-solarized')
  " call dein#add('junegunn/seoul256.vim')
  " call dein#add('w0ng/vim-hybrid')
  " call dein#add('jnurmine/Zenburn')
  " call dein#add('morhetz/gruvbox')
  " call dein#add('freeo/vim-kalisi')
  " call dein#add('tomasr/molokai')
  " call dein#add('baskerville/bubblegum')
  " call dein#add('joshdick/onedark.vim')
  call dein#add('chriskempson/base16-vim')

  " ----------- Interface --------------
  call dein#add('itchyny/lightline.vim')
  call dein#add('mike-hearn/base16-vim-lightline')
  call dein#add('taohexxx/lightline-buffer')
  call dein#add('gcmt/taboo.vim')

  call dein#add('edkolev/tmuxline.vim')

  call dein#add('mhinz/vim-startify')

  call dein#add('ryanoasis/vim-devicons')

  " ----------- Movement ---------------
  " call dein#add('terryma/vim-multiple-cursors')
  call dein#add('tpope/vim-surround')

  " ----------- Autocomplete -----------
  call dein#add('roxma/vim-hug-neovim-rpc', { 'depends': 'ncm2' })
  call dein#add('ncm2/ncm2', { 'depends': 'nvim-yarp' })
  call dein#add('roxma/nvim-yarp', { 'on_if': 'has("nvim")' })
  call dein#add('autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ })

  " NOTE: you need to install completion sources to get completions. Check
  " our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
  call dein#add('ncm2/ncm2-bufword')
  call dein#add('ncm2/ncm2-tmux')
  call dein#add('ncm2/ncm2-path')

  " ----------- Tools ------------------
  call dein#add('tpope/vim-speeddating')          " increment for dates
  call dein#add('tpope/vim-fugitive')             " for git

  call dein#add('kassio/neoterm')                 " wrapper for Vim8/Neovim terminal

  call dein#add('justinmk/vim-dirvish')

  call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 }) 
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
  call dein#add('junegunn/vim-easy-align')

  " UNIX helpers (e.g. SudoWrite;Chmod)
  call dein#add('lambdalisue/suda.vim', { 'on_if': 'has("nvim")' })
  call dein#add('tpope/vim-eunuch', { 'on_if': 'has("nvim")' })

  " ----------- Utilities --------------
  call dein#add('vimwiki/vimwiki', { 'branch': 'dev'} )
  call dein#add('itchyny/calendar.vim')

  " =========== Code ===================
  call dein#add('Raimondi/delimitMate')
  " ----------- C/C++ ------------------
  call dein#add('vim-scripts/DoxygenToolkit.vim')
  call dein#add('rhysd/vim-clang-format')
  " ----------- python -----------------

  " ----------- nand2tetris ------------
  call dein#add('sevko/vim-nand2tetris-syntax')
  " ----------- Rust -------------------
  call dein#add('rust-lang/rust.vim')
  call dein#add('racer-rust/vim-racer')
  " ----------- Other Filetypes --------
  call dein#add('jceb/vim-orgmode')
  call dein#add('godlygeek/tabular')              " required to come before vim-markdown
  call dein#add('plasticboy/vim-markdown')
  call dein#add('lervag/vimtex')
  " call dein#add('ludovicchabant/vim-gutentags')
  " call dein#add('xolox/vim-easytags')
  " call dein#add('xolox/vim-misc')               " required by vim-easytags
  " call dein#add('majutsushi/tagbar')

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

if has('termguicolors')
  set termguicolors
endif

" ==============================================================================
"                                 Source Settings
" ==============================================================================
execute 'source ' . s:settings.config_dir . '/nvim/general.vim'
execute 'source ' . s:settings.config_dir . '/nvim/mappings.vim'
execute 'source ' . s:settings.config_dir . '/nvim/plugins.vim'

if filereadable(".vimrc_proj")
  so .vimrc_proj
else
  if filereadable("../.vimrc_proj")
    so .vimrc_proj
  endif
endif
