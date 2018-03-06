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
"                                     Syntastic
" ==============================================================================
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" ==============================================================================
"                                     neomake
" ==============================================================================
if has('nvim') || v:version >= 800
  let g:neomake_echo_current_error = 1
  let g:neomake_verbose = 1
  " Run neomake when writing a buffer
  call neomake#configure#automake('w')
endif

" ==============================================================================
"                                     Deoplete
" ==============================================================================
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#max_list = 50
" let g:deoplete#disable_auto_complete = 1

" set completeopt=menu,longest,preview,noinsert
set completeopt=menu,preview

" vimtex
" ------
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete

" ==============================================================================
"                                     Racer
" ==============================================================================
if g:os ==? 'Linux' || g:os ==? 'Darwin'
  let g:racer_cmd = "/usr/local/bin/racer"
elseif g:os ==? 'Windows'
  throw 'configure windows path to racer in .config/nvim/plugins.vim'
endif

" ==============================================================================
"                                   rust.vim
" ==============================================================================
let g:rustfmt_autosave = 1

" ==============================================================================
"                                     airline
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
"                                     vimwiki
" ==============================================================================
let work_wiki = {}
let personal_wiki = {}

if g:os == 'Windows'
  let work_network_share_path = 'H:\'
elseif g:os == 'Linux'
  let work_network_share_path = '/mnt/h/'
elseif g:os == 'Darwin'
  let work_network_share_path = '/Volumes/usershare/baot/'
endif

let work_wiki.path = work_network_share_path . 'wiki'
let personal_wiki.path = '~/.journal'

let g:vimwiki_list = [work_wiki, personal_wiki]

let g:vimwiki_conceallevel = 2

autocmd FileType vimwiki map <leader>d :VimwikiMakeDiaryNote<CR>
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
    if g:calendar_open == 1
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
