" ----------------------------------------------------------------------------
" Key mappings
"
" Essential key mappsings  .............................................. {{{1
"
" Up & Down is display line upward & downward
map <Up> gk
map <Down> gj
imap <Up> <Esc><Up>a
imap <Down> <Esc><Down>a

" ,i is toggle indent style smartly
map ,i :call <SID>ToggleIndentStyle()<CR>

" ,k is Toggle iskeyword contain or not contain '_'
map ,k :call <SID>ToggleIsKeyword('_')<CR>

function! s:ToggleIsKeyword(char)
  if stridx(&iskeyword, a:char) < 0
    exec 'setlocal iskeyword+=' . a:char
    echo '&iskeyword now contain "' . a:char . '"'
  else
    exec 'setlocal iskeyword-=' . a:char
    echo '&iskeyword now not contain "' . a:char . '"'
  endif
endfunction

" ,hs is Reverse hlsearch
map ,hs :set hlsearch!<CR>

" ,tl is Toggle Tag List
map ,tl :TagbarToggle<CR>

" ,u is Toggle Gundo
map ,u :GundoToggle<CR>

" ,nt is Toggle NERDTreeTabs
map ,nt :NERDTreeTabsToggle<CR>

" ,nf is call NERDTreeFind
map ,nf :NERDTreeTabsFind<CR>

" ,sp is Toggle spell check
map ,sp :set spell!<CR>

" ,fo is Change GUI font
" Code moved to .gvimrc

" ,r is Compile and Run
map ,r :call <SID>Run()<CR>

function! s:Run()
  if exists('b:current_compiler')
    make
  endif

  let ExeFile = substitute(bufname('%'), '\.[^.]\+$', '.exe', '')
  if filereadable(ExeFile)
    if has('win32')
      execute '!.\"' . ExeFile . '"'
    else
      execute '!./"' . ExeFile . '"'
    endif
  elseif !exists('b:current_compiler')
    " Only try to execute current file as script when no CompilerSet
    if has('win32')
      execute '!.\"' . bufname('%') . '"'
    else
      execute '!./"' . bufname('%') . '"'
    endif
  endif
endfunction

" ,w is Toggle wrap
" Code moved to .gvimrc

" ,co is Compile
map ,co :call <SID>Compile()<CR>

function! s:Compile()
  if exists('b:current_compiler')
    make
  else
    echohl ErrorMsg | echo 'No CompilerSet for this type of file' | echohl None
  endif
endfunction

" CTRL-[JKHL] is jump between windows
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l

" CTRL-Tab is Next tab
map <C-Tab> gt
imap <C-Tab> <Esc>gt
cmap <C-Tab> <Esc>gt

" CTRL-SHIFT-Tab is Previous tab
map <C-S-Tab> gT
imap <C-S-Tab> <Esc>gT
cmap <C-S-Tab> <Esc>gT

" ALT-[1-9] is switch to specified tab
for i in [1, 2, 3, 4, 5, 6, 7, 8, 9]
  execute 'map <M-' . i . '> ' . i . 'gt'
  execute 'imap <M-' . i . '> <Esc>' . i . 'gt'
  execute 'cmap <M-' . i . '> <Esc>' . i . 'gt'
endfor

" ,* is Substitute(Replace)
nmap ,* :%s/<C-R><C-W>/

" ,rg is Search in files via rg
nmap ,rg :execute 'Grepper -noprompt -tool rg -query ' . input("Rg search for pattern: ", "<C-R><C-W>")<CR>

" NERD commenter mappings
nmap ,cc        <Plug>NERDCommenterComment
vmap ,cc        <Plug>NERDCommenterComment
nmap ,c<Space>  <Plug>NERDCommenterToggle
vmap ,c<Space>  <Plug>NERDCommenterToggle
nmap ,cm        <Plug>NERDCommenterMinimal
vmap ,cm        <Plug>NERDCommenterMinimal
nmap ,cs        <Plug>NERDCommenterSexy
vmap ,cs        <Plug>NERDCommenterSexy
nmap ,cn        <Plug>NERDCommenterNest
vmap ,cn        <Plug>NERDCommenterNest
nmap ,cu        <Plug>NERDCommenterUncomment
vmap ,cu        <Plug>NERDCommenterUncomment

" ,ff is format code
nmap ,ff :set ff=unix<CR>:%!fromdos<CR>gg=G:%s/\s\+$//ge<CR>

" ,fc is clean code
nmap ,fc :set ff=unix<CR>:%!fromdos<CR>:%s/\s\+$//ge<CR>

