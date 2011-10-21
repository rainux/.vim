if has("gui_macvim")
  " Define a font list for MacOS with corresponding winsize and winpos arguments list
  let s:GuiFontList = [
        \"Monaco:h12",
        \"Bitstream\\ Vera\\ Sans\\ Mono\\ 11",
        \"DejaVu\\ Sans\\ Mono\\ 11",
        \"Inconsolat1\\ 11",
        \]

  let s:WinSizeList = [
        \[138, 43],
        \[138, 43],
        \[138, 43],
        \[138, 43]
        \]

  let s:WinPosList  = [
        \[5, 50],
        \[5, 50],
        \[5, 50],
        \[5, 50]
        \]
end

if has("gui_gtk2")
  " Define a font list for GTK2 with corresponding winsize and winpos arguments list
  let s:GuiFontList = [
        \"Monaco\\ 13",
        \"Bitstream\\ Vera\\ Sans\\ Mono\\ 11",
        \"DejaVu\\ Sans\\ Mono\\ 11",
        \"Inconsolat1\\ 11",
        \]

  let s:WinSizeList = [
        \[130, 38],
        \[130, 38],
        \[130, 38],
        \[130, 38]
        \]

  let s:WinPosList  = [
        \[0, 30],
        \[0, 30],
        \[0, 30],
        \[0, 30]
        \]
end

if has("gui_win32")
  " Define a font list for Win32 with corresponding winsize and winpos arguments list
  let s:GuiFontList = [
        \"Monaco:h10",
        \"SimSun:h11",
        \"Courier_New:h12",
        \"Bitstream_Vera_Sans_Mono:h11",
        \"Fixedsys:h11",
        \"Lucida_Console:h11",
        \"Terminal:h12:cGB2312"
        \]

  let s:WinSizeList = [
        \[256, 64],
        \[256, 64],
        \[256, 64],
        \[256, 64],
        \[256, 64],
        \[256, 64],
        \[256, 64]
        \]

  let s:WinPosList  = [
        \[9, -4],
        \[9, -4],
        \[9, -4],
        \[9, -4],
        \[9, -4],
        \[6, -4],
        \[9, -4]
        \]
end

" Set default index to 0
if !exists("g:CUR_FONT_INDEX") || g:CUR_FONT_INDEX < 0 || g:CUR_FONT_INDEX >= len(s:GuiFontList)
  let g:CUR_FONT_INDEX = 0
endif

" Set GUI font by index
function! s:SetGuiFont(Index)
  try
    execute 'set guifont=' . s:GuiFontList[a:Index]
  catch
    return 1
  endtry
endfunction

function! s:SetWinSize(Index)
  execute 'winsize ' . s:WinSizeList[a:Index][0] . ' ' .
        \ s:WinSizeList[a:Index][1]
endfunction

" Set window pos by index
function! s:SetWinPos(Index)
  let WinPosX = s:WinPosList[a:Index][0]
  let WinPosY = s:WinPosList[a:Index][1]
  if WinPosX != getwinposx() || WinPosY != getwinposy()
    execute 'winpos ' . WinPosX . ' ' . WinPosY
  endif
endfunction


function! GuiTabLabel()
  let label = v:lnum . '. '

  " Append the number of windows in the tab page if more than one
  let wincount = tabpagewinnr(v:lnum, '$')
  if wincount > 1
    let label .= wincount . ' '
  endif

  " Add '+' if one of the buffers in the tab page is modified
  let bufnrlist = tabpagebuflist(v:lnum)
  for bufnr in bufnrlist
    if getbufvar(bufnr, "&modified")
      let label .= '+ '
      break
    endif
  endfor

  " Append the buffer name
  return label . fnamemodify(bufname(bufnrlist[tabpagewinnr(v:lnum) - 1]), ':t')
endfunction


set guitablabel=%{GuiTabLabel()}

" Initialize GUI font and window settings
call s:SetGuiFont(g:CUR_FONT_INDEX)
call s:SetWinSize(g:CUR_FONT_INDEX)
" Only effect when reload .vimrc
call s:SetWinPos(g:CUR_FONT_INDEX)
" Add to some event so they can auto execute when need
if has("autocmd")
  autocmd GUIEnter * call s:SetWinPos(g:CUR_FONT_INDEX)
endif


" ----------------------------------------------------------------------------
" Key mappings
"
" F8 is Change GUI font
map <F8> :call <SID>ChangeGuiFont(0)<CR>
imap <F8> <Esc><F8>a

function! s:ChangeGuiFont(Inverse)
  let OldIndex = g:CUR_FONT_INDEX
  if a:Inverse == 0
    let g:CUR_FONT_INDEX = g:CUR_FONT_INDEX + 1
    if g:CUR_FONT_INDEX >= len(s:GuiFontList)
      let g:CUR_FONT_INDEX = 0
    endif
  else
    let g:CUR_FONT_INDEX = g:CUR_FONT_INDEX - 1
    if g:CUR_FONT_INDEX < 0
      let g:CUR_FONT_INDEX = len(s:GuiFontList) - 1
    endif
  endif
  " Here we use &tenc that set above to ensure the system locale
  if s:SetGuiFont(g:CUR_FONT_INDEX) == 0
    call s:SetWinSize(g:CUR_FONT_INDEX)
    call s:SetWinPos(g:CUR_FONT_INDEX)
    echo iconv("\rGUI font has changed to \"" .
          \ s:GuiFontList[g:CUR_FONT_INDEX] . '"', &tenc, &enc)
  else
    call s:SetWinSize(OldIndex)
    call s:SetWinPos(OldIndex)
    echohl ErrorMsg | echo iconv("\rError changing GUI font. Maybe selected font \"" .
          \ s:GuiFontList[g:CUR_FONT_INDEX] . "\" not exists.", &tenc, &enc)
          \ | echohl None
  endif
endfunction

" F11 is Toggle wrap
map <F11> :call <SID>ToggleGuiOption("b")<CR>:set wrap!<CR>
imap <F11> <Esc><F11>a

function! s:ToggleGuiOption(option)
  " If a:option is already set in guioptions, then we want to remove it
  if match(&guioptions, "\\C" . a:option) > -1
    exec "set go-=" . a:option
  else
    exec "set go+=" . a:option
  endif
  if has("gui_running")
    call s:SetWinPos(g:CUR_FONT_INDEX)
  endif
endfunction
