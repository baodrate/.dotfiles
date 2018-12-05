" ==============================================================================
"                                     Mappings
" ==============================================================================
" Leader
let mapleader="\<Space>"

" Window controls
nmap <silent> \ <C-W>
tnoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-h> <C-\><C-N><C-w>h
nnoremap <C-h> <C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-j> <C-\><C-N><C-w>j
nnoremap <C-j> <C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-k> <C-\><C-N><C-w>k
nnoremap <C-k> <C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
inoremap <C-l> <C-\><C-N><C-w>l
nnoremap <C-l> <C-w>l

tnoremap <C-,> <C-\><C-N>
inoremap <C-,> <C-\><C-N>

tnoremap <C-M-q> <C-\><C-N><C-w>q
inoremap <C-M-q> <C-\><C-N><C-w>q
nnoremap <C-M-q> <C-w>q
tnoremap <C-M-c> <C-\><C-N><C-w>c
inoremap <C-M-c> <C-\><C-N><C-w>c
nnoremap <C-M-c> <C-w>c

tnoremap <C-M-s> <C-\><C-N><C-w>s
inoremap <C-M-s> <C-\><C-N><C-w>s
nnoremap <C-M-s> <C-w>s

tnoremap <C-M-v> <C-\><C-N><C-w>v
inoremap <C-M-v> <C-\><C-N><C-w>v
nnoremap <C-M-v> <C-w>v

tnoremap <C-M-h> <C-\><C-N>:tabprev<CR>
inoremap <C-M-h> <C-\><C-N>:tabprev<CR>
nnoremap <C-M-h> :tabprev<CR>
tnoremap <C-M-l> <C-\><C-N>:tabnext<CR>
inoremap <C-M-l> <C-\><C-N>:tabnext<CR>
nnoremap <C-M-l> :tabnext<CR>

" buffer controls
tnoremap <C-M-j> <C-\><C-N>:bn<CR>
inoremap <C-M-j> <C-\><C-N>:bn<CR>
nnoremap <C-M-j> :bn<CR>

tnoremap <C-M-k> <C-\><C-N>:bp<CR>
inoremap <C-M-k> <C-\><C-N>:bp<CR>
nnoremap <C-M-k> :bp<CR>

" delete buffer
" use 'qpkorr/vim-bufkill' to move through/delete buffers withouut closing splits
tnoremap <C-M-q> <C-\><C-N>:BD<CR>
inoremap <C-M-q> <C-\><C-N>:BD<CR>
nnoremap <C-M-q> :BD<CR>

" Folding
nnoremap <leader><Space> za

" Make Y behave like D and C
nmap Y y$
" https://ddrscott.github.io/blog/2016/yank-without-jank/
vnoremap <expr>y "my\"" . v:register . "y`y"

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
