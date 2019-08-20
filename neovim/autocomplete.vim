" ==============================================================================
"                             LanguageClient-neovim
" ===============================================================================
" Automatically start language servers.
let g:LanguageClient_autoStart = 1

let g:LanguageClient_serverCommands = {
    \ 'c': ['cquery', '--log-file', '~/tmp/lc-nvim/cc.log', '--init={"cacheDirectory":"~/.cache/cquery/"}'],
    \ 'cpp': ['cquery', '--log-file', '~/tmp/lc-nvim/cc.log', '--init={"cacheDirectory":"~/.cache/cquery/"}'],
    \ 'cuda': ['cquery', '--log-file', '~/tmp/lc-nvim/cc.log', '--init={"cacheDirectory":"~/.cache/cquery/"}'],
    \ 'objc': ['cquery', '--log-file', '~/tmp/lc-nvim/cc.log', '--init={"cacheDirectory":"~/.cache/cquery/"}'],
    \ 'python': ['pyls', '--log-file', '~/tmp/lc-nvim/pyls.log', '-v'],
    \ }
"   \ 'vue': ['vls'],

let g:LanguageClient_loadSettings = 1 " Use an absolute configuration path if you want system-wide settings

" https://github.com/autozimu/LanguageClient-neovim/issues/379 LSP snippet is not supported
let g:LanguageClient_hasSnippetSupport = 0

" nnoremap <F5> :call LanguageClient_contextMenu()<CR>

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

" augroup LSP
"   autocmd!
"   autocmd FileType cpp,c,python call SetLSPShortcuts()
" augroup END

" ==============================================================================
"                                      ncm2
" ==============================================================================
" " enable ncm2 for all buffers
" autocmd BufEnter * call ncm2#enable_for_buffer()

" " Affects the visual representation of what happens after you hit <C-x><C-o>
" " https://neovim.io/doc/user/insert.html#i_CTRL-X_CTRL-O
" " https://neovim.io/doc/user/options.html#'completeopt'
" "
" " This will show the popup menu even if there's only one match (menuone),
" " prevent automatic selection (noselect) and prevent automatic text injection
" " into the current line (noinsert).
" " :help Ncm2PopupOpen for more information
" " set completeopt=noinsert,menuone,noselect
" au User Ncm2PopupOpen set completeopt=menuone,noselect,noinsert
" au User Ncm2PopupClose set completeopt=menuone

" call ncm2#override_source('LanguageClient_python', {'enable': 0})

" " When the <Enter> key is pressed while the popup menu is visible, it only
" " hides the menu. Use this mapping to close the menu and also start a new
" " line.
" " inoremap <expr> <CR> pumvisible() ? '\<c-y>\<cr>' : '\<CR>'

" " Use <TAB> to select the popup menu:
" inoremap <expr> <Tab> pumvisible() ? '\<C-n>' : '\<Tab>'
" inoremap <expr> <S-Tab> pumvisible() ? '\<C-p>' : '\<S-Tab>'

" inoremap <expr> <CR> pumvisible() ? '\<C-y>' : '\<CR>'

" ==============================================================================
"                                       ale
" ==============================================================================
" let g:ale_fixers = {
" \   '*': ['remove_trailing_lines', 'trim_whitespace'],
" \   'python': ['black'],
" \   'javascript': ['eslint'],
" \}

" let g:ale_linter_aliases = {
" \   'vue': ['javascript', 'css'],
" \}

" let g:ale_linters = {
" \   'python': ['pylint'],
" \   'c': ['clangd', 'clangcheck', 'clangtidy'],
" \   'cpp': ['clangd', 'clangcheck', 'clangtidy'],
" \   'javascript': ['eslint'],
" \   'css': ['stylelint'],
" \   'vue': ['eslint']
" \}
" "\   'vue': ['vls'],
" let g:ale_linters_explicit = 1

" let g:ale_python_auto_pipenv = 1

" let g:ale_set_highlights = 1
" let g:ale_fix_on_save = 1
" " let g:ale_sign_error = '>>'
" " let g:ale_sign_warning = '--'
" let g:ale_set_signs = 1
" let g:ale_sign_error = '!'
" let g:ale_sign_warning = '⚠'

" call g:Base16hi('ALEErrorSign', g:base16_gui09, g:base16_gui01, g:base16_cterm09, g:base16_cterm01, 'bold')
" call g:Base16hi('ALEWarningSign', g:base16_gui0A, g:base16_gui01, g:base16_cterm0A, g:base16_cterm01, 'bold')
"" call g:Base16hi('ALEErrorLine', g:base16_gui09, g:base16_gui00, g:base16_cterm09, g:base16_cterm00, 'undercurl')
"" call g:Base16hi('ALEWarningLine', g:base16_gui0A, g:base16_gui00, g:base16_cterm0A, g:base16_cterm00, 'undercurl')
" call g:Base16hi('ALEError', g:base16_gui09, g:base16_gui00, g:base16_cterm09, g:base16_cterm00, 'undercurl,bold')
" call g:Base16hi('ALEWarning', g:base16_gui0A, g:base16_gui00, g:base16_cterm0A, g:base16_cterm00, 'undercurl,bold')
" " hi link ALEErrorSign    Error
" " hi link ALEWarningSign  Warning
" " hi link ALEErrorLine    Error
" " hi link ALEWarningLine  WarningMsg

" let g:ale_completion_enabled = 1

" function! LinterStatus() abort
"     let l:counts = ale#statusline#Count(bufnr(''))

"     let l:all_errors = l:counts.error + l:counts.style_error
"     let l:all_non_errors = l:counts.total - l:all_errors

"     return l:counts.total == 0 ? 'OK' : printf(
"     \   '%dW %dE',
"     \   all_non_errors,
"     \   all_errors
"     \)
" endfunction

" ==============================================================================
"                                       coc
" ==============================================================================
" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
" set signcolumn=yes
set signcolumn=auto

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" use <tab> for trigger completion and navigate to next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <Tab> and <S-Tab> for navigate completion list:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" Close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType python,javascript,typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
