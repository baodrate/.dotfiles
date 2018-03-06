" ==============================================================================
"                                     Mappings
" ==============================================================================
" Leader
let mapleader="\<Space>"

" Window controls
nnoremap <silent> \ <C-W>

" Folding
nnoremap <leader><Space> za

" Enable mouse in terminal mode
set mouse=a

" Make Y behave like D and C
:map Y y$

" Insert timestamp
nmap <F3> i<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>yyp0v$r=o<Esc>
imap <F3> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>yyp0v$r=o<Esc>
