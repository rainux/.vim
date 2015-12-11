" Rainux's .vimrc file
"
" Maintainer: Rainux <rainux@gmail.com>
" URL:        http://github.com/rainux/.vim

source ~/.vim/neobundle.vim

" Multi-encoding setting
function! s:MultiEncodingSetting()
  if has('multi_byte')
    set fileencodings=ucs-bom,utf-8,chinese

    if &fileencoding == ''
      let can_set_fenc = 1
    else
      let can_set_fenc = 0
    endif

    " CJK environment detection and corresponding setting
    if v:lang =~ '^zh_CN'
      " Simplified Chinese, on Unix euc-cn, on MS-Windows cp936
      set encoding=chinese
      set termencoding=chinese
      if can_set_fenc
        set fileencoding=chinese
      endif
    elseif v:lang =~ '^zh_TW'
      " Traditional Chinese, on Unix euc-tw, on MS-Windows cp950
      set encoding=taiwan
      set termencoding=taiwan
      if can_set_fenc
        set fileencoding=taiwan
      endif
    elseif v:lang =~ '^ja_JP'
      " Japanese, on Unix euc-jp, on MS-Windows cp932
      set encoding=japan
      set termencoding=japan
      if can_set_fenc
        set fileencoding=japan
      endif
    elseif v:lang =~ '^ko'
      " Korean on Unix euc-kr, on MS-Windows cp949
      set encoding=korea
      set termencoding=korea
      if can_set_fenc
        set fileencoding=korea
      endif
    endif

    " Detect UTF-8 locale, and override CJK setting if needed
    if v:lang =~ 'utf8$' || v:lang =~ 'UTF-8$'
      set encoding=utf-8
      if has('unix')
        " Only use UTF-8 termencoding when we're in Linux/Unix, cause Windows
        " does not support UTF-8. Mac? I don't know :p
        set termencoding=utf-8
      end
      if can_set_fenc
        set fileencoding=utf-8
      endif
      set ambiwidth=double
    endif
  else
    echoerr 'Sorry, this version of (g)Vim was not compiled with "multi_byte"'
  endif
endfunction


" Toggle indent style smartly
function! s:ToggleIndentStyle(...)
  if a:0
    if a:1 == 8
      " Do not show ugly tab chars for indent with 8
      setlocal nolist noexpandtab softtabstop=4 shiftwidth=4 tabstop=4
      " Only display message when called by ,i
      if a:0 > 1
        echo 'Indent style changed to noexpandtab'
      endif
    else
      execute 'setlocal expandtab softtabstop=' . a:1 . ' shiftwidth=' . a:1
      setlocal list tabstop=8
      if a:0 > 1
        echo 'Indent style changed to expandtab with ' . a:1 . ' spaces'
      endif
    endif
  else

    if &expandtab
      let b:previous_indent_width = &shiftwidth
      call s:ToggleIndentStyle(8, 1)
    else
      if !exists('b:previous_indent_width')
        let b:previous_indent_width = 4
      endif
      call s:ToggleIndentStyle(b:previous_indent_width, 1)
    endif
  endif
endfunction


" ----------------------------------------------------------------------------
" Initialization
" Commands only execute in Vim initialization
"
function! s:VimInit()
  set nocompatible
  call s:MultiEncodingSetting()
  source $VIMRUNTIME/mswin.vim
  behave xterm
  " Restore CTRL-A to increase number instead of Select All
  unmap <C-A>
  " Restore CTRL-S to nop (will be used by vim-surround) instead of Save
  iunmap <C-S>
endfunction

" When Vim is booting, the winpos information is not available
if getwinposx() == -1
  call s:VimInit()
endif


