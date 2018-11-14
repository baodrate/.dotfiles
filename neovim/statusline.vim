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

" Syntax highlighting
highlight default link StatusLineText DiffChange
highlight default link StatusLineTextBold CursorLineNr
highlight default link StatusLineRed DiffDelete
highlight default link StatusLineBlue DiffText
highlight default link StatusLineGreen DiffAdd

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
  return get(s:mode_labels, active_mode, active_mode)
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
    return l:git_branch . '' . SignifyStatus() . ' '
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
set statusline+=%#StatusLineText#«\ %*
set statusline+=%#StatusLineText#%{GitStatus()}
set statusline+=%#StatusLineBlue#%{ShowMode('','i')}
set statusline+=%#StatusLineRed#%{ShowMode('i','')}
set statusline+=%#StatusLineText#\ »\ %*
set statusline+=%#StatusLineRed#%{ReadOnly()}         " readonly flag
set statusline+=%#StatusLineBlue#%h                   " help buffer flag
set statusline+=%#StatusLineBlue#%w                   " preview window flag
set statusline+=%#StatusLineGreen#%t                  " short filename
set statusline+=%#StatusLineTextBold#%m               " modified flag
set statusline+=\ %<                                  " truncate starting here
                                                      " filename
set statusline+=%#StatusLineText#%{&buftype!='terminal'?(strlen(expand('%:h'))?'›\ '.expand('%:h').'/':''):''}
set statusline+=%=
set statusline+=%#StatusLineText#\ %{LinterStatus()}      " ALE status
set statusline+=%#StatusLineText#\ %2p%%                  " current line percentage
set statusline+=%#StatusLineText#｢%l:%c｣                  " current line/column number
set statusline+=\ «\ %#StatusLineGreen#%{(strlen(&filetype)?WebDevIconsGetFileTypeSymbol().'\ '.&filetype:'[-]')}
set statusline+=%#LineNr#\ »
