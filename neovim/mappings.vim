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

" Folding
nnoremap <leader><Space> za

" Make Y behave like D and C
:map Y y$

" Insert timestamp
nmap <F3> i<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>yyp0v$r=o<Esc>
imap <F3> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>yyp0v$r=o<Esc>

if has('nvim')
  autocmd TermOpen,BufEnter,WinEnter term://* startinsert
else
  autocmd BufEnter,WinEnter term://* startinsert
endif