" fugitive mappings
nmap ,gac :Gcommit --amend<CR>
nmap ,gb  :Gblame<CR>
nmap ,gc  :Gcommit<CR>
nmap ,gd  :Gvdiff<CR>
nmap ,ge  :Gedit<CR>
nmap ,gg  :Ggrep<Space>
nmap ,gq  :Git checkout HEAD %<CR>
nmap ,gr  :Gread<CR>
nmap ,gs  :Gstatus<CR>
nmap ,gw  :Gwrite<CR>

" Make it easy to update/reload .vimrc
nmap ,vs :source $HOME/.vim/vimrc<CR>:source $HOME/.vim/gvimrc<CR>
nmap ,vev :tabe $HOME/.vim/vimrc<CR>
nmap ,vep :tabe $HOME/.vim/plugs.vim<CR>

" ,pi is :PlugInstall
nmap ,pi :source $HOME/.vim/plugs.vim<CR>:PlugInstall<CR>

" ,tt ,tb is activate Command-T
function! g:ProjectRoot()
  if exists('b:rails_root')
    return b:rails_root
  elseif exists('b:bundler_root')
    return b:bundler_root
  elseif exists('b:rake_root')
    return b:rake_root
  elseif exists('b:git_dir')
    return fnamemodify(b:git_dir, ':p:h:h')
  endif
endfunction

nmap ,tt :execute 'CommandT ' . fnameescape(g:ProjectRoot())<CR>
nmap ,tb :CommandTBuffer<CR>

" ,> ,< is next or prev error
nmap ,> :lnext<CR>
nmap ,< :lNext<CR>

" "" is List contents of all registers (that typically contain pasteable text).
nnoremap <silent> "" :registers "0123456789abcdefghijklmnopqrstuvwxyz*+.<CR>

" \hash Convert hash to Ruby 1.9's JSON-like style
nmap <Leader>hash :%s/\%(\w\|:\)\@1<!:\(\w\+\) *=> */\1: /gce<CR>
vmap <Leader>hash :s/\%(\w\|:\)\@1<!:\(\w\+\) *=> */\1: /gce<CR>

" \ftu \ftg Convert to UTF-8, Convert to GBK
nmap <Leader>ftu   :set fenc=utf8<CR>:w<CR>
nmap <Leader>ftg   :set fenc=gbk<CR>:w<CR>

" \str Convert double quotation string to single quotation
nmap <Leader>str :%s/[\\]\@<!\(["]\)\(\(\(#{\)\@<![^"]\)\+\)\1/'\2'/gce<CR>
vmap <Leader>str :s/[\\]\@<!\(["]\)\(\(\(#{\)\@<![^"]\)\+\)\1/'\2'/gce<CR>

" \sym String to Symbol for Ruby
nmap <Leader>sym :%s/[\\]\@<!\(['"]\)\([0-9A-Za-z_$]\+\)\1/:\2/gce<CR>
vmap <Leader>sym :s/[\\]\@<!\(['"]\)\([0-9A-Za-z_$]\+\)\1/:\2/gce<CR>

" Don't use Ex mode, use Q for formatting
nmap Q gq

" Emacs-style editing on the command-line
" start of line
cnoremap <C-A>         <Home>
" back one character
cnoremap <C-B>         <Left>
" delete character under cursor
cnoremap <C-D>         <Del>
" end of line
cnoremap <C-E>         <End>
" forward one character
cnoremap <C-F>         <Right>
" recall newer command-line
cnoremap <C-N>         <Down>
" recall previous (older) command-line
cnoremap <C-P>         <Up>
" back one word
cnoremap <Esc><C-B>    <S-Left>
" forward one word
cnoremap <Esc><C-F>    <S-Right>
" ....................................................................... }}}1

" Diff mode key mappings  ............................................... {{{1
"
" Use <C-J/K> to move cursor between diff chunks
nnoremap <expr> <C-J> &diff ? ']c' : '<C-W>j'
nnoremap <expr> <C-K> &diff ? '[c' : '<C-W>k'
" ....................................................................... }}}1

" Close various informative/minor window with `q`  ...................... {{{1
"
" Close left window (original file) in diff mode
nnoremap <expr> q &diff ? '<C-W>h:q<CR>' : 'q'
" Close Vim help window
autocmd FileType help nnoremap <buffer> q :q<CR>
" ....................................................................... }}}1

" vim: set fdm=marker fdl=0:
