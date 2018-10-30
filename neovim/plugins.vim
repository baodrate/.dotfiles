" ==============================================================================
"                             LanguageClient-neovim
" ===============================================================================
" Always draw the signcolumn.
set signcolumn=yes

let g:LanguageClient_serverCommands = {
    \ 'c': ['cquery', '--log-file=/tmp/cc.log', '--init={"cacheDirectory":"~/.cache/cquery/"}'],
    \ 'cpp': ['cquery', '--log-file=/tmp/cc.log', '--init={"cacheDirectory":"~/.cache/cquery/"}'],
    \ 'cuda': ['cquery', '--log-file=/tmp/cc.log', '--init={"cacheDirectory":"~/.cache/cquery/"}'],
    \ 'objc': ['cquery', '--log-file=/tmp/cc.log', '--init={"cacheDirectory":"~/.cache/cquery/"}'],
    \ 'python': ['pyls'],
    \ }

let g:LanguageClient_loadSettings = 1 " Use an absolute configuration path if you want system-wide settings

" https://github.com/autozimu/LanguageClient-neovim/issues/379 LSP snippet is not supported
let g:LanguageClient_hasSnippetSupport = 0

nnoremap <F5> :call LanguageClient_contextMenu()<CR>

" augroup LanguageClient_config
"   au!
"   au BufEnter * let b:Plugin_LanguageClient_started = 0
"   au User LanguageClientStarted setl signcolumn=yes
"   au User LanguageClientStarted let b:Plugin_LanguageClient_started = 1
"   au User LanguageClientStopped setl signcolumn=auto
"   au User LanguageClientStopped let b:Plugin_LanguageClient_stopped = 0
"   au CursorMoved * if b:Plugin_LanguageClient_started | sil call LanguageClient#textDocument_documentHighlight() | endif
" augroup END

function SetLSPShortcuts()
  nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
  nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
  nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
  nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
  nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
  nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
  nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
  nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
endfunction()

augroup LSP
  autocmd!
  autocmd FileType cpp,c call SetLSPShortcuts()
augroup END

" ==============================================================================
"                                      ncm2
" ==============================================================================
" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" Affects the visual representation of what happens after you hit <C-x><C-o>
" https://neovim.io/doc/user/insert.html#i_CTRL-X_CTRL-O
" https://neovim.io/doc/user/options.html#'completeopt'
"
" This will show the popup menu even if there's only one match (menuone),
" prevent automatic selection (noselect) and prevent automatic text injection
" into the current line (noinsert).
"
" :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
" inoremap <expr> <CR> pumvisible() ? "\<c-y>\<cr>" : "\<CR>"
inoremap <expr> <CR> pumvisible() ? "\<c-y>" : "\<CR>"

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" ==============================================================================
"                                       ale
" ==============================================================================
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['black'],
\   'javascript': ['eslint'],
\}
let g:ale_linters = {
\   'python': ['pylint'],
\   'c': ['clangd', 'clangcheck', 'clangtidy'],
\   'cpp': ['clangd', 'clangcheck', 'clangtidy'],
\}
let g:ale_linters_explicit = 1

let g:ale_set_highlights = 1
let g:ale_fix_on_save = 0
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'

let g:ale_completion_enabled = 1

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

" ==============================================================================
"                                     Racer
" ==============================================================================
if has("win32")
  throw 'configure windows path to racer in .config/nvim/plugins.vim'
else
  let g:racer_cmd = "/usr/local/bin/racer"
endif

" ==============================================================================
"                                   rust.vim
" ==============================================================================
let g:rustfmt_autosave = 1

" ==============================================================================
"                                    lightline
" ==============================================================================