" ----------------------------------------------------------------------------
" Primary settings
"

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has('gui_running')
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has('autocmd')

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    autocmd!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    autocmd FileType c compiler gcc
    autocmd FileType d compiler dmd
    autocmd FileType ruby,eruby
          \ setlocal omnifunc=rubycomplete#Complete |
          \ setlocal tags+=~/.gem/tags |
          \ setlocal iskeyword+=:,?,! |

    let s:indent2_regex = '^\%(cucumber\|e\=ruby\|[yh]aml\|delphi\|x\=html\|javascript\|coffee\|lisp\|nsis\|sass\|slim\|vim\|puppet\)$'
    let s:indent8_regex = '^\%(css\|gitconfig\|go\|taskpaper\)$'

    function! s:BufEnter()
      " Set indent style for diffent file type
      if &ft =~ s:indent2_regex
        call s:ToggleIndentStyle(2)
      elseif &ft =~ s:indent8_regex
        call s:ToggleIndentStyle(8)
      else
        call s:ToggleIndentStyle(4)
      endif

      " Change to directory of current file automatically when current file is not
      " on remote server nor inside an archive file like .zip/.tgz
      if bufname('%') !~ '::\|://'
        lcd %:p:h
      endif
    endfunction

    autocmd BufEnter * call s:BufEnter()

    " Apply file template if it exists
    autocmd BufNewFile *.*
          \ if &modifiable |
          \   set ff=unix |
          \   let s:Template = expand('~/.template/template.' . substitute(bufname('%'), '.\{-\}\.*\([^.]*\)$', '\1', '')) |
          \   if filereadable(s:Template) |
          \     execute '0read ' . s:Template |
          \     normal Gdd |
          \   endif |
          \ endif |

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line('$') |
          \   execute 'normal g`"' |
          \ endif |

    " Don't screw up folds when inserting text that might affect them, until
    " leaving insert mode. Foldmethod is local to the window. Protect against
    " screwing up folding when switching between windows.
    autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
    autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
  augroup END
endif


" ----------------------------------------------------------------------------
" My customizations
"
" Set options
set autoindent
set background=dark
set backspace=indent,eol,start
set colorcolumn=120
set completeopt=menuone,longest,preview
set directory=~/.vim/tmp,/var/tmp,/tmp
set fileformats=unix,dos
set foldcolumn=4
set foldlevelstart=99
set foldmethod=indent
set guicursor=a:blinkon0
set guioptions-=m " Remove menu
set guioptions-=r " Remove scrollbar
set guioptions-=T " Remove toolbar
set grepprg=grep\ -nH\ $*
set helplang=CN
set history=50
set ignorecase smartcase smartcase
set incsearch
set laststatus=2
set linebreak
set list
set listchars=tab:>-,trail:-,nbsp:%
set modeline
set number
set ruler
set showbreak=>>
set shellslash
set showcmd
set smartindent
set ttimeoutlen=50
if v:version >= 703
  set undodir=~/.vim/undodir
  set undofile
endif
set viminfo=!,'1000,<100,c,f1,h,s10,rA:,rB:,n~/.viminfo
set virtualedit=block
set visualbell
set wildmenu
set wildmode=list:longest,full

set diffopt=filler,iwhite
set diffexpr=MyDiff()
function! MyDiff()
  let opt = ' -a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let diffprg = $VIMRUNTIME . '/diff'
  if !executable(diffprg)
    let diffprg = 'diff'
  endif
  silent execute '!' . diffprg . opt . arg1 . ' ' . arg2 . ' > ' . arg3
endfunction

set foldtext=MyFoldText()
function! MyFoldText()
  let foldtext = substitute(foldtext(), '\s\+\d\+\s\+lines:\s\+', ' ', 'g')
  return foldtext
endfunction

" Force read viminfo
try
  rviminfo ~/.viminfo
catch
endtry

color desert-warm-256


" ----------------------------------------------------------------------------
" Key mappings
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
map ,nf :NERDTreeFind<CR>

" ,p is Toggle spell check
map ,p :set spell!<CR>

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

" ,ag is Search in files via ag
nmap ,ag :execute 'Ag! ' . input("Ag search for pattern: ", "<C-R><C-W>") . ' ' . g:ProjectRoot()<CR>

" ,vi is :BundleInstall
nmap ,vi :BundleInstall<CR>

