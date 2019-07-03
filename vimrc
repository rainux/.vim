" Rainux's .vimrc file
"
" Maintainer: Rainux <rainux@gmail.com>
" URL:        http://github.com/rainux/.vim

source ~/.vim/plugs.vim

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
  source ~/.vim/mswin.vim
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

    let s:indent2_types = [
          \ 'cucumber', 'eruby', 'ruby', 'yaml', 'slim', 'haml', 'sass', 'delphi', 'html', 'xhtml',
          \ 'javascript', 'javascript.jsx', 'json', 'coffee', 'lisp', 'nsis', 'vim', 'puppet', 'scala'
          \ ]
    let s:indent8_types = ['css', 'gitconfig', 'go', 'taskpaper']

    function! s:BufEnter()
      " Set indent style for diffent file type
      if index(s:indent2_types, &ft) >= 0
        call s:ToggleIndentStyle(2)
      elseif index(s:indent8_types, &ft) >= 0
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
set termguicolors
set ttimeout
set timeoutlen=200
if v:version >= 703
  set undodir=~/.vim/undodir
  set undofile
endif
if has('nvim')
  set viminfo=!,'1000,<100,c,f1,h,s10
else
  set viminfo=!,'1000,<100,c,f1,h,s10,n~/.viminfo
end
set virtualedit=block
set visualbell
set wildmenu
set wildmode=list:longest,full

set diffopt=filler,iwhite,vertical

set foldtext=MyFoldText()
function! MyFoldText()
  let foldtext = substitute(foldtext(), '\s*\d\+\s\+lines:\s\+', ' ', 'g')
  return foldtext
endfunction

" Force read viminfo to ensure font settings get loaded on Windows
if !has('nvim')
  try
    rviminfo ~/.viminfo
  catch
  endtry
end

source ~/.vim/key_mappings.vim
source ~/.vim/config_plugs.vim
source ~/.vim/setcolors.vim