set showtabline=2
let g:lightline = {
    \ 'colorscheme': 'base16_seti',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'enable': {
    \   'statusline': 1,
    \   'tabline': 1,
    \ },
    \ 'tabline': {
    \   'left': [ ['tabicon'], ['bufferinfo'], ['tabs'] ],
    \   'right': [ ['buffericon'], ['bufferafter', 'buffercurrent', 'bufferbefore'] ],
    \ },
    \ 'tab': {
    \   'active': ['tabnum', 'filename', 'modified'],
    \   'inactive': ['tabnum', 'modified'],
    \ },
    \ 'component': {
    \   'readonly': '%{&readonly?"":""}',
    \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
    \   'buffericon': '',
    \   'tabicon': '',
    \ },
    \ 'component_expand': {
    \   'filetype': 'DeviconsType',
    \   'fileformat': 'DeviconsFileFormat',
    \   'buffercurrent': 'lightline#buffer#buffercurrent',
    \   'bufferbefore': 'lightline#buffer#bufferbefore',
    \   'bufferafter': 'lightline#buffer#bufferafter',
    \ },
    \ 'component_type': {
    \   'buffercurrent': 'tabsel',
    \   'bufferbefore': 'raw',
    \   'bufferafter': 'raw',
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '', 'right': '' },
  \ }
   " \ 'component': {
   " \   'separator': '',
   " \ },

function! DeviconsFileType()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! DeviconsFileFormat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

let g:lightline_buffer_logo = ' '
let g:lightline_buffer_readonly_icon = ''
let g:lightline_buffer_modified_icon = '✭'
let g:lightline_buffer_git_icon = ' '
let g:lightline_buffer_ellipsis_icon = '…'
let g:lightline_buffer_expand_left_icon = '◀ '
let g:lightline_buffer_expand_right_icon = ' ▶'
let g:lightline_buffer_active_buffer_left_icon = ''
let g:lightline_buffer_active_buffer_right_icon = ''
"let g:lightline_buffer_separator_icon = '  '
let g:lightline_buffer_separator_icon = '|'

" enable devicons, only support utf-8
" require <https://github.com/ryanoasis/vim-devicons>
let g:lightline_buffer_enable_devicons = 1
" lightline-buffer function settings
let g:lightline_buffer_show_bufnr = 1
" :help filename-modifiers
let g:lightline_buffer_fname_mod = ':t'
" hide buffer list
let g:lightline_buffer_excludes = ['vimfiler']
" max file name length
let g:lightline_buffer_maxflen = 30
" max file extension length
let g:lightline_buffer_maxfextlen = 3
" min file name length
let g:lightline_buffer_minflen = 16
" min file extension length
let g:lightline_buffer_minfextlen = 3
" reserve length for other component (e.g. info, close)
let g:lightline_buffer_reservelen = 20

let g:taboo_tabline = 0
let g:taboo_tab_format = '%n'

" ==============================================================================
"                                     vimwiki
" ==============================================================================
let work_wiki = {}
let personal_wiki = {}

let g:vimwiki_conceallevel = 2

autocmd FileType vimwiki map <leader>dd :VimwikiMakeDiaryNote<CR>
autocmd FileType vimwiki map <leader>dg :VimwikiDiaryGenerateLinks<CR>
autocmd FileType vimwiki map <leader>di :VimwikiDiaryIndex<CR>
autocmd FileType vimwiki map <leader>c :call ToggleCalendar()<CR>
autocmd Filetype vimwiki map >> <Plug>VimwikiIncreaseLvlSingleItem
" autocmd Filetype vimwiki map >>> <Plug>VimwikiIncreaseLvlWholeItem
autocmd Filetype vimwiki map << <Plug>VimwikiDecreaseLvlSingleItem
" autocmd Filetype vimwiki map <<< <Plug>VimwikiDecreaseLvlWholeItem
" indentLine overrides conceal settings and interferes with vimwiki
autocmd FileType vimwiki let g:indentLine_concealcursor = ''
autocmd FileType vimwiki let g:indentLine_conceallevel = 2

" --------
" Calendar
" --------
function! ToggleCalendar()
  execute ":Calendar"
  if exists("g:calendar_open")
    if g:calendar_open ==? 1
      execute "q"
      unlet g:calendar_open
    else
      g:calendar_open = 1
    end
  else
    let g:calendar_open = 1
  end
endfunction

" ==============================================================================
"                                   tagbar
" ==============================================================================
nmap <F8> :TagbarToggle<CR>

" ==============================================================================
"                                   calendar
" ==============================================================================
let g:calendar_frame = 'default'
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

" ==============================================================================
"                                 vim-markdown
" ==============================================================================
let g:vim_markdown_math=1
let g:vim_markdown_frontmatter=1

" ==============================================================================
"                                 vim-easy-align
" ==============================================================================
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


" ==============================================================================
"                                  vim-gitgutter
" ==============================================================================

let g:gitgutter_highlight_lines = 1
let g:gitgutter_grep = 'rg'
