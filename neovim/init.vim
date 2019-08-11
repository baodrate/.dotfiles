"  let $NVIM_COC_LOG_LEVEL = 'debug'
"  let g:coc_node_args = ['--nolazy', '--inspect-brk=6045']

" ==============================================================================
"                                  Init Settings
" ==============================================================================
" -------------- Get OS --------------
let s:settings = {}
let g:settings = {}
if has('win32') || has('win64')
  set shellslash
endif

" ------------ Set Paths -------------
if has('win32') || has('win64')
  let s:settings.sys_cache_dir = expand('~/AppData/Local')
  let s:settings.sys_config_dir = expand('~/AppData/Roaming')
else
  if !empty($NERD_TREE_ROOT)
    autocmd VimEnter * NERDTree $HOME/$NERD_TREE_ROOT
  endif
  let s:settings.sys_cache_dir = get(g:, 'pluginname_setting', "default")
  let s:settings.sys_cache_dir = expand('~/.cache')
  let s:settings.sys_config_dir = expand('~/.config')
endif

" global paths
let g:settings.config_dir = s:settings.sys_config_dir . '/nvim'
let g:settings.cache_dir = s:settings.sys_cache_dir . '/nvim'

" local paths
let s:settings.dein_cache = g:settings.cache_dir . '/dein'
let s:settings.dein_dir = s:settings.dein_cache . '/repos/github.com/Shougo/dein.vim'

" ------------ Bootstrap -------------
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:settings.dein_dir)
    execute '!git clone --depth 1 https://github.com/Shougo/dein.vim ' . s:settings.dein_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:settings.dein_dir, ':p')
endif

" ==============================================================================
"                                  Load Plugins
" ==============================================================================

if dein#load_state(s:settings.dein_cache)
  call dein#begin(s:settings.dein_cache)

  call dein#add(s:settings.dein_cache . '/repos/github.com/Shougo/dein.vim')

  call dein#add('noahfrederick/vim-noctu')

  " Dein utility Commands
  call dein#add('haya14busa/dein-command.vim', { 'on_cmd': 'Dein' })
  call dein#add('Shougo/denite.nvim', { 'on_cmd': 'Denite' })

  " ----------- Buffers ----------------
  call dein#add('qpkorr/vim-bufkill')

  " ----------- Statusline -------------
  call dein#add('pacha/vem-tabline')

  " ----------- Interface --------------
  call dein#add('edkolev/tmuxline.vim')
  call dein#add('mhinz/vim-startify')
  call dein#add('ryanoasis/vim-devicons')
  call dein#add('jeffkreeftmeijer/vim-numbertoggle')  " Toggle relative numbers in normal mode
  call dein#add('wincent/pinnacle') " functions to modify highlight groups

  " ----------- Movement ---------------
  " call dein#add('terryma/vim-multiple-cursors')
  call dein#add('tpope/vim-surround')

  " =========== Intellisense ===========
  " ----------- LS & auto-complete -----
  " call dein#add('neoclide/coc.nvim', {'hook_post_update': 'call coc#util#install()'})
  " call dein#add('neoclide/coc.nvim', {'build': 'yarn install --frozen-lockfile'})
  call dein#add('neoclide/coc.nvim', {"rev": "release"})

  " ----------- linting ----------------
  " call dein#add('w0rp/ale')

  " ----------- language-server --------
  " call dein#add('autozimu/LanguageClient-neovim', {
  "     \ 'rev': 'next',
  "     \ 'build': 'bash install.sh',
  "     \ })

  " ----------- autocompletion ---------
  " call dein#add('ncm2/ncm2', { 'depends': 'nvim-yarp' })
  " call dein#add('roxma/nvim-yarp')
  " call dein#add('ncm2/ncm2-bufword')
  " call dein#add('ncm2/ncm2-tmux')
  " call dein#add('ncm2/ncm2-path')
  " call dein#add('ncm2/ncm2-jedi')

  " ----------- Tags -------------------
  " call dein#add('ludovicchabant/vim-gutentags')
  " call dein#add('skywind3000/gutentags_plus')
  " call dein#add('majutsushi/tagbar')

  " =========== Tools ==================
  " ----------- Auto-close -------------
  " call dein#add('Raimondi/delimitMate')
  " call dein#add('cohama/lexima.vim')
  " call dein#add('jiangmiao/auto-pairs')
  " call dein#add('tpope/vim-endwise')

  " ----------- Utility ----------------
  call dein#add('tpope/vim-speeddating')          " increment for dates

  call dein#add('justinmk/vim-dirvish')           " netrw replacement

  " depend on zsh to install fzf binary
  " call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
  call dein#add('junegunn/vim-easy-align')

  call dein#add('lambdalisue/suda.vim')           " UNIX helpers (e.g. SudoWrite;Chmod)

  call dein#add('vimwiki/vimwiki', { 'branch': 'dev'} )
  call dein#add('itchyny/calendar.vim')

  " ----------- Git --------------------
  call dein#add('mhinz/vim-signify')
  call dein#add('itchyny/vim-gitbranch')

  " =========== Code ===================
  " ----------- C/C++ ------------------
  call dein#add('vim-scripts/DoxygenToolkit.vim')
  call dein#add('rhysd/vim-clang-format')
  " call dein#add('lyuts/vim-rtags')
  " ----------- javascript -------------
  call dein#add('posva/vim-vue')
  " ----------- nand2tetris ------------
  call dein#add('sevko/vim-nand2tetris-syntax')
  " ----------- Rust -------------------
  call dein#add('rust-lang/rust.vim')
  call dein#add('racer-rust/vim-racer')
  " ----------- csv --------------------
  call dein#add('chrisbra/csv.vim')
  " ----------- json -------------------
  call dein#add('elzr/vim-json')
  " ----------- shell ------------------
  call dein#add('itspriddle/vim-shellcheck')
  " ----------- Other Filetypes --------
  call dein#add('jceb/vim-orgmode')
  call dein#add('godlygeek/tabular')              " required to come before vim-markdown
  call dein#add('plasticboy/vim-markdown')
  call dein#add('lervag/vimtex')

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

" ==============================================================================
"                                 Source Settings
" ==============================================================================
execute 'source ' . g:settings.config_dir . '/general.vim'
execute 'source ' . g:settings.config_dir . '/plugins.vim'
execute 'source ' . g:settings.config_dir . '/mappings.vim'
execute 'source ' . g:settings.config_dir . '/autocomplete.vim'
execute 'source ' . g:settings.config_dir . '/statusline.vim'
