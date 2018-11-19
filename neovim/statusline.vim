" labels for modes
" Dictionary: take mode() input -> longer notation of current mode
" mode() is defined by Vim
let s:mode_labels={
  \ 'n' : 'Normal', 'no' : 'N·Operator Pending', 'v' : 'Visual',
  \ 'V' : 'V·Line', '^V' : 'V·Block', 's' : 'Select', 'S': 'S·Line',
  \ '^S' : 'S·Block', 'i' : 'Insert', 'R' : 'Replace', 'Rv' : 'V·Replace',
  \ 'c' : 'Command', 'cv' : 'Vim Ex', 'ce' : 'Ex', 'r' : 'Prompt',
  \ 'rm' : 'More', 'r?' : 'Confirm', '!' : 'Shell', 't' : 'Terminal'
  \ }

" based on https://github.com/itchyny/lightline.vim/issues/99#issuecomment-354711002
function! SignifyStatus()
  let [added, modified, removed] = sy#repo#get_stats()
  let l:sy = ''
  for [flag, flagcount] in [
    \   [exists("g:signify_sign_add")?g:signify_sign_add:'+', added],
    \   [exists("g:signify_sign_delete")?g:signify_sign_delete:'-', removed],
    \   [exists("g:signify_sign_change")?g:signify_sign_change:'!', modified]
    \ ]
    if flagcount> 0
      let l:sy .= printf('%s%d', flag, flagcount)
    endif
  endfor

  if strlen(l:sy)
    return l:sy
  endif
  return ''
endfunction

function! g:DeviconsFileType()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! g:DeviconsFileFormat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

let g:vem_tabline_multiwindow_mode = 0
let g:vem_tabline_show = 2 " always show even if only one tab/buffer open

" unused because of 'pacha/vem-tabline'
" set showtabline=2
" from: https://www.reddit.com/r/vim/comments/22ala7/vim_custom_tabline/cglbh6b/
" if exists("+showtabline")
if 0
  " Rename tabs to show tab number.
  " (Based on http://stackoverflow.com/questions/5927952/whats-implementation-of-vims-default-tabline-function)

  function! MyTabLine()
      let s = ''
      let s .= '%#TermCursorNC# '
      let s .= '%T%#TabLineFill#%='
      let t = tabpagenr()
      let i = 1
      while i <= tabpagenr('$')
          let buflist = tabpagebuflist(i)
          let winnr = tabpagewinnr(i)
          let s .= '%' . i . 'T'
          let s .= (i == t ? '%1*' : '%2*')

          " let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
          " let s .= ' '

          " TabColor:           Selected      Non-selected
          let s .= (i == t ? '%#Search#' : '%#CursorColumn#')
          let s .= ' ' . i
          let nwins = tabpagewinnr(i, '$')
          if nwins > 1
            let s .= '｢' . winnr . ':' . nwins . '｣'
          endif
          let s .= ' '

          " TabColor:         Selected      Non-selected
          let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')

          let bufnr = buflist[winnr - 1]
          let file = bufname(bufnr)
          let buftype = getbufvar(bufnr, '&buftype')

          if buftype == 'help'
              let file = 'help:' . fnamemodify(file, ':t:r')

          elseif buftype == 'quickfix'
              let file = 'quickfix'

          elseif buftype == 'nofile'
              if file =~ '\/.'
                  let file = substitute(file, '.*\/\ze.', '', '')
              endif

          else
              let file = pathshorten(fnamemodify(file, ':p:~:.'))
              if getbufvar(bufnr, '&modified')
                  let file = '+' . file
              endif

          endif

          if file == ''
              let file = '[No Name]'
          endif

          " let s .= ' ' . file

          if i < tabpagenr('$') 
            let s .= '%#TabLine#'
            if i != t-1 && i != t
              let s .= '|'
            else
              let s .= ' '
            endif
          endif
          " 'buffericon': '',

          let i = i + 1

      endwhile

      let s .= '%#TermCursorNC# '
      return s

  endfunction

  set tabline=%!MyTabLine()

