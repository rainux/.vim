" ----------------------------------------------------------------------------
" Key mappings
"
" Navigate in content and command line  ................................. {{{1
"
" Up & Down   Navigate display line upward & downward
map <Up> gk
map <Down> gj
imap <Up> <Esc><Up>a
imap <Down> <Esc><Down>a

" Emacs-style editing on the command-line
"
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

" Navigate between windows and tabs  .................................... {{{1
"
" CTRL-[JKHL] Jump between windows
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l

" CTRL-Tab        Next tab
map <C-Tab> gt
imap <C-Tab> <Esc>gt
cmap <C-Tab> <Esc>gt

" CTRL-SHIFT-Tab  Previous tab
map <C-S-Tab> gT
imap <C-S-Tab> <Esc>gT
cmap <C-S-Tab> <Esc>gT

" ALT/⌘-[1-9]   Switch to specified tab
for i in [1, 2, 3, 4, 5, 6, 7, 8, 9]
  execute 'map <M-' . i . '> ' . i . 'gt'
  execute 'imap <M-' . i . '> <Esc>' . i . 'gt'
  execute 'cmap <M-' . i . '> <Esc>' . i . 'gt'
endfor
" ....................................................................... }}}1

" Essential toggles  .................................................... {{{1
"
" ,is   Toggle indent style smartly
map ,is :call g:ToggleIndentStyle()<CR>
" ,ig   Toggle indent guides
map ,ig :IndentGuidesToggle<CR>
" ,k    Toggle iskeyword contain or not contain '_'
map ,k  :call <SID>ToggleIsKeyword('_')<CR>
function! s:ToggleIsKeyword(char) " ..................................... {{{2
  if stridx(&iskeyword, a:char) < 0
    exec 'setlocal iskeyword+=' . a:char
    echo '&iskeyword now contain "' . a:char . '"'
  else
    exec 'setlocal iskeyword-=' . a:char
    echo '&iskeyword now not contain "' . a:char . '"'
  endif
endfunction " ........................................................... }}}2
" ,hs   Toggle hlsearch
map ,hs :set hlsearch!<CR>
" ,sp   Toggle spell check
map ,sp :set spell!<CR>
" ,nt   Toggle NERDTreeTabs
map ,nt :NERDTreeTabsToggle<CR>
" ,nf   NERDTreeFind
map ,nf :NERDTreeTabsFind<CR>
" ,tl   Toggle Tagbar
map ,tl :TagbarToggle<CR>

" ,fo   Cycle GUI font
" ,fi   Cycle GUI font in inverse order
" ,w    Toggle wrap
" Code moved to gvimrc
" ....................................................................... }}}1

" Search & Replace  ..................................................... {{{1
"
" ,*    Substitute(Replace)
nmap ,* :%s/<C-R><C-W>/
" ,rg   Search in files via rg
nmap ,rg :execute 'Rg ' . input("Rg search for pattern: ", "<C-R><C-W>")<CR>
" ,fz   Fuzzy find files in current project
nmap ,fz :execute 'FZF '.projectionist#path()<CR>
" ,fb   Fuzzy find open buffers
nmap ,fb :Buffers<CR>
" ,cl   Change colorscheme via fzf.vim
nmap ,cl :Colors<CR>
" ....................................................................... }}}1

" General text editing  ................................................. {{{1
"
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" ....................................................................... }}}1

" Work with code  ....................................................... {{{1

" ,sr     Compile and Run with SingleCompile
nmap ,sr  :SCCompileRun<CR>
" ,sc     Compile with SingleCompile
nmap ,sc  :SCCompile<CR>

" ,cw ,cq   Open and close quickfix window
nmap ,cw  :cwindow<CR>
nmap ,cq  :cclose<CR>
" ,lw ,lq   Open and close location window
nmap ,lw  :lwindow<CR>
nmap ,lq  :lclose<CR>
" ,, ,. ,m  Jump to current, next or prev error in quickfix list
nmap ,, :cc<CR>
nmap ,. :cnext<CR>
nmap ,m :cNext<CR>
" ,< ,> ,M  Jump to current, next or prev error in location list
nmap ,< :ll<CR>
nmap ,> :lnext<CR>
nmap ,M :lNext<CR>

" ""  List contents of all registers (that typically contain pasteable text).
nnoremap <silent> "" :registers "0123456789abcdefghijklmnopqrstuvwxyz*+.<CR>

" Don't use Ex mode, use Q for formatting
nmap Q gq
" ,ff   Format code
nmap ,ff :set ff=unix<CR>:%!fromdos<CR>gg=G:%s/\s\+$//ge<CR>
" ,fc   Clean code
nmap ,fc :set ff=unix<CR>:%!fromdos<CR>:%s/\s\+$//ge<CR>
" \ftu  Convert to UTF-8
nmap <Leader>ftu   :set fenc=utf8<CR>:w<CR>
" \ftg  Convert to GBK
nmap <Leader>ftg   :set fenc=gbk<CR>:w<CR>

" \str  Convert double quotation string to single quotation
nmap <Leader>str :%s/[\\]\@<!\(["]\)\(\(\(#{\)\@<![^"]\)\+\)\1/'\2'/gce<CR>
vmap <Leader>str :s/[\\]\@<!\(["]\)\(\(\(#{\)\@<![^"]\)\+\)\1/'\2'/gce<CR>
" \sym  String to Symbol for Ruby
nmap <Leader>sym :%s/[\\]\@<!\(['"]\)\([0-9A-Za-z_$]\+\)\1/:\2/gce<CR>
vmap <Leader>sym :s/[\\]\@<!\(['"]\)\([0-9A-Za-z_$]\+\)\1/:\2/gce<CR>
" \hash Convert hash to Ruby 1.9's JSON-like style
nmap <Leader>hash :%s/\%(\w\|:\)\@1<!:\(\w\+\) *=> */\1: /gce<CR>
vmap <Leader>hash :s/\%(\w\|:\)\@1<!:\(\w\+\) *=> */\1: /gce<CR>

" NERD Commenter mappings
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
" ....................................................................... }}}1

" Rust development  ..................................................... {{{1
"
" To work with a Rust project, it's more conveninent to create a global
" mapping instead of buffer local mapping.
au FileType rust map ,cb :VimuxRunCommand 'cargo bench'<CR>
au FileType rust map ,b  :Make build<CR>
au FileType rust map ,r  :CargoRun<CR>
au FileType rust map ,ri :VimuxInterruptRunner<CR>
au FileType rust map ,rp :VimuxRunCommand 'cargo run -- '<C-B>
au FileType rust map ,rl :VimuxRunLastCommand<CR>
au FileType rust map ,ta :CargoTestAll<CR>
au FileType rust map ,tb :CargoUnitTestCurrentFile<CR>
au FileType rust map ,tf :CargoUnitTestFocused<CR>
" ....................................................................... }}}1

" Work with vim configurations  ......................................... {{{1
"
" ,vs   Reload vimrc
nmap ,vs  :source $HOME/.vim/vimrc<CR>:source $HOME/.vim/gvimrc<CR>
" ,vev  Edit vimrc in new tab
nmap ,vev :tabe $HOME/.vim/vimrc<CR>
" ,vev  Edit plugs.vim in new tab
nmap ,vep :tabe $HOME/.vim/plugs.vim<CR>
" ,pi   Install plugs defined in plugs.vim
nmap ,pi  :source $HOME/.vim/plugs.vim<CR>:PlugInstall<CR>
" ,pc   Clean uninstalled/invalid plugs
nmap ,pc  :source $HOME/.vim/plugs.vim<CR>:PlugClean<CR>
" ,pu   Upgrade plugs and vim-plug
nmap ,pu  :source $HOME/.vim/plugs.vim<CR>:PlugUpdate<CR>:PlugUpgrade<CR>
" ,ph   Get help of plugs
nmap ,ph  :PlugHelp<CR>
" ....................................................................... }}}1

" Git related keymappings  .............................................. {{{1
"
" vim-fugitive
nmap ,gac :Gcommit --amend --verbose<CR>
nmap ,gb  :Gblame<CR>
nmap ,gc  :Gcommit --verbose<CR>
nmap ,gd  :Gvdiff<CR>
nmap ,gi  :Gsplit! diff<CR><C-W>_
nmap ,gk  :Gsplit! diff --cached<CR><C-W>_
nmap ,gl  :Gllog<CR>
nmap ,ge  :Gedit<CR>
nmap ,gg  :Ggrep<Space>
nmap ,gr  :Gread<CR>
nmap ,gs  :Gstatus<CR>
nmap ,gw  :Gwrite<CR>

" vim-gitgutter
nmap zg   :GitGutterFold<CR>
nmap glh  :GitGutterLineHighlightsToggle<CR>
nmap glh  :GitGutterLineHighlightsToggle<CR>
nmap ]c   <Plug>GitGutterNextHunk
nmap [c   <Plug>GitGutterPrevHunk
nmap ghs  <Plug>GitGutterStageHunk
nmap ghu  <Plug>GitGutterUndoHunk
nmap ghp  <Plug>GitGutterPreviewHunk

" coc-git
" gci     Show chunk diff at current position
nmap gci  <Plug>(coc-git-chunkinfo)
" gcp     Show commit contains current position
nmap gcp  <Plug>(coc-git-commit)
" gsc     Show cached diff in preview window.
nmap gsc  :CocCommand git.diffCached<CR>
" ....................................................................... }}}1

" Diff mode key mappings  ............................................... {{{1
"
" <C-J/K>   Move cursor between diff chunks
nnoremap <expr> <C-J> &diff ? ']c' : '<C-W>j'
nnoremap <expr> <C-K> &diff ? '[c' : '<C-W>k'
" ....................................................................... }}}1

" Close various informative/minor window with `q`  ...................... {{{1
"
" Close left window (original file) in diff mode
nnoremap <expr> q &diff ? '<C-W>h:q<CR>' : 'q'
" Close Vim help window
autocmd FileType help nnoremap <buffer> q :q<CR>
" Close fugitive window
autocmd FileType fugitive,git,gitcommit nnoremap <buffer> q :q<CR>
" Close QuickFix & Location window
autocmd FileType qf nnoremap <buffer> q :q<CR>
" ....................................................................... }}}1

" Default mappings coming from plugins  ................................. {{{1
"
" CTRL-P            Open CtrlP prompt in find file mode
"
" \be \bt \bs \bv   Toogle Buffer Explorer in various way
"
" \cr \cc \cw       Lookup C reference manual provided by CRefVim
"
" \di \ds           Start/Stop DrawIt
"
" splitjoin.vim
" gS      Split a one-liner into multiple lines
" gJ      (with the cursor on the first line of a block) Join a block into a single-line statement

" vim-jdaddy
" gqaj    Pretty prints the JSON construct under the cursor.
" =       Use gqaj to pretty print JSON
au FileType json nmap <buffer> = gggqaj
au FileType json vmap <buffer> = <Esc>gggqaj

" taskpaper.vim
" \td     Mark task as done
" \tx     Mark task as cancelled
" \tt     Mark task as today
" \tD     Archive @done items
" \tX     Show tasks marked as cancelled
" \tT     Show tasks marked as today
" \t/     Search for items including keyword
" \ts     Search for items including tag
" \tp     Fold all projects
" \t.     Fold all notes
" \tP     Focus on the current project
" \tj     Go to next project
" \tk     Go to previous project
" \tg     Go to specified project
" \tm     Move task to specified project
"  ...................................................................... }}}1

" vim: set fdm=marker fdl=0:
