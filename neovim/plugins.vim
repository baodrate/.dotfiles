" ==============================================================================
"                                 Multiple-Cursors
" ==============================================================================
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
let g:multi_cursor_exit_from_insert_mode=0
" ==============================================================================
"                                     ctrl-p
" ==============================================================================
"" let g:ctrlp_map = '<c-p>'
"" let g:ctrlp_cmd = 'CtrlP'
"" " 'c' - the directory of the current file.
"" " 'r' - the nearest ancestor that contains one of these directories or files:
"" "       .git .hg .svn .bzr _darcs
"" " 'a' - like c, but only if the current working directory outside of CtrlP is
"" "       not a direct ancestor of the directory of the current file.
"" let g:ctrlp_working_path_mode = 'ra'
"" let g:ctrlp_custom_ignore = {
""   \ 'dir':  '\v[\/]\.(git|hg|svn)$',
""   \ 'file': '\v\.(exe|so|dll)$',
""   \ }
" ==============================================================================
"                                   YouCompleteMe
" ==============================================================================
"" let g:ycm_global_ycm_extra_conf         = "~/.vim/.ycm_extra_conf.py"
"" let g:EclimCompletionMethod             = 'omnifunc'
"" let g:ycm_confirm_extra_conf            = "0"
"" let g:ycm_always_populate_location_list = 1
" ==============================================================================
"                                     Syntastic
" ==============================================================================
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" ==============================================================================
"                                     neomake
" ==============================================================================
let g:neomake_echo_current_error = 1
let g:neomake_verbose = 1
autocmd! BufReadPost,BufWritePost *.rs Neomake! cargo
autocmd! BufReadPost,BufWritePost * Neomake
" ==============================================================================
"                                     Deoplete
" ==============================================================================
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#max_list = 50
" let g:deoplete#disable_auto_complete = 1
" better completion menu
inoremap <silent><expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "<Tab>"
" set completeopt=menu,longest,preview,noinsert
set completeopt=menu,preview
" ==============================================================================
"                                     Racer
" ==============================================================================
let $RUST_SRC_PATH = getcwd()
" ==============================================================================
"                                   rust.vim
" ==============================================================================
" let g:rustfmt_autosave = 1
" ==============================================================================
"                                   neocomplcache
" ==============================================================================
"" " Disable AutoComplPop.
"" let g:acp_enableAtStartup = 0
"" " Use neocomplcache.
"" let g:neocomplcache_enable_at_startup = 1
"" " Use smartcase.
"" let g:neocomplcache_enable_smart_case = 1
"" " Set minimum syntax keyword length.
"" let g:neocomplcache_min_syntax_length = 3
"" let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
"" 
"" " Recommended key-mappings.
"" " <CR>: close popup and save indent.
"" inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"" function! s:my_cr_function()
""   return neocomplcache#smart_close_popup() . "\<CR>"
""   " For no inserting <CR> key.
""   "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
"" endfunction
"" " <TAB>: completion.
"" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"" " <C-h>, <BS>: close popup and delete backword char.
"" inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
"" inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"" inoremap <expr><C-y>  neocomplcache#close_popup()
"" inoremap <expr><C-e>  neocomplcache#cancel_popup()
"" 
"" " Enable omni completion.
"" autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"" autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"" autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"" 
"" " Enable heavy omni completion.
"" if !exists('g:neocomplcache_force_omni_patterns')
""   let g:neocomplcache_force_omni_patterns = {}
"" endif
"" let g:neocomplcache_force_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"" let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"" let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
" ==============================================================================
"                                     lightline
" ==============================================================================
let g:airline_theme='bubblegum'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
" ==============================================================================
"                                     lightline
" ==============================================================================
"" let g:lightline = {
""       \ 'colorscheme': 'gruvbox',
""       \ 'mode_map': { 'c': 'NORMAL' },
""       \ 'active': {
""       \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
""       \ },
""       \ 'component_function': {
""       \   'modified': 'LightLineModified',
""       \   'readonly': 'LightLineReadonly',
""       \   'fugitive': 'LightLineFugitive',
""       \   'filename': 'LightLineFilename',
""       \   'fileformat': 'LightLineFileformat',
""       \   'filetype': 'LightLineFiletype',
""       \   'fileencoding': 'LightLineFileencoding',
""       \   'mode': 'LightLineMode',
""       \ },
""       \ 'separator': { 'left': '⮀', 'right': '⮂' },
""       \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
""       \ }
""
"" function! LightLineModified()
""   return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
"" endfunction
""
"" function! LightLineReadonly()
""   return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
"" endfunction
""
"" function! LightLineFilename()
""   return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
""         \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
""         \  &ft == 'unite' ? unite#get_status_string() :
""         \  &ft == 'vimshell' ? vimshell#get_status_string() :
""         \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
""         \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
"" endfunction
""
"" function! LightLineFugitive()
""   if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
""     let _ = fugitive#head()
""     return strlen(_) ? '⭠ '._ : ''
""   endif
""   return ''
"" endfunction
""
"" function! LightLineFileformat()
""   return winwidth(0) > 70 ? &fileformat : ''
"" endfunction
""
"" function! LightLineFiletype()
""   return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
"" endfunction
""
"" function! LightLineFileencoding()
""   return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
"" endfunction
""
"" function! LightLineMode()
""   return winwidth(0) > 60 ? lightline#mode() : ''
"" endfunction
"" set noshowmode

" ==============================================================================
"                                     vimwiki
" ==============================================================================
let wiki_1 = {}
let wiki_1.path = '~/school.wiki/'
let wiki_1.index = 'Home'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'
let wiki_1.nested_syntaxes = {'python': 'python', 'c++': 'cpp'}
let wiki_2 = {}
let wiki_2.path = '~/project_docs/'
let wiki_2.index = 'main'
let g:vimwiki_list = [wiki_1, wiki_2]
let g:vimwiki_ext2syntax = {'.md': 'markdown',
                          \ '.mkd': 'markdown',
                          \ '.wiki': 'media'}
" ==============================================================================
"                                   NERDTree
" ==============================================================================
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }
map <C-m> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
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
"                                   terminal
" ==============================================================================
" switch in and out of terminal window
tnoremap <F12> <C-\><C-n><C-w><C-p>
set switchbuf+=useopen
function! TermEnter()
  let bufcount = bufnr("$")
  let currbufnr = 1
  let nummatches = 0
  let firstmatchingbufnr = 0
  while currbufnr <= bufcount
    if(bufexists(currbufnr))
      let currbufname = bufname(currbufnr)
      if(match(currbufname, "term://") > -1)
        echo currbufnr . ": ". bufname(currbufnr)
        let nummatches += 1
        let firstmatchingbufnr = currbufnr
        break
      endif
    endif
    let currbufnr = currbufnr + 1
  endwhile
  if(nummatches >= 1)
    execute ":sbuffer ". firstmatchingbufnr
    startinsert
  else
    execute ":terminal"
  endif
endfunction
map <F12> :call TermEnter()<CR>
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