" ,vs is :BundleSearch
nmap ,vs :BundleSearch<Space>

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
nmap ,s :source $HOME/.vimrc<CR>
nmap ,v :tabe $HOME/.vim/.vimrc<CR>

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
nmap ,> :cnext<CR>
nmap ,< :cNext<CR>

" \idate \itime Insert current date & time
nmap <Leader>idate :call <SID>InsertDate(0)<CR>
nmap <Leader>itime :call <SID>InsertDate(1)<CR>

function! s:InsertDate(Also_Time)
  let Fmt = '%x'
  if a:Also_Time
    let Fmt .= ' %X'
  endif
  let Time = strftime(Fmt)
  execute 'normal a' . Time
endfunction

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


" ----------------------------------------------------------------------------
" Configurations for plugins
"
" std_c
let c_syntax_for_h = 1
let c_C94 = 1
let c_C99 = 1
let c_cpp = 1
let c_warn_8bitchars = 1
let c_warn_multichar = 1
let c_warn_digraph = 1
let c_warn_trigraph = 1
let c_no_octal = 1

let c_comment_strings = 1
let c_comment_numbers = 1
let c_comment_types = 1
let c_comment_date_time = 1


" rubycomplete
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
let g:rubycomplete_rails_proactive = 1


" ruby syntax
let g:ruby_fold = 1
let g:ruby_minlines = 200
let g:ruby_operators = 1


" NERD commenter
let g:NERDDefaultNesting = 1
let g:NERDShutUp = 1
let g:NERDSpaceDelims = 1


" vcscommand
nmap <Leader>va <Plug>VCSAdd
nmap <Leader>vn <Plug>VCSAnnotate
nmap <Leader>vG <Plug>VCSClearAndGotoOriginal
nmap <Leader>vc <Plug>VCSCommit
nmap <Leader>vD <Plug>VCSDelete
nmap <Leader>vd <Plug>VCSDiff
nmap <Leader>vg <Plug>VCSGotoOriginal
nmap <Leader>vi <Plug>VCSInfo
nmap <Leader>vL <Plug>VCSLock
nmap <Leader>vl <Plug>VCSLog
nmap <Leader>vq <Plug>VCSRevert
nmap <Leader>vr <Plug>VCSReview
nmap <Leader>vs <Plug>VCSStatus
nmap <Leader>vU <Plug>VCSUnlock
nmap <Leader>vu <Plug>VCSUpdate
nmap <Leader>vv <Plug>VCSVimDiff


" surround
"
" Work with gettext easier
let g:surround_45 = "_('\r')"
let g:surround_95 = "_(\"\r\")"


" speeddating
let g:speeddating_no_mappings = 1
nmap  <C-A>     <Plug>SpeedDatingUp
nmap  <C-X>     <Plug>SpeedDatingDown
nmap d<C-A>     <Plug>SpeedDatingNowUTC
nmap d<C-X>     <Plug>SpeedDatingNowLocal


" Tagbar
let g:tagbar_type_coffee = {
      \ 'ctagstype': 'CoffeeScript',
      \ 'kinds': [
      \   'c:class',
      \   'f:function',
      \   'v:variable',
      \ ],
      \ 'sort': 0
      \ }


" po.vim
let maplocalleader = ','


" Netrw
let g:netrw_home = expand('~/.vim/tmp')


" airline
let g:airline#extensions#default#section_truncate_width = {
  \ 'y': 120
  \ }
call airline#parts#define_function('filesize', 'GetFileSize')
call airline#parts#define_function('charcode', 'GetCharCode')
function! GetFileSize() " {{{
	let bytes = getfsize(expand("%:p"))

	if bytes <= 0
		return ''
	endif

	if bytes < 1024
		return bytes . 'B'
	else
		return (bytes / 1024) . 'kB'
	endif
endfunction "}}}
function! GetCharCode() " {{{
	" Get the output of :ascii
	redir => ascii
	silent! ascii
	redir END

	if match(ascii, 'NUL') != -1
		return 'NUL'
	endif

	" Zero pad hex values
	let nrformat = '0x%02x'

	let encoding = (&fenc == '' ? &enc : &fenc)

	if encoding == 'utf-8'
		" Zero pad with 4 zeroes in unicode files
		let nrformat = '0x%04x'
	endif

	" Get the character and the numeric value from the return value of :ascii
	" This matches the two first pieces of the return value, e.g.
	" "<F>  70" => char: 'F', nr: '70'
	let [str, char, nr; rest] = matchlist(ascii, '\v\<(.{-1,})\>\s*([0-9]+)')

	" Format the numeric value
	let nr = printf(nrformat, nr)

	return "'". char ."' ". nr
endfunction "}}}
function! AirlineInit()
  let g:airline_section_y = airline#section#create(['charcode', ' | ', 'filesize', ' | ', 'ffenc', ' | ', 'sts:%{&sts}:sw:%{&sw}:ts:%{&ts}:tw:%{&tw}'])
endfunction
autocmd VimEnter * call AirlineInit()


" neocomplcache
"
" Launches neocomplcache automatically on vim startup.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underscore completion.
let g:neocomplcache_enable_underbar_completion = 1
" Sets minimum char length of syntax keyword.
let g:neocomplcache_min_syntax_length = 3
" buffer file name pattern that locks neocomplcache. e.g. ku.vim or fuzzyfinder
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define file-type dependent dictionaries.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default': '',
    \ 'vimshell': $HOME.'/.vimshell_hist',
    \ 'scheme': $HOME.'/.gosh_completions'
    \ }

" Define keyword, for minor languages
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
" inoremap <expr><CR>   neocomplcache#smart_close_popup()."\<CR>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()


" neosnippet
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

let g:neosnippet#snippets_directory = '~/.vim/bundle/vim-snippets/snippets'

let g:rails_projections = {
      \ 'app/uploaders/*_uploader.rb': {
      \   'command': 'uploader',
      \   'template':
      \     'class %SUploader < CarrierWave::Uploader::Base\nend',
      \   'test': [
      \     'test/unit/%s_uploader_test.rb',
      \     'spec/models/%s_uploader_spec.rb'
      \   ],
      \   'keywords': 'process version'
      \ },
      \ 'app/workers/*_worker.rb': {'command': 'worker'},
      \ 'features/support/*.rb': {'command': 'support'},
      \ 'features/support/env.rb': {'command': 'support'},
      \ 'spec/factories/*.rb': {'command': 'factory'}
      \ }


" Rnavcommand decorator app/decorators      -glob=**/*  -suffix=_decorator.rb
" Rnavcommand presenter app/presenters      -glob=**/*  -suffix=_presenter.rb
" Rnavcommand coffee    app/coffeescripts   -glob=**/*  -suffix=.coffee
" Rnavcommand sass      app/stylesheets     -glob=**/*  -suffix=.sass
" Rnavcommand scss      app/stylesheets     -glob=**/*  -suffix=.scss
" Rnavcommand factory   spec/factories      -glob=*     -default=controller()

" Rnavcommand feature     features                  -glob=**/*    -suffix=.feature
" Rnavcommand steps       features/step_definitions -glob=**/*    -suffix=_steps.rb
" Rnavcommand support     features/support          -glob=*
" Rnavcommand specsupport spec/support              -glob=**/*


" vim-turbux
let g:turbux_command_prefix = 'spring'


" vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

au FileType go nmap <Leader>r <Plug>(go-run)
au FileType go nmap <Leader>b <Plug>(go-build)
au FileType go nmap <Leader>tg <Plug>(go-test)
au FileType go nmap <Leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>e <Plug>(go-rename)


" vim go syntax
let g:go_highlight_trailing_whitespace_error = 0


let g:markdown_fenced_languages = ['html', 'css', 'ruby', 'erb=eruby', 'python', 'bash=sh', 'yaml']


" TODO: Re-oganize mappings to keymap.vim and keep them sorted

" "" is List contents of all registers (that typically contain pasteable text).
nnoremap <silent> "" :registers "0123456789abcdefghijklmnopqrstuvwxyz*+.<CR>

" vim: set sts=2 sw=2:
