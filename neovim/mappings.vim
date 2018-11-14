" ==============================================================================
"                                     Mappings
" ==============================================================================
" Leader
let mapleader="\<Space>"

" Window controls
nmap <silent> \ <C-W>
tnoremap <M-h> <C-\><C-N><C-w>h
tnoremap <M-j> <C-\><C-N><C-w>j
tnoremap <M-k> <C-\><C-N><C-w>k
tnoremap <M-l> <C-\><C-N><C-w>l
inoremap <M-h> <C-\><C-N><C-w>h
inoremap <M-j> <C-\><C-N><C-w>j
inoremap <M-k> <C-\><C-N><C-w>k
inoremap <M-l> <C-\><C-N><C-w>l
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

tnoremap <M-q> <C-\><C-N><C-w>q
inoremap <M-q> <C-\><C-N><C-w>q
nnoremap <M-q> <C-w>q
tnoremap <M-c> <C-\><C-N><C-w>c
inoremap <M-c> <C-\><C-N><C-w>c
nnoremap <M-c> <C-w>c
tnoremap <M-s> <C-\><C-N><C-w>s
inoremap <M-s> <C-\><C-N><C-w>s
nnoremap <M-s> <C-w>s
tnoremap <M-v> <C-\><C-N><C-w>v
inoremap <M-v> <C-\><C-N><C-w>v
nnoremap <M-v> <C-w>v

tnoremap <M-,> <C-\><C-N>
inoremap <M-,> <C-\><C-N>

tnoremap <C-l> <C-\><C-N>:tabnext<CR>
inoremap <C-l> <C-\><C-N>:tabnext<CR>
nnoremap <C-l> :tabnext<CR>
tnoremap <C-h> <C-\><C-N>:tabprev<CR>
inoremap <C-h> <C-\><C-N>:tabprev<CR>
nnoremap <C-h> :tabprev<CR>

tnoremap <C-j> <C-\><C-N>:bnext<CR>
inoremap <C-j> <C-\><C-N>:bnext<CR>
nnoremap <C-j> :bnext<CR>
tnoremap <C-k> <C-\><C-N>:bprev<CR>
inoremap <C-k> <C-\><C-N>:bprev<CR>
nnoremap <C-k> :bprev<CR>

tnoremap <C-q> <C-\><C-N>:bdelete<CR>
inoremap <C-q> <C-\><C-N>:bdelete<CR>
nnoremap <C-q> :bdelete<CR>

" Folding
nnoremap <leader><Space> za

" Make Y behave like D and C
:map Y y$

" Insert timestamp
nmap <F3> O<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>yyp0v$r=j
imap <F3> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>yyp0v$r=o

if has('nvim')
  autocmd TermOpen,BufEnter,WinEnter term://* startinsert
else
  autocmd BufEnter,WinEnter term://* startinsert
endif

" ==============================================================================
"                             LanguageClient-neovim
" ==============================================================================
" nnoremap <F5> :call LanguageClient_contextMenu()<CR>
"
" nnoremap <silent> K :call LanguageClient#textDocument_hover()<cr>
" nnoremap <silent> <C-b> :call LanguageClient#textDocument_definition()<cr>
" nnoremap <silent> <F12> :call LanguageClient#textDocument_references({'includeDeclaration': v:false})<cr>
" nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
"
"
" nnoremap <silent> gh :call LanguageClient_textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
" nnoremap <silent> gr :call LanguageClient_textDocument_references()<CR>
" nnoremap <silent> gs :call LanguageClient_textDocument_documentSymbol()<CR>
" nnoremap <silent> gf :call LanguageClient_textDocument_formatting()<CR>

" ==============================================================================
"                                   ALE
" ==============================================================================
" Bind F8 to fixing problems with ALE
" nmap <F8> <Plug>(ale_fix)

" nmap <silent> <C-n> <Plug>(ale_previous_wrap)
" nmap <silent> <C-p> <Plug>(ale_next_wrap)

"" <Plug>(ale_find_references)
"" <Plug>(ale_go_to_definition)
"" <Plug>(ale_go_to_definition_in_tab)
"" <Plug>(ale_hover)
"" <Plug>(ale_lint)
"" <Plug>(ale_previous)
"" <Plug>(ale_previous_wrap)
"" <Plug>(ale_next)
"" <Plug>(ale_next_wrap)
"" <Plug>(ale_first)
"" <Plug>(ale_last)
""
"" <Plug>(ale_toggle)
"" <Plug>(ale_enable)
"" <Plug>(ale_disable)
"" <Plug>(ale_toggle_buffer)
"" <Plug>(ale_enable_buffer)
"" <Plug>(ale_disable_buffer)
""
"" <Plug>(ale_detail)
"" <Plug>(ale_reset)
"" <Plug>(ale_reset_buffer)

" ==============================================================================
"                                 Multiple-Cursors
" ==============================================================================
" let g:multi_cursor_use_default_mapping=0
" let g:multi_cursor_next_key='<C-n>'
" let g:multi_cursor_prev_key='<C-p>'
" let g:multi_cursor_skip_key='<C-x>'
" let g:multi_cursor_quit_key='<Esc>'
" let g:multi_cursor_exit_from_insert_mode=0
