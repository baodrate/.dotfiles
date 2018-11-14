" ==============================================================================
"                             LanguageClient-neovim
" ===============================================================================
" Always draw the signcolumn.
set signcolumn=yes

let g:LanguageClient_serverCommands = {
    \ 'c': ['cquery', '--log-file=~/tmp/cc.log', '--init={"cacheDirectory":"~/.cache/cquery/"}'],
    \ 'cpp': ['cquery', '--log-file=~/tmp/cc.log', '--init={"cacheDirectory":"~/.cache/cquery/"}'],
    \ 'cuda': ['cquery', '--log-file=~/tmp/cc.log', '--init={"cacheDirectory":"~/.cache/cquery/"}'],
    \ 'objc': ['cquery', '--log-file=~/tmp/cc.log', '--init={"cacheDirectory":"~/.cache/cquery/"}'],
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

function! SetLSPShortcuts()
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