endif " exists("+showtabline")


" Base16 Styling Guidelines
" https://github.com/chriskempson/base16/blob/master/styling.md
" ----
" base16-vim statusline highlights:
"   group,        guifg     guibg     ctermfg   ctermbg
"   StatusLine    base16_04 base16_02 base16_04 base16_02
"   StatusLineNC  base16_03 base16_01 base16_03 base16_01
" ----
" base00 - Default Background
" base01 - Lighter Background (Used for status bars)
" base02 - Selection Background
" base03 - Comments, Invisibles, Line Highlighting
" base04 - Dark Foreground (Used for status bars)
" base05 - Default Foreground, Caret, Delimiters, Operators
" base06 - Light Foreground (Not often used)
" base07 - Light Background (Not often used)
" base08 - Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
" base09 - Integers, Boolean, Constants, XML Attributes, Markup Link Url
" base0A - Classes, Markup Bold, Search Text Background
" base0B - Strings, Inherited Class, Markup Code, Diff Inserted
" base0C - Support, Regular Expressions, Escape Characters, Markup Quotes
" base0D - Functions, Methods, Attribute IDs, Headings
" base0E - Keywords, Storage, Selector, Markup Italic, Diff Changed
" base0F - Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>

exec "hi TabLine                     ctermfg=".g:base16_cterm04." ctermbg=".g:base16_cterm02." cterm=none"
exec "hi TabLineSel                  ctermfg=".g:base16_cterm04." ctermbg=".g:base16_cterm02." cterm=bold"
exec "hi TabLineFill                 ctermfg=".g:base16_cterm04." ctermbg=".g:base16_cterm02." cterm=none"
exec "hi VemTablineNormal            ctermfg=".g:base16_cterm04." ctermbg=".g:base16_cterm02." cterm=none"
exec "hi VemTablineShown             ctermfg=".g:base16_cterm02." ctermbg=".g:base16_cterm04." cterm=none"
exec "hi VemTablineSelected          ctermfg=".g:base16_cterm02." ctermbg=".g:base16_cterm06." cterm=bold"
exec "hi VemTablineSeparator         ctermfg=".g:base16_cterm04." ctermbg=".g:base16_cterm02." cterm=none"
exec "hi VemTablineLocation          ctermfg=".g:base16_cterm03." ctermbg=".g:base16_cterm01." cterm=none"
exec "hi VemTablineLocationSelected  ctermfg=".g:base16_cterm04." ctermbg=".g:base16_cterm02." cterm=bold"
exec "hi VemTablineTabNormal         ctermfg=".g:base16_cterm01." ctermbg=".g:base16_cterm03." cterm=none"
exec "hi VemTablineTabSelected       ctermfg=".g:base16_cterm02." ctermbg=".g:base16_cterm04." cterm=bold"


" Default StatusLine colors from base16-vim
exec "hi StatusLine    cterm=none ctermfg=".g:base16_cterm04." ctermbg=".g:base16_cterm02
exec "hi StatusLineNC  cterm=none ctermfg=".g:base16_cterm03." ctermbg=".g:base16_cterm01
" Panels
exec "hi GitPanel      cterm=bold ctermfg=".g:base16_cterm01." ctermbg=".g:base16_cterm04
exec "hi ModeVisual    cterm=bold ctermfg=".g:base16_cterm01." ctermbg=".g:base16_cterm08
exec "hi ModeInsert    cterm=bold ctermfg=".g:base16_cterm01." ctermbg=".g:base16_cterm0B
exec "hi ModeOther     cterm=bold ctermfg=".g:base16_cterm01." ctermbg=".g:base16_cterm0D
" StatusLineBrightText
exec "hi User1         cterm=bold ctermfg=".g:base16_cterm07." ctermbg=".g:base16_cterm02
" StatusLineWarning
exec "hi User9         cterm=none ctermfg=".g:base16_cterm08." ctermbg=".g:base16_cterm02
" Other
exec "hi User2         cterm=none ctermfg=".g:base16_cterm04." ctermbg=".g:base16_cterm02
exec "hi User3         cterm=none ctermfg=".g:base16_cterm04." ctermbg=".g:base16_cterm02
exec "hi User4         cterm=none ctermfg=".g:base16_cterm04." ctermbg=".g:base16_cterm02
exec "hi User5         cterm=none ctermfg=".g:base16_cterm04." ctermbg=".g:base16_cterm02
exec "hi User6         cterm=none ctermfg=".g:base16_cterm04." ctermbg=".g:base16_cterm02
exec "hi User7         cterm=none ctermfg=".g:base16_cterm04." ctermbg=".g:base16_cterm02
exec "hi User8         cterm=none ctermfg=".g:base16_cterm04." ctermbg=".g:base16_cterm02


" Function: return current mode
" abort -> function will abort soon as error detected
function! ModeCurrent() abort
    let l:modecurrent = mode()
    " use get() -> fails safely, since ^V doesn't seem to register
    " 3rd arg is used when return of mode() == 0, which is case with ^V
    " thus, ^V fails -> returns 0 -> replaced with 'V Block'
    let l:modelist = toupper(get(g:mode_labels, l:modecurrent, 'V·Block '))
    let l:current_status_mode = l:modelist
    return l:current_status_mode
endfunction

function! ShowMode(include, exclude)
  " show mode
  let active_mode = mode()
  if !empty(a:include) && stridx(a:include, active_mode) == -1
    return ''
  endif
  if !empty(a:exclude) && stridx(a:exclude, active_mode) != -1
    return ''
  endif
  return '  ' . get(s:mode_labels, active_mode, active_mode) . ' '
endfunction

function! LinterStatus() abort
   let l:counts = ale#statusline#Count(bufnr(''))
   let l:all_errors = l:counts.error + l:counts.style_error
   let l:all_non_errors = l:counts.total - l:all_errors
   return l:counts.total == 0 ? '' : printf(
   \ 'W:%d E:%d',
   \ l:all_non_errors,
   \ l:all_errors
   \)
endfunction

function! GitStatus() abort
  let l:git_branch=gitbranch#name()
  if strlen(l:git_branch)
    " git symbol alternatives: [⎇ , ]
    return strlen(l:git_branch)>0 ? '  ' . l:git_branch . SignifyStatus() . '⎇  ' : ''
  endif
  return ''
endfunction

function! ReadOnly() abort
  if &readonly || !&modifiable
    return '[]'
  else
    return ''
endfunction

set statusline=                                       " clear statusline

set statusline+=%#GitPanel#%{GitStatus()}%*
set statusline+=%#ModeVisual#%{ShowMode('^Vv','')}%*
set statusline+=%#ModeInsert#%{ShowMode('i','')}%*
set statusline+=%#ModeOther#%{ShowMode('','i^Vv')}%*
set statusline+=\ %*
set statusline+=%9*%{ReadOnly()}                      " readonly flag
set statusline+=%h%*                                  " help buffer flag
set statusline+=%w%*                                  " preview window flag
set statusline+=%1*%t%*%*                             " short filename
set statusline+=%m%*                                  " modified flag
set statusline+=\ %<                                  " truncate starting here
                                                      " filename
set statusline+=%{&buftype!='terminal'?(strlen(expand('%:h'))?'›\ '.expand('%:h').'/':''):''}
set statusline+=%=
set statusline+=\ %{LinterStatus()}      " ALE status
set statusline+=\ %2p%%                  " current line percentage
set statusline+=｢%l:%c｣                  " current line/column number
set statusline+=\ «\ %*
set statusline+=%1*%{(strlen(&filetype)?WebDevIconsGetFileTypeSymbol().'\ '.&filetype:'[-]')}%*
set statusline+=\ »
